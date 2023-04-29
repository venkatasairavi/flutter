import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import '../../../../../app/routes/app.routes.dart';
import '../../../../../core/encryption/encryption.dart';
import '../../../../../utils/Utils/Utils.dart';
import '../homeVM/BookAppointmentVM.dart';

class BookAppointmentNotifier extends ChangeNotifier {
  final BookAppointmentVM bookAppointmentVM = BookAppointmentVM();

  Future<String> tz() async {
    final Utils utils = Utils();
    // timeZone = await utils.timeZone();
    return await utils.timeZone();
  }

  Future<dynamic> getDoctorProfile(
      {required BuildContext context, required String doctorGuid}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await bookAppointmentVM.getDoctorProfile(
          jwtData: jwtData!, context: context, doctorGuId: doctorGuid);

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        print('getDoctorProfile $decodedData');

        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> getAvailableSlots(
      {required BuildContext context,
      required String doctorGuid,
      required String date}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      String? timeZone = await tz();
      print(timeZone);

      var notifData = await bookAppointmentVM.getAvailableSlots(
          jwtData: jwtData!,
          context: context,
          doctorGuId: doctorGuid,
          timeZone: AES().encryptJSON(timeZone),
          date: date);

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        print('decodedData ' + decodedData.toString());

        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> bookAppointment(
      {required String docData, required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      String? timeZone = await tz();

      var notifData = await bookAppointmentVM.bookAppointment(
        jwtData: jwtData!,
        context: context,
        appointmentDate: AES().encryptJSON(docData),
        timeZone: AES().encryptJSON(timeZone),
      );

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));

        print('decodedData ' + decodedData.toString());
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> rescheduleAppointment(
      {required String docData, required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      String? timeZone = await tz();

      var notifData = await bookAppointmentVM.rescheduleAppointment(
        jwtData: jwtData!,
        context: context,
        appointmentDate: AES().encryptJSON(docData),
        timeZone: AES().encryptJSON(timeZone),
      );

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));

        print('decodedData ' + decodedData.toString());
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> bookAppointmentReason(
      {required String docData, required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await bookAppointmentVM.bookAppointmentReason(
        jwtData: jwtData!,
        context: context,
        appointmentReason: AES().encryptJSON(docData),
      );

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));

        print('decodedData ' + decodedData.toString());
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> bookAppointmentPayment(
      {required String docData,
      required BuildContext context,
      required String patientAppointmentGuId,
      required isReschedule}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await bookAppointmentVM.bookAppointmentPayment(
        jwtData: jwtData!,
        context: context,
        appointmentGuId: patientAppointmentGuId,
        isReschedule: isReschedule,
        paymentDTO: AES().encryptJSON(docData),
      );

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        Navigator.of(context).pushNamed(PatientDashboardScreen);

        print('decodedData ' + decodedData.toString());
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } on SocketException {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> previewAppointment(
      {required BuildContext context,
      required String patientAppointmentGuId}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      String? timeZone = await tz();

      var notifData = await bookAppointmentVM.appointmentPreview(
        jwtData: jwtData!,
        context: context,
        appointmentGuId: patientAppointmentGuId,
        timeZone: AES().encryptJSON(timeZone),
      );

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));

        print('decodedData ' + decodedData.toString());
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
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
