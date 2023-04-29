import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/meta/views/errorpage.dart';

import '../../../../../core/encryption/encryption.dart';
import '../../../../../core/services/cache.service.dart';
import '../messagesVM/messagesVM.dart';

class MessagesNotifier extends ChangeNotifier {
  final MessagesVM _messagesVM = MessagesVM();

  Future<dynamic> getMessages({required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var msgData =
          await _messagesVM.getMessages(jwtData: jwtData!, context: context);

      final Map<String, dynamic> parsedData = await jsonDecode(msgData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));

        print('Messages $decodedData');
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } 
    on SocketException{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }

  Future<dynamic> getDoctorPatientMsg(
      {required BuildContext context,
      required int pageNum,
      required int pageSize,
      required String patientGuId,
      required String doctorGuId}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var msgData = await _messagesVM.getDoctorPatientData(
          jwtData: jwtData!,
          context: context,
          pageNum: pageNum,
          pageSize: pageSize,
          patientGuId: patientGuId,
          doctorGuId: doctorGuId);

      final Map<String, dynamic> parsedData = await jsonDecode(msgData);

      if (parsedData["success"]) {

        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));

        print('Messages $decodedData');
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<dynamic> getFiles(
      {required BuildContext context, required String fileName}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var msgData = await _messagesVM.getFiles(
          jwtData: jwtData!, context: context, fileName: fileName);

      final Map<String, dynamic> parsedData = await jsonDecode(msgData);

      if (parsedData["success"]) {
        var decodedData = await json.decode(json.encode(parsedData["data"]));

        //    var decodedData = jsonDecode(parsedData["data"]);

        print('getFiles $decodedData');
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } catch (error) {
      print('error $error');
    }
    notifyListeners();
  }

  Future<dynamic> updateMsgUiid(
      {required BuildContext context,
      required String messageThreadGuId}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var msgData = await _messagesVM.updateMsgUiid(
          jwtData: jwtData!,
          context: context,
          messageThreadGuId: messageThreadGuId);

      final Map<String, dynamic> parsedData = await jsonDecode(msgData);

      if (parsedData["success"]) {
        var decodedData = await json.decode(json.encode(parsedData["data"]));

        //    var decodedData = jsonDecode(parsedData["data"]);

        print('getFiles $decodedData');
        return decodedData;
      } else {
        print("error");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     backgroundColor: Colors.black,
        //     content: Text(parsedData["success"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } catch (error) {
      print('error $error');
    }
    notifyListeners();
  }
}
