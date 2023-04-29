
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

class DashboardVM {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  Future<String> getUserDetails(
      {required String jwtData, required BuildContext context}) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }

    Utils utils = Utils();

    Uri uri = Uri.parse(Baseurl + API + userDetails);
    print('getUserDetails $uri');

    try {
      final http.Response response = await client.post(uri, headers: headers);
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    }  on SocketException {
      rethrow;
    }
  }
}
