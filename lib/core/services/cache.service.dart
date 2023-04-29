import 'package:flutter/material.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<String?> readCache({required String key}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var cachedData = sharedPreferences.getString(key);
    return cachedData;
  }

  Future writeCache({required String key, required String value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  Future removeCache({required BuildContext context}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.getKeys().forEach((key) {
      if (
          key.contains("jwtdata") ||
          key.contains("isLogin") ||
          key.contains("status") ||
          key.contains("userId") ||
          key.contains("DocData") ||
          key.contains("userDetails")) sharedPreferences.remove(key);
    });

    if(sharedPreferences.get("userType")=="doctor"){
        Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginRoute, (Route<dynamic> route) => false,arguments: "doctor");
    }
    else{
        Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginRoute, (Route<dynamic> route) => false,arguments: "patient");
    }

    
  }
}
