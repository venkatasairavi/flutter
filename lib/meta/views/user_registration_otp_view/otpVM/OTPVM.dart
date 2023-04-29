

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

import 'dart:io';

class OTPVM{
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };
  Utils utils = Utils();

  Future<String> validateOTP(
      {required String otpData, required String timeZone, required BuildContext context}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        OTP +
        "?otpValidationDTO=" +
        Uri.encodeComponent(otpData) +
        "&timeZone=" +
        Uri.encodeComponent(timeZone));

    utils.showProgressDialog(context);

    print('validateOTP $uri');

    print(Uri.encodeComponent(await utils.timeZone()));

    try {
    final http.Response response = await client.post(uri, headers: headers);
    utils.dismissProgressDialog();

    dynamic responseJson = utils.returnResponse(response, context);
    return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> mfa(
      {required String mfaData, required String timeZone, required BuildContext context}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        MFA +
        "?loginRequestDTO=" +
        Uri.encodeComponent(mfaData) +
        "&timeZone=" +
        Uri.encodeComponent(timeZone));

    utils.showProgressDialog(context);

    print('mfa $uri');

    print(Uri.encodeComponent(await utils.timeZone()));

    try {
    final http.Response response = await client.post(uri, headers: headers);
    utils.dismissProgressDialog();

    dynamic responseJson = utils.returnResponse(response, context);
    return responseJson;
    } on SocketException {
     rethrow;
    }
  }

  Future<String> sendOTP(
      {required String email, required BuildContext context}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        SEND_OTP +
        "?email=" +
        Uri.encodeComponent(email));

    utils.showProgressDialog(context);

    print("sentOTP $uri");
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