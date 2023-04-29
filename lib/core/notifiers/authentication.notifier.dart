import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/core/api/authentication.api.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  final CacheService _cacheService = CacheService();

/*
  Future login({required BuildContext context, required String useremail, required String userpassword}) async {
    try {
      await _authenticationAPI.login(useremail: useremail, userpassword: userpassword).then((value) async {
        final Map<String, dynamic> parsedData = await jsonDecode(value.toString());

        bool isAuthenticated = parsedData['success'];
        dynamic userData = parsedData['data'];

        if (isAuthenticated) {
          _cacheService
              .
              (key: "jwtdata", value: userData["accessToken"])
              .whenComplete(() {
            Navigator.of(context).pushNamed(HomeRoute);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(userData, style: const TextStyle(fontSize: 12))));
        }
      });
    } catch (error) {
      return (error);
    }
  }
*/

  Future updatePassword(
      {required BuildContext context,
      required String oldpassword,
      required String newpassword}) async {
    try {
      String? userGuId = await _cacheService.readCache(key: "userGuId");
      String? email = await _cacheService.readCache(key: "email");
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      String encryptedData = AES().encryptJSON(jsonEncode({
        "userGuId": userGuId,
        "emailId": email,
        'oldPassword': oldpassword.trim(),
        'newPassword': newpassword.trim(),
      }));

      await _authenticationAPI
          .updatePassword(data: encryptedData, jwtData: jwtData!)
          .then((value) async {
        final Map<String, dynamic> parsedData = await jsonDecode(value.toString());

        if (parsedData["success"]) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(parsedData["message"],
                  style: const TextStyle(fontSize: 12))));
          Navigator.of(context).pushNamed(HomeRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(parsedData["message"],
                  style: const TextStyle(fontSize: 12))));
        }
      });
    } catch (error) {
      return (error);
    }
  }
}
