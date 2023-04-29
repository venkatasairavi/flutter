import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../app/routes/api.routes.dart';
import '../../../../../utils/Utils/AppException.dart';
import '../../../../../utils/Utils/Utils.dart';

class DocMessagesVM {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

  Future<String> getMessages({
    required String jwtData,
    required BuildContext context,
  }) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }
    // DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.year, now.month, now.day);
    // DateTime newDate = new DateTime(date.year, date.month - 1, date.day);
    // print(newDate.toString().replaceAll("00:00:00.000", ""));
    // print(date.toString().replaceAll("00:00:00.000", ""));

    final Uri uri = Uri.parse(Baseurl + API + patientmessages);

    Utils utils = Utils();
    //print('getMessages $uri');

   utils.showProgressDialog(context);
    final http.Response response = await client.get(uri, headers: headers);
    utils.dismissProgressDialog();
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    }
    on SocketException {
      rethrow;
    } 
  }
}
