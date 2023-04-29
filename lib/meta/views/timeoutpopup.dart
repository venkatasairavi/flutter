import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/core/services/cache.service.dart';

class Timepopup{

  static timeoutpopUP( BuildContext context) {
        Dialog errorDialog = Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: SizedBox(
            height: 400.0,
            width: double.infinity,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    // width: double.infinity,
                    child: Center(
                      child: Text(
                        "Session Timed Out",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.indigo800),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                        //color: ColorConstant.indigo200,
                        height: getVerticalSize(100.47),
                        width: getHorizontalSize(100),
                        child: SvgPicture.asset(ImageConstant.imgsessiontime,
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getHorizontalSize(10),
                        top: getVerticalSize(20),
                        right: getHorizontalSize(30)),
                    child: const Center(
                      child: Text(
                        "You Have been signed out!!",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getHorizontalSize(20), top: getVerticalSize(20)),
                    child: const Text(
                      "Please Sign in with your username &\nPassword",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      height: 55,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          final CacheService _cacheService = CacheService();
                          _cacheService.removeCache(context: context);
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, UserOption, (route) => false);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const UserLoginOptionsScreen()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: ColorConstant.indigo800,
                            shape: const StadiumBorder(),
                            elevation: 7,
                            onPrimary: ColorConstant.bluegray300),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ]),
          ),
        );
        showDialog(
             barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => errorDialog);
      }
      
}