import 'dart:io';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';

import '../../../../utils/Utils/AppException.dart';
import '../../../../utils/Utils/Utils.dart';

class ChangepasswordApi {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };
  Future changepassword(
      {required String data,
      required String jwtData,
      required BuildContext context}) async {
    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    final Uri uri = Uri.parse(Baseurl +
        API +
        User +
        changePassword +
        "?changePassword=" +
        Uri.encodeComponent(data));

    print('changepassword $uri');

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
