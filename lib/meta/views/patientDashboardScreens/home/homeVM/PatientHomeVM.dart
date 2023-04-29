
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

class PatientHomeVM {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  Future<String> getUpcomingAppointments({
    required String jwtData,
    required String timeZone,
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

    final Uri uri = Uri.parse(Baseurl +
        API +
        upcomingAppointment +
        "?timeZone=" +
        Uri.encodeComponent(timeZone));

    Utils utils = Utils();
    print('UpcomingAppointments $uri');

    final http.Response response = await client.get(uri, headers: headers);
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> cancelAppointment({
    required String jwtData,
    required BuildContext context,
    required String patientAppointmentGuid,
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

    final Uri uri = Uri.parse(Baseurl +
        API +
        CancelAppointment +
        '?appointmentGuId=' +
        patientAppointmentGuid +
        '&cancelledBy=' +
        'PATIENT');

    Utils utils = Utils();
    print('cancelAppointment $uri');
    utils.showProgressDialog(context);

    final http.Response response = await client.put(uri, headers: headers);

    try {
      dynamic responseJson = utils.returnResponse(response, context);
      utils.dismissProgressDialog();

      return responseJson;
    }  on SocketException {
      throw SocketException('No Internet Connection');
    }
  }

  Future<String> updatePatientStatus({
    required String jwtData,
    required String timeZone,
    required BuildContext context,
    required String status,
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

    final Uri uri = Uri.parse(Baseurl +
        API +
        UpdatePatientStatus +
        "?status=" +
        Uri.encodeComponent(status));

    Utils utils = Utils();
    print('updatePatientStatus $uri');

    final http.Response response = await client.put(uri, headers: headers);
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    }  on SocketException {
     rethrow;
    }
  }

  Future<String> getPatientStatus({
    required String jwtData,
    required String timeZone,
    required BuildContext context,
    required String status,
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

    final Uri uri = Uri.parse(Baseurl + API + GetPatientStatus);

    Utils utils = Utils();
    print('updatePatientStatus $uri');

    final http.Response response = await client.get(uri, headers: headers);
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
     rethrow;
    }
  }

  Future<String> getDoctorFilters(
      {required String jwtData,
      required String filters,
      required BuildContext context}) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }
    final Uri uri = Uri.parse(Baseurl +
        API +
        searchDoctorFilters +
        "?searchRequest=" +
        Uri.encodeComponent(filters));

    print('getDoctorFilters $uri');

    Utils utils = Utils();
    // utils.showProgressDialog(context);

    try {
    final http.Response response = await client.get(uri, headers: headers);
  
    // utils.dismissProgressDialog();

    dynamic responseJson = utils.returnResponse(response, context);
    
    return responseJson;
    }  on SocketException  {
      rethrow;
    }
  }
}
