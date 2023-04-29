import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/dashboardhomeview/dashboardVM/doctorVM.dart';

import 'package:moibleapi/meta/views/errorpage.dart';

import 'package:moibleapi/utils/Utils/Utils.dart';

class DoctorNotifier extends ChangeNotifier {
  final DoctorApi _doctorAPI = DoctorApi();

  Future<String> tz() async {
    final Utils utils = Utils();
    // timeZone = await utils.timeZone();
    return await utils.timeZone();
  }

  Future getDoctor({required BuildContext context}) async {
    try {
      String? jwtData;
      final CacheService _cacheService = CacheService();
      jwtData = await _cacheService.readCache(key: "jwtdata");

      var docData =
          await _doctorAPI.getDoctor(jwtData: jwtData!, context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(docData);
      print(jwtData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        print(
            "===============================================================0");
        print(decodedData);
        _cacheService.writeCache(key: "userId", value: decodedData["userGuId"]);
        _cacheService.writeCache(
            key: "email", value: decodedData["userDetails"]["email"]);
        _cacheService.writeCache(
            key: "DocData", value: jsonEncode(decodedData));

        return decodedData;
      }
    }  on SocketException {
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future setStatus(
      {required String status, required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      var docData = await _doctorAPI.setStatus(
          jwtData: jwtData!,
          status: AES().encryptJSON(status),
          context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(docData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        // print(
        //     "===============================================================0");
        // print(decodedData);
        // _cacheService.writeCache(key: "userId", value: decodedData["userGuId"]);
        // _cacheService.writeCache(
        //     key: "email", value: decodedData["userDetails"]["email"]);

        return decodedData;
      } else {
        print("error");
      }
    }  on SocketException {
      print("SOCKET EXP caught at setStatus method");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }

    notifyListeners();
  }

  Future<dynamic> getUpcomingAppointments(
      {required int pageNum,
      required String searchby,
      required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? timeZone = await tz();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(DateTime.now());

      var response = await _doctorAPI.getUpcomingAppoitments(
          jwtData: jwtData!,
          timeZone: AES().encryptJSON(timeZone),
          pgNum: pageNum,
          date: formattedDate,
          searchby: searchby,
          context: context);

      final Map<String, dynamic> parsedData = await jsonDecode(response);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        if (decodedData["list"].length > 0) {
          _cacheService.writeCache(
              key: "patientGuId",
              value: decodedData["list"][0]["appointmentDetails"]
                  ["patientGuId"]);
        }
        // print(decodedData);
        // print(decodedData["list"][0]["appointmentDetails"]["patientGuId"]);
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

  Future<dynamic> getPatientHistory(
      {
      // required String patientGuId,
      required int pgNum,
      required BuildContext context
      }) async {
    try {
      final CacheService _cacheService = CacheService();
      String? timeZone = await tz();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      String? patientGuId = await _cacheService.readCache(key: "patientGuId");
      // print("=========================================================");
      // print(patientGuId);

      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      // String formattedDate = formatter.format(DateTime.now());

      var response = await _doctorAPI.getPatientHistory(
          jwtData: jwtData!,
          patientGuId: patientGuId!,
          timeZone: AES().encryptJSON(timeZone),
          pgNum: pgNum,
          context: context
         );

      final Map<String, dynamic> parsedData = await jsonDecode(response);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
    
        return decodedData;
      } else {
        print("error");
      }
    } on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> getUserDetails(BuildContext context) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      print("jwtdata ${jwtData}");

      var docData =
          await _doctorAPI.getUserDetails(jwtData: jwtData!, context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(docData);

      if (parsedData["success"]) {
        dynamic decodedData =
            jsonDecode(AES().decryptString(parsedData["data"]));
        _cacheService.writeCache(
            key: "userDetails", value: jsonEncode(decodedData));
        return decodedData;
      }
    } on SocketException {
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> startJoinVideoCall(BuildContext context) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      print("jwtdata ${jwtData}");

      var docData = await _doctorAPI.startJoinVideoCall(
          jwtData: jwtData!, context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(docData);

      if (parsedData["success"]) {
        dynamic decodedData =
            jsonDecode(AES().decryptString(parsedData["data"]));
        return decodedData;
      }
    } on SocketException{
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }
}
