import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/doctor_profile_change_password_view/changepasswordVM/changepasswordVM.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/utils/Utils/Constants.dart';

class ChangePasswordNotifier extends ChangeNotifier {
  final ChangepasswordApi _changepasswordApi = ChangepasswordApi();
  final CacheService _cacheService = CacheService();

  Future changepassword(
      {required BuildContext context,
      required String oldpassword,
      required String newpassword}) async {
    try {
      String? userGuId = await _cacheService.readCache(key: "userGuId");
      String? email = await _cacheService.readCache(key: "email");
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      // String? isLoginValu =
      //     await _cacheService.removeCache(context: context, key: "isLogin");
      // print(userGuId);

      String encryptedData = AES().encryptJSON(jsonEncode({
        "userGuId": userGuId,
        "emailId": email,
        'oldPassword': oldpassword.trim(),
        'newPassword': newpassword.trim(),
      }));

      await _changepasswordApi
          .changepassword(
              data: encryptedData, jwtData: jwtData!, context: context)
          .then((value) async {
        final Map<String, dynamic> parsedData =
            await jsonDecode(value.toString());

        if (parsedData["success"]) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(parsedData["message"],
                  style: const TextStyle(fontSize: 12))));

          String? userType = await _cacheService.readCache(key: "userType");
          if (userType != null && userType == 'doctor') {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginRoute, (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
                PatientDashboardScreen, (Route<dynamic> route) => false);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(parsedData["message"],
                  style: const TextStyle(fontSize: 12))));
        }
      });
    }  on SocketException {
     
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }
}
