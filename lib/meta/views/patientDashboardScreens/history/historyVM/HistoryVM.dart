import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';


import '../../../../../utils/Utils/Utils.dart';

class HistoryVM {
  final client = http.Client();
  late Uri uri;

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

  Future getPatientHistoryList(
      {required String tz,
      required int pgNum,
      required String jwtData,
      required int pgSize,
      required BuildContext context,
      required String search,
      required String filterBy}) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }
    if (filterBy.isNotEmpty) {
      uri = Uri.parse(Baseurl +
          API +
          patientsAppointmentsHistory +
          "?timeZone=" +
          Uri.encodeComponent(tz) +
          "&pageNum=" +
          pgNum.toString() +
          "&pageSize=" +
          pgSize.toString() +
          '&sortBy=' +
          'date' +
          '&filterBy=' +
          filterBy);
    } else if (search.isNotEmpty) {
      uri = Uri.parse(Baseurl +
          API +
          patientsAppointmentsHistory +
          "?timeZone=" +
          Uri.encodeComponent(tz) +
          "&pageNum=0" +
          "&pageSize=" +
          pgSize.toString() +
          '&sortBy=' +
          'date' +
          '&search=' +
          search);
    } else {
      uri = Uri.parse(Baseurl +
          API +
          patientsAppointmentsHistory +
          "?timeZone=" +
          Uri.encodeComponent(tz) +
          "&pageNum=" +
          pgNum.toString() +
          "&pageSize=" +
          pgSize.toString() +
          '&sortBy=' +
          'date');
    }

    Utils utils = Utils();
    print('getPatientHistoryList $uri');

    final http.Response response = await client.get(uri, headers: headers);
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }
}
