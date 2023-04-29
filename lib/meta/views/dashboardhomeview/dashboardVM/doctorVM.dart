import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';

import 'package:moibleapi/utils/Utils/Utils.dart';

import '../../../../core/services/cache.service.dart';

class DoctorApi {
  final client = http.Client();
  final CacheService _cacheService = CacheService();
  late Uri uri;

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

  Future<String> getDoctor(
      {required String jwtData, required BuildContext context}) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }
    String? userType = await _cacheService.readCache(key: "userType");

    if (userType != null && userType == 'doctor') {
      uri = Uri.parse(Baseurl + API + doctorDetails);
    } else if (userType != null && userType == 'patient') {
      uri = Uri.parse(Baseurl + API + patientDetails);
    }

    // print('getDoctor $uri');

    Utils utils = Utils();

    try {
      final http.Response response = await client.get(uri, headers: headers);
      dynamic responseJson = utils.returnResponse(response, context);

      return responseJson;
    } on SocketException {
      // throw const SocketException('No Internet Connection');
      rethrow;
    }
  }

  Future<String> setStatus(
      {required String jwtData,
      required String status,
      required BuildContext context}) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }
    Utils utils = Utils();
    try {
      Uri uri =
          Uri.parse(Baseurl + API + Doctor + Status + "?status=" + status);
      final http.Response response = await client.put(uri, headers: headers);
      // final body = response.body;
      // return body;
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> getUpcomingAppoitments(
      {required String jwtData,
      required String timeZone,
      required int pgNum,
      required String date,
      required String searchby,
      required BuildContext context}) async {
    // print("GET upcomming apptis called");
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }

    if (searchby.isNotEmpty) {
      uri = Uri.parse(Baseurl +
          API +
          doctorAppointments +
          doctorUpcomingAppointment +
          "?timeZone=" +
          Uri.encodeComponent(timeZone) +
          "&pageNumber=0" +
          "&pageSize=10" +
          "&date=" +
          date +
          "&search=" +
          searchby);
    } else {
      uri = Uri.parse(Baseurl +
          API +
          doctorAppointments +
          doctorUpcomingAppointment +
          "?timeZone=" +
          Uri.encodeComponent(timeZone) +
          "&pageNumber=" +
          pgNum.toString() +
          "&pageSize=10" +
          "&date=" +
          date);
    }
    Utils utils = Utils();

    print(uri);
    try {
      final http.Response response = await client.get(uri, headers: headers);

      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> getPatientHistory(
      {required String jwtData,
      required String timeZone,
      required String patientGuId,
      required int pgNum,
      required BuildContext context}) async {
    print("Get patiendt history called");
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }

    Uri uri = Uri.parse(Baseurl +
        API +
        doctorAppointments +
        patientHistory +
        "?patientGuId=" +
        patientGuId +
        "&timeZone=" +
        Uri.encodeComponent(timeZone) +
        "&pageNum=" +
        pgNum.toString() +
        "&pageSize=5");
    Utils utils = Utils();

    try {
      final http.Response response = await client.get(uri, headers: headers);
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> getUserDetails(
      {required String jwtData, required BuildContext context}) async {
    print("getUser details caled;.....");
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
    } on SocketException {
      rethrow;
    }
  }

  Future<String> startJoinVideoCall(
      {required String jwtData, required BuildContext context}) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }

    Utils utils = Utils();

    Uri uri = Uri.parse(Baseurl +
        API +
        joinVideoCall +
        '?appointmentId=' +
        "" +
        '&timeZone=' +
        '');
    print('startJoinVideoCall $uri');

    try {
      final http.Response response = await client.post(uri, headers: headers);
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }
}
