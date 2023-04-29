

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

import 'dart:io';

class PasswordVM{
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  Future updatePassword(
      {required String jsonData, required BuildContext context}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        UpdatePassword +
        "?setPasswordDTO=" +
        Uri.encodeComponent(jsonData));

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