import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/userregistrationview/registrationVM/RegistrationVM.dart';

class RegistrationNotifier extends ChangeNotifier {
  final RegistrationVM _doctorAPI = RegistrationVM();

  Future registerDoctor(
      {required BuildContext context, required String docData}) async {
    try {
      String encryptDocData = AES().encryptJSON(docData);
     // print(encryptDocData);
      var response = await _doctorAPI.registerDoctor(
          registerDoctor: encryptDocData, context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(response);
      print(parsedData);
      if (parsedData["success"]) {
        print(AES().decryptString(parsedData["data"]));
        var data = jsonDecode(docData);

        Navigator.of(context).pushNamed(UserOtpRoute,
            arguments: [data["email"], data["firstName"], data["lastName"]]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(parsedData["message"],
                style: const TextStyle(fontSize: 12))));
      }
    }  on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
      notifyListeners();
  }

  Future registerPatient(
      {required BuildContext context, required String docData}) async {
    try {
      String encryptDocData = AES().encryptJSON(docData);
      var response = await _doctorAPI.registerPatient (
          registerDoctor: encryptDocData, context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(response);
      print(parsedData);
      if (parsedData["success"]) {
        print(AES().decryptString(parsedData["data"]));
        var data = jsonDecode(docData);

        Navigator.of(context).pushNamed(UserOtpRoute,
            arguments: [data["email"], data["firstName"], data["lastName"]]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(parsedData["message"],
                style: const TextStyle(fontSize: 12))));
      }
    }  on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
      notifyListeners();
  }
}
