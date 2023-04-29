import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import '../../../../utils/Utils/AppException.dart';
import '../../../../utils/Utils/Utils.dart';

class NotiferAPi {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

  Future<String> getNotifications({
    required String jwtData,
    required String timeZone,
    required int pageNum,
    required int pageSize,
    required BuildContext context,
  }) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }
    print(headers);
    // DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.year, now.month, now.day);
    // DateTime newDate = new DateTime(date.year, date.month - 1, date.day);
    // print(newDate.toString().replaceAll("00:00:00.000", ""));
    // print(date.toString().replaceAll("00:00:00.000", ""));
// print(Uri.parse(Baseurl +
//         API +
//         Notification +
//         "?timeZone=" +
//         Uri.encodeComponent(timeZone) +
//         "&ageNum=" +
//         pageNum.toString() +
//         "&pageSize=" +
//         pageSize.toString()));
    // ==============
    final Uri uri = Uri.parse(Baseurl +
        API +
        Notificationn +
        "?timeZone=" +
        Uri.encodeComponent(timeZone) +
        "&ageNum=" +
        pageNum.toString() +
        "&pageSize=" +
        pageSize.toString());

    Utils utils = Utils();
    // print('Notification $uri');

    final http.Response response = await client.get(uri, headers: headers);
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } 
    on UnauthorisedException {
      rethrow;
    }
    on SocketException {
      rethrow;
    }
  }
}
