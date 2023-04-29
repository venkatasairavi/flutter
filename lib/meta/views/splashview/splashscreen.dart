//import 'controller/app_loadup_controller.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';

import 'package:moibleapi/meta/views/user_options_view/useroptionscreen.dart';

import '../../../app/routes/app.routes.dart';
import '../../../app/shared/utils/math_utils.dart';
import '../../../core/services/cache.service.dart';
import '../../../utils/Utils/Constants.dart';

class AppLoadupScreen extends StatefulWidget {
  const AppLoadupScreen({Key? key}) : super(key: key);

  @override
  State<AppLoadupScreen> createState() => _AppLoadupScreenState();
}

class _AppLoadupScreenState extends State<AppLoadupScreen> {
  final CacheService _cacheService = CacheService();

  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

 void navigatetohome() async {

   String? isLoginValue = await _cacheService.readCache(key: isLogin);
   String? userType = await _cacheService.readCache(key: "userType");

   if(isLoginValue != null && isLoginValue == 'true'){
     if(userType != null && userType == 'doctor'){
       Navigator.of(context).pushNamed(HomeRoute);
     }else if(userType == 'patient'){
       Navigator.of(context).pushNamed(PatientDashboardScreen);
     }
   }else {
     Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserLoginOptionsScreen())));
   }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.indigo800,
            body: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Container(
                        height: size.height,
                        width: size.width,
                        decoration:
                            BoxDecoration(color: ColorConstant.indigo800),
                        child:
                        Stack(children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(96.00),
                                      top: getVerticalSize(370.00),
                                      right: getHorizontalSize(96.00),
                                      bottom: getVerticalSize(20.00)),
                                  child: Container(
                                      height: getVerticalSize(35.92),
                                      width: getHorizontalSize(181.00),
                                      child: SvgPicture.asset(
                                          ImageConstant.imgApplogo,
                                          fit: BoxFit.fill))))
                        ])
                    )))));
  }
}

  // onTapApploadupScre() {
  //   Get.offAllNamed(AppRoutes.userLoginOptionsScreen);
  // }
