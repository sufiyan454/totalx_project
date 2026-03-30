import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totakx_project/providers/auth_provider.dart';

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
              onPressed: () async {
  final auth = Provider.of<AuthProvider>(context, listen: false);

  if (!sent) {
    await auth.sendOtp(phone.text);
    setState(() => sent = true);
  } else {
    await auth.verifyOtp(phone.text, otp.text);
  }
}
              child: Text(sent ? "Verify" : "Send OTP"),
            )
          ],
        ),
      ),
    );
  }
}