import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../app/routes/api.routes.dart';
import '../../../../../utils/Utils/AppException.dart';
import '../../../../../utils/Utils/Utils.dart';

class MessagesVM {
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

    final Uri uri = Uri.parse(Baseurl + API + messages);

    Utils utils = Utils();
    print('getMessages $uri');

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

  Future<String> getDoctorPatientData({
    required String jwtData,
    required BuildContext context,
    required int pageNum,
    required int pageSize,
    required String patientGuId,
    required String doctorGuId,
  }) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else {
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    }

    final Uri uri = Uri.parse(Baseurl +
        API +
        DoctorPatientMessages +
        '?noOfMessages=' +
        pageNum.toString() +
        '&pageNumber=' +
        pageSize.toString() +
        '&patientGuId=' +
        patientGuId.toString() +
        '&doctorGuId=' +
        doctorGuId.toString());

    Utils utils = Utils();
    print('getDoctorPatientData $uri');

    // utils.showProgressDialog(context);
    final http.Response response = await client.get(uri, headers: headers);
    // utils.dismissProgressDialog();
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      throw SocketException('No Internet Connection');
    }
  }

  Future<String> getFiles(
      {required String jwtData,
      required BuildContext context,
      required String fileName}) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    final Uri uri = Uri.parse(Baseurl + API + files + '?fileName=' + fileName);

    Utils utils = Utils();
    print('getFiles $uri');

    utils.showProgressDialog(context);
    final http.Response response = await client.get(uri, headers: headers);
    utils.dismissProgressDialog();
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<String> updateMsgUiid(
      {required String jwtData,
      required BuildContext context,
      required String messageThreadGuId}) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);

    final Uri uri = Uri.parse(Baseurl +
        API +
        UpdateMsgUiid +
        '?messageThreadGuId=' +
        messageThreadGuId);

    Utils utils = Utils();
    print('updateMsgUiid $uri');

    // utils.showProgressDialog(context);
    final http.Response response = await client.put(uri, headers: headers);
    // utils.dismissProgressDialog();
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }
}
