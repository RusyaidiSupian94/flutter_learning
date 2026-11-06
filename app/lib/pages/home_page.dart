import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(
              Icons.cloud_done,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              user == null ? 'No user logged in yet.' : 'User : ${user.email ?? user.id}',
            )
          ]
        ),
      ),
    );
  }
}