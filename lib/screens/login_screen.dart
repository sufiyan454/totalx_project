import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phone = TextEditingController();
  final otp = TextEditingController();

  bool sent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phone,
              decoration: const InputDecoration(hintText: "Phone"),
            ),
            if (sent)
              TextField(
                controller: otp,
                decoration: const InputDecoration(hintText: "OTP"),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text(sent ? "Verify" : "Send OTP"),
            )
          ],
        ),
      ),
    );
  }
}