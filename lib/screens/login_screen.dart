import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phone = TextEditingController();
  bool sent = false;

  List<TextEditingController> otp =
      List.generate(6, (_) => TextEditingController());

  String getOtp() => otp.map((e) => e.text).join();

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

            const Icon(Icons.mobile_friendly, size: 100),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sent ? "OTP Verification" : "Enter Phone Number",
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: phone,
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

            const SizedBox(height: 20),

            if (sent)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  return SizedBox(
                    width: 45,
                    child: TextField(
                      controller: otp[i],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: const InputDecoration(counterText: ""),
                    ),
                  );
                }),
              ),

            const SizedBox(height: 10),

            if (sent)
              const Text("59 Sec", style: TextStyle(color: Colors.red)),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
                if (!sent) {
                  await auth.sendOtp(phone.text);
                  setState(() => sent = true);
                } else {
                  await auth.verifyOtp(phone.text, getOtp());

                  if (auth.isLoggedIn) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  }
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    sent ? "Verify" : "Get OTP",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}