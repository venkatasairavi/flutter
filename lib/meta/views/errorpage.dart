import 'dart:io';

import 'package:flutter/material.dart';

import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/dashboardview/dashboardscreen.dart';
import 'package:moibleapi/meta/views/patientDashboardScreens/dashboard/view/DashboardScreen.dart';
import 'package:moibleapi/meta/views/user_options_view/useroptionscreen.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key? key}) : super(key: key);
  //late String Screens;
  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Center(
          child: Container(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/images/nointernet.png',
                  ),
                ),
                const Text(
                  "No Internet Conncetion",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorConstant.whiteA700,
                        //shape: const StadiumBorder(),
                        elevation: 7,
                        onPrimary: ColorConstant.whiteA700),
                    onPressed: () async {
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                      } on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                                "Please check your internet connection\nand try again",
                                style: TextStyle(fontSize: 12))));
                        return;
                      }
                      CacheService _cacheData = CacheService();
                      var jwtdata = await _cacheData.readCache(key: "jwtdata");
                      var usertype =
                          await _cacheData.readCache(key: "userType");
                      if (jwtdata != null && usertype == "doctor") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()),
                        );
                      } else if (usertype == "patient") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()),
                        );
                        return;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UserLoginOptionsScreen()),
                        );
                      }
                    },
                    child: const Text(
                      "Try Again",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ));
  }
}
