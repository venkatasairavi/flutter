import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:moibleapi/core/encryption/encryption.dart';

class AuthenticationAPI {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

 /* Future login(
      {required String useremail, required String userpassword}) async {
    String bodyData = AES().encryptJSON(jsonEncode({
      'emailId': useremail.trim(),
      'password': userpassword.trim(),
      'userType': "doctor"
    }));

    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        Signin +
        "?loginRequestDTO=" +
        Uri.encodeComponent(bodyData));
    final http.Response response = await client.post(uri, headers: headers);
    final body = response.body;
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return body;
    }
  }*/

  Future createUser(
      {required String jsonData, required String timeZone}) async {
    final Uri uri = Uri.parse(Baseurl +
        API +
        Auth +
        Reset +
        "?dto=" +
        Uri.encodeComponent(jsonData) +
        "&timeZone=" +
        Uri.encodeComponent(timeZone));
    final http.Response response = await client.post(uri, headers: headers);
    final body = response.body;
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return body;
    }
  }

  Future updatePassword({required String data, required String jwtData}) async {

    if (headers.containsKey("Authorization")) {
      headers.remove("Authorization");
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    } else
      headers.putIfAbsent("Authorization", () => "Bearer " + jwtData);
    final Uri uri = Uri.parse(Baseurl +
        API +
        User +
        changePassword +
        "?changePassword=" +
        Uri.encodeComponent(data));
    final http.Response response = await client.post(uri, headers: headers);
    final body = response.body;
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return body;
    }
  }
}
