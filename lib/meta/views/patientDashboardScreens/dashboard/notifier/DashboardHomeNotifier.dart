import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/core/services/cache.service.dart';

import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/timeoutpopup.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import '../../../../../core/encryption/encryption.dart';
import '../../../../../utils/Utils/Utils.dart';
import '../dashboardVM/DashboardVM.dart';

class DashboardNotifier extends ChangeNotifier {
  final DashboardVM _dashboardVM = DashboardVM();
  final CacheService _cacheService = CacheService();

  Future<String> tz() async {
    final Utils utils = Utils();
    // timeZone = await utils.timeZone();
    return await utils.timeZone();
  }

  Future<dynamic> getUserDetails(BuildContext context) async {
    try {
      final CacheService _cacheService = CacheService();
      String? jwtData = await _cacheService.readCache(key: "jwtdata");

      print("jwtdata ${jwtData}");

      var docData = await _dashboardVM.getUserDetails(
          jwtData: jwtData!, context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(docData);

      if (parsedData["success"]) {
        dynamic decodedData =
            jsonDecode(AES().decryptString(parsedData["data"]));
        _cacheService.writeCache(
            key: "userDetails", value: jsonEncode(decodedData));
        return decodedData;
      }
    }  on SocketException catch(e){
      print("scoket exception aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(e);
     
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    notifyListeners();
  }
}
