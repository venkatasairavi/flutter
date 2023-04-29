import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moibleapi/meta/views/errorpage.dart';
import 'package:moibleapi/meta/views/messageview/messageVM/messageVM.dart';
import 'package:moibleapi/meta/views/timeoutpopup.dart';
import 'package:moibleapi/utils/Utils/AppException.dart';
import '../../../../../core/encryption/encryption.dart';
import '../../../../../core/services/cache.service.dart';

class DocMessagesNotifier extends ChangeNotifier {
  final DocMessagesVM _messagesVM = DocMessagesVM();

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
        //     content: Text(parsedData["message"],
        //         style: const TextStyle(fontSize: 12))));
      }
    } on SocketException  {
   
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    }
    // catch (FetchDataException) {
    //   print(FetchDataException);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ErrorPage()),
    //   );
    // }
    notifyListeners();
  }
}
