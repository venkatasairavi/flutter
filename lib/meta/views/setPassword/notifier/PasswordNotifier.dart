
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/setPassword/passwordVM/PasswordVM.dart';

class PasswordNotifier extends ChangeNotifier{
  final PasswordVM _passwordAPI = PasswordVM();

  Future updatePassword(
      {required BuildContext context,
        required String useremail,
        required String userpassword,
        required userotp}) async {
    try {
      String encryptedData = AES().encryptJSON(jsonEncode({
        'email': useremail.trim(),
        'password': userpassword.trim(),
        'otp': userotp,
      }));

      await _passwordAPI.updatePassword(jsonData: encryptedData, context : context).then((value) async {
        final Map<String, dynamic> parsedData = await jsonDecode(value.toString());

        if (parsedData["success"]) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(parsedData["message"],
                  style: const TextStyle(fontSize: 12))));
          Navigator.of(context).pushNamed(LoginRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(parsedData["message"],
                  style: const TextStyle(fontSize: 12))));
        }
      });
    }  on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
  }
    notifyListeners();
}