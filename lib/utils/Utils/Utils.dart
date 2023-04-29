import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moibleapi/meta/views/timeoutpopup.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class Utils {
  late ProgressDialog pr;

  Future<String> timeZone() async {
    final tz = await FlutterNativeTimezone.getLocalTimezone();
    return tz;
  }

  dynamic returnResponse(http.Response response, BuildContext context) {
    print("STATUS CODE_U :${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        print('Response : ${response.body}');
        final jsonResponse = json.decode(response.body);
        dynamic userData = jsonResponse['message'];
        if (userData != null) {}
        return response.body;
      case 400:
        final jsonResponse = json.decode(response.body);
        dynamic userData = jsonResponse['message'];
        if (userData != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.black,
              content: Text(userData, style: const TextStyle(fontSize: 12))));
        }
        throw BadRequestException(userData);
      case 401:
        Timepopup.timeoutpopUP(context);
        break;
      case 403:
        throw ForbiddenException(response.body.toString());
      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

  void showProgressDialog(BuildContext context) {
    pr = ProgressDialog(context, showLogs: false);
    pr.style(
      progress: 0.0,
      message: "Loading...",
      progressWidget: Container(
          padding: const EdgeInsets.all(15.0),
          child: const CircularProgressIndicator()),
      maxProgress: 30.0,
      progressTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 13.0,
      ),
      messageTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 19.0,
      ),
    );
    pr.show();
  }

  Future<void> dismissProgressDialog() async {
    try {
      await pr.hide();
    } catch (err) {
      print(err);
    }
  }
}
