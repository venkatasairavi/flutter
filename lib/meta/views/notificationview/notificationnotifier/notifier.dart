
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/notificationview/notificationVM/notificationVM.dart';
import 'package:moibleapi/meta/views/timeoutpopup.dart';

import 'package:moibleapi/utils/Utils/AppException.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

class NotificationNotifier extends ChangeNotifier {
  final NotiferAPi _doctorAPI = NotiferAPi();
  Future<String> tz() async {
    final Utils utils = Utils();
    // timeZone = await utils.timeZone();
    return await utils.timeZone();
  }

  Future<dynamic> getNotifications(
      {required int pgNum,
      required int pgSize,
      required BuildContext context}) async {
    try {
      final CacheService _cacheService = CacheService();
      String? timeZone = await tz();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      var notifData = await _doctorAPI.getNotifications(
          jwtData: jwtData!,
          timeZone: AES().encryptJSON(timeZone),
          pageNum: pgNum,
          pageSize: pgSize,
          context: context);

      final Map<String, dynamic> parsedData = await jsonDecode(notifData);

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        return decodedData;
      } else {
        print("error");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text(parsedData["message"],
                style: const TextStyle(fontSize: 12))));
      }
    } on UnauthorisedException {
      Timepopup.timeoutpopUP(context);
    } on SocketException{
     final CacheService _cacheService = CacheService();
     
     
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }
}
