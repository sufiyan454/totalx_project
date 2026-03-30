import 'package:flutter/material.dart';


class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;

  final String widgetId = "366344666530333131333933";
  final String authKey = "504412AGC294VgoD69ca10adP1";

  // Send OTP
  Future<void> sendOtp(String phone) async {
    try {
      final response = await SendOtpFlutterSdk().sendOTP(
        phoneNumber: phone,
        widgetId: widgetId,
        authKey: authKey,
      );

      debugPrint("Send OTP Response: $response");
    } catch (e) {
      debugPrint("Send OTP Error: $e");
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String phone, String otp) async {
    try {
      final response = await SendOtpFlutterSdk().verifyOTP(
        phoneNumber: phone,
        otp: otp,
        widgetId: widgetId,
        authKey: authKey,
        
      );

      debugPrint("Verify OTP Response: $response");

      if (response['type'] == 'success') {
        isLoggedIn = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Verify OTP Error: $e");
    }
  }
}