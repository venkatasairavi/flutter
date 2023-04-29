
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/login/loginVM/LoginVM.dart';

import '../../../../utils/Utils/Constants.dart';

class LoginNotifier extends ChangeNotifier {
  final LoginVM _loginAPI = LoginVM();
  final CacheService _cacheService = CacheService();

  Future login(
      {required BuildContext context,
      required String useremail,
      required String userpassword,
      required String? userType,
      required bool rememberMe}) async {
    try {
      print("PRINTING USER DETAILS");
      print(useremail);
      print(userpassword);
      await _loginAPI.login(
              useremail: useremail,
              userpassword: userpassword,
              context: context,
              userType: userType).then((value) async {
        final Map<String, dynamic> parsedData = await jsonDecode(value.toString());

        bool isAuthenticated = parsedData['success'];
        dynamic userData = parsedData['data'];

        if (isAuthenticated) {
          _cacheService.writeCache(key: "email", value: useremail);
          _cacheService.writeCache(key: "password", value: userpassword);
          _cacheService.writeCache(
              key: "remember_me", value: rememberMe.toString());

          _navigateToDashboard(context, userData, useremail, userpassword);

          /* _cacheService.writeCache(key: "jwtdata", value: userData["accessToken"]).whenComplete(() {

          _cacheService.writeCache(key: isLogin, value: "true");
          });*/
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(userData, style: const TextStyle(fontSize: 12))));
        }
      });
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<void> _navigateToDashboard(BuildContext context, userData, String useremail, String userpassword) async {
    String? userType = await _cacheService.readCache(key: "userType");

    if (userType != null && userType == 'doctor') {
      await _cacheService.writeCache(key: "jwtdata", value: userData["accessToken"]).whenComplete(() async {
        await _cacheService.writeCache(key: isLogin, value: "true");
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeRoute, (Route<dynamic> route) => false);
      });
    } else if (userType == 'patient') {
      Navigator.of(context).pushNamed(UserOtpRoute, arguments: [useremail, userpassword, true]);
    }
  }

  notifyListeners();
}
