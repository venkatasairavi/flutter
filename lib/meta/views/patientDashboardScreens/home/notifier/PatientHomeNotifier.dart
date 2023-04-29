import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/home/homeVM/PatientHomeVM.dart';

import '../../../../../core/encryption/encryption.dart';
import '../../../../../utils/Utils/Utils.dart';

class PatientHomeNotifier extends ChangeNotifier {
  final PatientHomeVM _patientHomeVM = PatientHomeVM();

  Future<String> tz() async {
    final Utils utils = Utils();
    // timeZone = await utils.timeZone();
    return await utils.timeZone();
  }

  Future<dynamic> getUpcomingAppointments(
      {required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? timeZone = await tz();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await _patientHomeVM.getUpcomingAppointments(
          jwtData: jwtData!,
          timeZone: AES().encryptJSON(timeZone),
          context: context);

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        return decodedData;
      } else {
        print("error");
      }
    } on SocketException {
      print("at GetUpcoming apoinnmentnsnefawfawfaw ");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> cancelAppointment(
      {required BuildContext context,
      required String patientAppointmentGuid}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? timeZone = await tz();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await _patientHomeVM.cancelAppointment(
          jwtData: jwtData!,
          patientAppointmentGuid: patientAppointmentGuid,
          context: context);

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));

        print('cancel $decodedData');
        return parsedData["success"];
      } else {
        print("error");
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> updatePatientStatus(
      {required BuildContext context, required String status}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? timeZone = await tz();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await _patientHomeVM.updatePatientStatus(
          jwtData: jwtData!,
          timeZone: AES().encryptJSON(timeZone),
          context: context,
          status: AES().encryptJSON(status));

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        return decodedData;
      } else {
        print("error");
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> getDoctors(
      {required BuildContext context, required String filters}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? timeZone = await tz();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await _patientHomeVM.getDoctorFilters(
        jwtData: jwtData!,
        filters: AES().encryptJSON(filters),
        context: context,
      );

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        // if (parsedData["message"] != null) {
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //       backgroundColor: Colors.black,
        //       content: Text(parsedData["message"],
        //           style: const TextStyle(fontSize: 12))));
        // }
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        return decodedData;
      } else {
        print("error");
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }
}
