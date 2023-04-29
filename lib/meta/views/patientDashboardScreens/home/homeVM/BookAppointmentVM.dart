
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

class BookAppointmentVM {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  Future<String> getDoctorProfile({
    required String jwtData,
    required BuildContext context,
    required String doctorGuId,
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
        API + searchDoctorFiltersProfile +
        "?doctorGuId=" + doctorGuId);

    Utils utils = Utils();
    print('getDoctorProfile $uri');

    final http.Response response = await client.get(uri, headers: headers);
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> getAvailableSlots({
    required String jwtData,
    required BuildContext context,
    required String doctorGuId, required String timeZone, required String date,
  }) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    // DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.year, now.month, now.day);
    // DateTime newDate = new DateTime(date.year, date.month - 1, date.day);
    // print(newDate.toString().replaceAll("00:00:00.000", ""));
    // print(date.toString().replaceAll("00:00:00.000", ""));

    final Uri uri = Uri.parse(Baseurl +
        API + SlotsAvailable +  "?doctorGuId=" +doctorGuId +
        "&dateOfAppointment=" + date +
        "&timeZone=" +
        Uri.encodeComponent(timeZone)
    );

    Utils utils = Utils();
    print('getAvailableSlots $uri');

    utils.showProgressDialog(context);

    final http.Response response = await client.get(uri, headers: headers);
    utils.dismissProgressDialog();

    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> bookAppointment({
    required String jwtData,
    required BuildContext context, required String appointmentDate, required String timeZone
  }) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    final Uri uri = Uri.parse(Baseurl + API + BookAppointmentDate +  "?appointmentDate=" + Uri.encodeComponent(appointmentDate) + "&timeZone=" + Uri.encodeComponent(timeZone)
    );

    Utils utils = Utils();

    utils.showProgressDialog(context);
    final http.Response response = await client.post(uri, headers: headers);
    utils.dismissProgressDialog();

    print('bookAppo :::${response.statusCode}  $uri');

    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
     rethrow;
    }
  }

  Future<String> rescheduleAppointment({
    required String jwtData,
    required BuildContext context, required String appointmentDate, required String timeZone
  }) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    final Uri uri = Uri.parse(Baseurl + API + rescheduleAppointmentDate +  "?appointmentDate=" + Uri.encodeComponent(appointmentDate) + "&timeZone=" + Uri.encodeComponent(timeZone)
    );

    Utils utils = Utils();

    utils.showProgressDialog(context);
    final http.Response response = await client.put(uri, headers: headers);
    utils.dismissProgressDialog();

    print('bookAppo :::${response.statusCode}  $uri');

    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> bookAppointmentReason({
    required String jwtData,
    required BuildContext context, required String appointmentReason,
  }) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    final Uri uri = Uri.parse(Baseurl + API + BookAppointmentReason +  "?appointmentReason=" + Uri.encodeComponent(appointmentReason));

    Utils utils = Utils();

    utils.showProgressDialog(context);
    final http.Response response = await client.post(uri, headers: headers);
    utils.dismissProgressDialog();

    print('bookAppo :::${response.statusCode}  $uri');

    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> bookAppointmentPayment({
    required String jwtData,
    required BuildContext context, required String appointmentGuId, required isReschedule, required String paymentDTO
  }) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    final Uri uri = Uri.parse(Baseurl + API + BookAppointmentPayment +  "?appointmentGuId=" + appointmentGuId +'&paymentDTO=' +Uri.encodeComponent(paymentDTO) + '&isReschedule=' + isReschedule);

    Utils utils = Utils();

    final http.Response response = await client.post(uri, headers: headers);

    print('bookAppointmentReason :::${response.statusCode}  $uri');

    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

  Future<String> appointmentPreview({
    required String jwtData,
    required BuildContext context, required String appointmentGuId,  required String timeZone
  }) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    final Uri uri = Uri.parse(Baseurl + API + previewAppointment +  "?patientAppointmentGuId=" + appointmentGuId +'&timeZone=' +Uri.encodeComponent(timeZone));

    Utils utils = Utils();
  //  utils.showProgressDialog(context);
    final http.Response response = await client.get(uri, headers: headers);
    utils.dismissProgressDialog();

    print('appointmentPreview :::${response.statusCode}  $uri');

    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    }
  }

}