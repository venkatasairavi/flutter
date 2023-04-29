
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moibleapi/core/encryption/encryption.dart';

import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/dashboardallappointmentsview/appointmentsVM/appointmentsVM.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/timeoutpopup.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';

import 'package:moibleapi/utils/Utils/Utils.dart';

class AppointmentNotifier extends ChangeNotifier {
  final AppointmentsApi _appointmentsApi = AppointmentsApi();
  final CacheService _cacheService = CacheService();
  // late String timeZone;

  Future<String> tz() async {
    final Utils utils = Utils();
    // timeZone = await utils.timeZone();
    return await utils.timeZone();
  }

  Future<dynamic> getPatientList(
      {required int pgNum,
      required BuildContext context,
      required String search,
      required String filterBy}) async {
    try {
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      String? timeZone = await tz();

      var patientdata = await _appointmentsApi.getPatientList(
        jwtData: jwtData!,
        pgNum: pgNum,
        tz: AES().encryptJSON(timeZone),
        context: context,
        search: search,
        filterBy: filterBy,
      );

      final Map<String, dynamic> parsedData =
          await jsonDecode(patientdata.toString());

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        print(decodedData);
        return decodedData;
      } else {
        print("error");
      }
    }on SocketException {
      print("SOCKET EXP caught at setStatus method");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
  
    notifyListeners();
  }
}
