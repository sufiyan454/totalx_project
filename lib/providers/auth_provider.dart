

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  final widgetId = "366344666530333131333933";
  final authKey = "504412AGC294VgoD69ca10adP1";

  Future<void> sendOtp(String phone) async {
    await SendOtpFlutterSdk.sendOTP(
      phoneNumber: phone,
      widgetId: widgetId,
      authKey: authKey,
    );
  }

  Future<void> verifyOtp(String phone, String otp) async {
    final res = await SendOtpFlutterSdk.verifyOTP(
      phoneNumber: phone,
      otp: otp,
      widgetId: widgetId,
      authKey: authKey,
    );

    if (res['type'] == 'success') {
      isLoggedIn = true;
      notifyListeners();
    }
  }
}