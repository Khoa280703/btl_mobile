import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to HomePage using push()
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
