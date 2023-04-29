
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/core/encryption/encryption.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/history/historyVM/HistoryVM.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

class HistoryNotifier extends ChangeNotifier {
  final HistoryVM _historyVM = HistoryVM();
  final CacheService _cacheService = CacheService();
  // late String timeZone;

  Future<String> tz() async {
    final Utils utils = Utils();
    // timeZone = await utils.timeZone();
    return await utils.timeZone();
  }

  Future<dynamic> getPatientHistoryList(
      {required int pgNum,
      required int pgSize,
      required BuildContext context,
      required String search,
      required String filterBy}) async {
    try {
      String? jwtData = await _cacheService.readCache(key: "jwtdata");
      String? timeZone = await tz();

      var patientdata = await _historyVM.getPatientHistoryList(
        jwtData: jwtData!,
        pgNum: pgNum,
        tz: AES().encryptJSON(timeZone),
        pgSize: pgSize,
        context: context,
        search: search,
        filterBy: filterBy,
      );

      final Map<String, dynamic> parsedData = await jsonDecode(patientdata.toString());

      if (parsedData["success"]) {
        var decodedData = jsonDecode(AES().decryptString(parsedData["data"]));
        print('getPatientHistoryList $decodedData');
        return decodedData;
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
}
