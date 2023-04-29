
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import '../../../../core/services/cache.service.dart';
import '../../../../utils/Utils/AppException.dart';
import '../../../../utils/Utils/Utils.dart';

class AppointmentsApi {
  final client = http.Client();
  final CacheService _cacheService = CacheService();
 late  Uri uri ;
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

  Future getPatientList(
      {required String tz, required int pgNum, required String jwtData,  required BuildContext context,required String search, required String filterBy}) async {
   if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    //String? userType = await _cacheService.readCache(key: "userType");
    
    // Uri  uri = Uri.parse(Baseurl + API + doctorAppointments + patientList + "?timeZone=" + Uri.encodeComponent(tz) + "&pageNum=" + pgNum.toString() + "&pageSize=10");

 if(filterBy.isNotEmpty){
      uri = Uri.parse(Baseurl + API +  doctorAppointments + patientList + "?timeZone=" + Uri.encodeComponent(tz)
          + "&pageNum=" + pgNum.toString() + "&pageSize=10"+ '&filterBy=' + filterBy);
    }
    else if (search.isNotEmpty){
      uri = Uri.parse(Baseurl + API +  doctorAppointments + patientList + "?timeZone=" + Uri.encodeComponent(tz)
          + "&pageNum=0"  + "&pageSize=10" + '&search=' + search);
    }
    else{
       uri = Uri.parse(Baseurl + API +  doctorAppointments + patientList + "?timeZone=" + Uri.encodeComponent(tz)
          + "&pageNum=" + pgNum.toString() + "&pageSize=10");
    }

    Utils utils = Utils();
    print('getPatientList $uri');
    

    final http.Response response = await client.get(uri, headers: headers);
    try {
      dynamic responseJson = utils.returnResponse(response, context);
      return responseJson;
    } on SocketException {
      rethrow;
    } 
  }
}
