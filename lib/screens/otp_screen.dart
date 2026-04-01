import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> otp =
      List.generate(6, (_) => TextEditingController());

  int seconds = 59;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  String getOtp() => otp.map((e) => e.text).join();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 40),

            const Center(
              child: Icon(Icons.security, size: 100),
            ),

            const SizedBox(height: 30),

            const Text(
              "OTP Verification",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Enter the verification code we just sent to your number ${widget.phone}",
            ),

            const SizedBox(height: 20),

            
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (i) {
                return SizedBox(
                  width: 45,
                  child: TextField(
                    controller: otp[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ""),
                    onChanged: (v) {
                      if (v.isNotEmpty && i < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                "$seconds Sec",
                style: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: RichText(
                text: const TextSpan(
                  text: "Don't Get OTP? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Resend",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
                await auth.verifyOtp(widget.phone, getOtp());

                if (auth.isLoggedIn) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text("Verify",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
