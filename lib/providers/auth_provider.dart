import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;

  
  Future<void> sendOtp(String phone) async {
    debugPrint("OTP sent to $phone");
  }

  Future<void> verifyOtp(String phone, String otp) async {
    if (otp == "123456") {
      isLoggedIn = true;
      notifyListeners();
    } else {
      debugPrint("Invalid OTP");
    }
  }
}