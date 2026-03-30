import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🖼️ IMAGE (replace with asset if needed)
            const Icon(Icons.mobile_friendly, size: 100),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Phone Number",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 10),

            // 📱 PHONE INPUT
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "By Continuing, I agree to Terms & Conditions",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 30),

            // 🔘 GET OTP BUTTON
            GestureDetector(
              onTap: () async {
                await auth.sendOtp(phone.text);

                // 👉 GO TO OTP SCREEN
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OtpScreen(phone: phone.text),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    "Get OTP",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}