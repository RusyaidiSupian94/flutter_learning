using Npgsql;

var builder = WebApplication.CreateBuilder(args);

// Read Supabase connection URL from Codespaces secret
var supabaseURL = Environment.GetEnvironmentVariable("SUPABASE_DB_URL") 
    ?? throw new Exception("SUPABASE_DB_URL is not configured.");

// Convert Supabase PostgreSQL URI into Npgsql connection string
var supabaseUrl = new Uri(supabaseURL);
var credentials = supabaseUrl.UserInfo.Split(':', 2);

if (credentials.Length != 2)
{
    throw new Exception("Invalid DB database credentials. Ensure the SUPABASE_DB_URL is in the format: postgres://username:password@host:port/database");
}

var connectionString = new NpgsqlConnectionStringBuilder
{
    Host = supabaseUrl.Host,
    Port = supabaseUrl.Port,
    Username = Uri.UnescapeDataString(credentials[0]),
    Password = Uri.UnescapeDataString(credentials[1]),
    Database = supabaseUrl.AbsolutePath.TrimStart('/'),
    SslMode = SslMode.Require,
    //TrustServerCertificate = true
}.ConnectionString;

// Register PostgreSQL connection
builder.Services.AddSingleton(
    NpgsqlDataSource.Create(connectionString)
);

builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

//Test Supabase database connection
app.MapGet("/db-check", CheckDatabase);

// Existing weather forecast endpoint
var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild",
    "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast = Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast(
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();

    return forecast;
})
.WithName("GetWeatherForecast");

app.Run();

static async Task<IResult> CheckDatabase(NpgsqlDataSource dataSource)
{
    try
    {
        await using var connection = await dataSource.OpenConnectionAsync();

        await using var command = new NpgsqlCommand(
            "SELECT current_database(), current_user;",
            connection
        );

        await using var reader = await command.ExecuteReaderAsync();
        await reader.ReadAsync();

        return Results.Ok(new
        {
            status = "Connected",
            database = reader.GetString(0),
            user = reader.GetString(1)
        });
    }
    catch
    {
        return Results.Problem(
            "Supabase connection failed. Please check your database configuration."
        );
    }
}

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}

