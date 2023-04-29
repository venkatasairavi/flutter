

import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import '../../utils/Utils/Utils.dart';
import '../services/cache.service.dart';

class DoctorApi {
  final client = http.Client();
  late Uri uri;
  final CacheService _cacheService = CacheService();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };

/*
  Future<String> getDoctor({required String jwtData, required BuildContext context}) async {
    headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    String? userType = await _cacheService.readCache(key: "userType");

    if(userType != null && userType == 'doctor'){
      uri = Uri.parse(Baseurl + API + doctorDetails);

    }else if(userType != null && userType == 'patient'){
      uri = Uri.parse(Baseurl + API + patientDetails);
    }
    Utils utils = Utils();

    print('getDoctor $uri');

    final http.Response response = await client.get(uri, headers: headers);

    dynamic responseJson = utils.returnResponse(response, context);
    return responseJson;
  }
*/

  Future<String> registerDoctor({required String registerDoctor}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        Register +
        "?signUpRequest=" +
        Uri.encodeComponent(registerDoctor));
    final http.Response response = await client.post(uri, headers: headers);
    final body = response.body;
    return body;
  }
}
