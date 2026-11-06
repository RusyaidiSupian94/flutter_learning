import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'register_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to logout'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report App'),
        actions: [
          if (user == null)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Login'),
            )
          else
            IconButton(
              tooltip: 'Logout',
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.assignment, size: 75, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Report App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              if (user == null) ...[
                const Text(
                  'You are browsing as a guest.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage()
                      ),
                    );
                  }, 
                  icon: const Icon(Icons.login), label: const Text('Login to your account'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Create New Account'),
                ),
              ] else ...[
                Text('Logged in as: ${user.email ?? user.id}'),
                const SizedBox(height: 20),
                const Text('You are successfully signed in.'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
