
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

class LoginVM {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  Future login(
      {required String useremail,
      required String userpassword,
      required BuildContext context,
      required String? userType}) async {
    String bodyData = AES().encryptJSON(jsonEncode({
      'emailId': useremail.trim(),
      'password': userpassword.trim(),
      'userType': userType
    }));

    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        Signin +
        "?loginRequestDTO=" +
        Uri.encodeComponent(bodyData));

    print('login $uri');

    Utils utils = Utils();

    utils.showProgressDialog(context);

    try {
      final http.Response response = await client.post(uri, headers: headers);
      utils.dismissProgressDialog();

      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }
}
