import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/user_registration_otp_view/otpVM/OTPVM.dart';

import '../../../../core/services/cache.service.dart';
import '../../../../utils/Utils/Constants.dart';

class OTPNotifier extends ChangeNotifier {
  final OTPVM _otpAPI = OTPVM();
  final CacheService _cacheService = CacheService();

  Future validateOTP(
      {required BuildContext context,
      required String otpData,
      required firstName,
      required lastName, required timeZone}) async {
    try {
      print("data $otpData");
      print("timeZone $timeZone");
      String response = await _otpAPI.validateOTP(otpData: AES().encryptJSON(otpData), timeZone: AES().encryptJSON(timeZone), context : context);

      final Map<String, dynamic> parsedData = jsonDecode(response);
      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        Navigator.of(context).pushNamed(Doctorprofilepassword, arguments: {
          "firstName": firstName,
          "lastName": lastName,
          "email": decodedData["email"],
          "otp": decodedData["otp"]
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(parsedData["message"],
                style: const TextStyle(fontSize: 12))));
      }
    } on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
      notifyListeners();
  }

  Future mfa(
      {required BuildContext context,
      required String mfaData,
      required timeZone}) async {
    try {
      print("data $mfaData");
      print("timeZone $timeZone");
      String response = await _otpAPI.mfa(
          mfaData: AES().encryptJSON(mfaData),
          timeZone: AES().encryptJSON(timeZone),
          context: context);

      final Map<String, dynamic> parsedData = jsonDecode(response);
      if (parsedData["success"]) {
        _cacheService.writeCache(key: "jwtdata", value: parsedData['data']["accessToken"]).whenComplete(() {
          _cacheService.writeCache(key: isLogin, value: "true");
          Navigator.of(context).pushReplacementNamed(PatientDashboardScreen);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(parsedData["message"],
                style: const TextStyle(fontSize: 12))));
      }
    } on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
      notifyListeners();
  }

  Future sendOTP({required BuildContext context,
      required String email, required String screen}) async {
    try {
      String response = await _otpAPI.sendOTP(
          email: AES().encryptJSON(email), context : context);
      final Map<String, dynamic> parsedData = jsonDecode(response);
      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        print('decodedData : $decodedData');
        if(screen == 'Login'){
          Navigator.of(context).pushNamed(UserOtpRoute, arguments: [email]);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(parsedData["message"],
                style: const TextStyle(fontSize: 12))));
      }
    } on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
  }
    notifyListeners();


}
