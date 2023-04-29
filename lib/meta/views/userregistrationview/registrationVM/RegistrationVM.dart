import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

class RegistrationVM {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  Future<String> registerDoctor(
      {required String registerDoctor, required BuildContext context}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        Register +
        "?signUpRequest=" +
        Uri.encodeComponent(registerDoctor));

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

  Future<String> registerPatient(
      {required String registerDoctor, required BuildContext context}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        PatientRegister +
        "?patientSignUpRequest=" +
        Uri.encodeComponent(registerDoctor));

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
