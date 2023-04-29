import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_style.dart';

import 'package:moibleapi/core/services/cache.service.dart';


class DoctorProfileOptionsScreen extends StatefulWidget {
  const DoctorProfileOptionsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileOptionsScreen> createState() =>
      _DoctorProfileOptionsScreenState();
}

class _DoctorProfileOptionsScreenState
    extends State<DoctorProfileOptionsScreen> {
  final CacheService _cacheService = CacheService();

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getDocData();
  // }

  var jsonData;

  Future<dynamic> getDocData() async {
    String? stringData = await _cacheService.readCache(key: "DocData");
    print("cached data");
    jsonData = await jsonDecode(stringData!);
    print(jsonData);
    return jsonData;
  }

  var data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDocData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          data = snapshot.data;
          return Scaffold(
            backgroundColor: ColorConstant.indigo800,
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstant.gray50,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(getHorizontalSize(0.00)),
                      topRight: Radius.circular(getHorizontalSize(0.00)),
                      bottomLeft: Radius.circular(getHorizontalSize(30.00)),
                      bottomRight: Radius.circular(getHorizontalSize(30.00))),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(26.00),
                              top: getVerticalSize(56.00),
                              right: getHorizontalSize(26.00)),
                          child: Container(
                              height: getVerticalSize(38.00),
                              width: getHorizontalSize(35.00),
                              child: SvgPicture.asset(ImageConstant.imgVector6,
                                  fit: BoxFit.fill))),
                      Padding(
                          padding: EdgeInsets.only(top: getVerticalSize(33.00)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(25.00),
                                        top: getVerticalSize(6.00),
                                        bottom: getVerticalSize(19.00)),
                                    child: Text(
                                        "Hello, ${snapshot.data["userDetails"]["firstName"]} ",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatobold20
                                            .copyWith(
                                                fontSize: getFontSize(20)))),
                                Image.asset(
                                  ImageConstant.wave,
                                  cacheWidth: 35,
                                  cacheHeight: 35,
                                )
                              ])),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.3,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            onTapProfile();
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(26.00),
                                  top: getVerticalSize(39.00),
                                  right: getHorizontalSize(26.00)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        height: getSize(24.00),
                                        width: getSize(24.00),
                                        child: SvgPicture.asset(
                                            ImageConstant.imgFrame4,
                                            fit: BoxFit.fill)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(13.00),
                                            top: getVerticalSize(4.00),
                                            bottom: getVerticalSize(3.00)),
                                        child: Text("Profile",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium182
                                                .copyWith(
                                                    fontSize: getFontSize(18),
                                                    height: 0.89)))
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            onTapChangepassword();
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(26.00),
                                  top: getVerticalSize(26.00),
                                  right: getHorizontalSize(26.00)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        height: getSize(24.00),
                                        width: getSize(24.00),
                                        child: SvgPicture.asset(
                                            ImageConstant.imgFrame5,
                                            fit: BoxFit.fill)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(13.00),
                                          top: getVerticalSize(4.00),
                                        ),
                                        child: Text("Change Password",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium182
                                                .copyWith(
                                                    fontSize: getFontSize(18),
                                                    height: 0.89)))
                                  ]))),
                      Padding(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(22.00),
                              top: getVerticalSize(200.00),
                              right: getHorizontalSize(22.00)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    height: getSize(24.00),
                                    width: getSize(24.00),
                                    child: SvgPicture.asset(
                                        ImageConstant.imgFrame6,
                                        fit: BoxFit.fill)),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(11.00),
                                      top: getVerticalSize(4.00),
                                    ),
                                    child: Text("Contact Us",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium182
                                            .copyWith(
                                                fontSize: getFontSize(18),
                                                height: 0.89)))
                              ])),
                      Container(
                          height: getVerticalSize(1.00),
                          width: getHorizontalSize(320.00),
                          margin: EdgeInsets.only(
                              left: getHorizontalSize(22.00),
                              top: getVerticalSize(11.00),
                              right: getHorizontalSize(22.00)),
                          decoration:
                              BoxDecoration(color: ColorConstant.gray302)),
                      Padding(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(26.00),
                              top: getVerticalSize(10.00),
                              right: getHorizontalSize(26.00)),
                          child: Text("+1 98765432102",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.textstylelatosemibold16
                                  .copyWith(fontSize: getFontSize(16)))),
                      Padding(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(22.00),
                              top: getVerticalSize(11.00),
                              right: getHorizontalSize(20.00)),
                          child: Container(
                              height: getVerticalSize(52.00),
                              width: getHorizontalSize(333.00),
                              child: const Text("Support@telehealth.com",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w600)))),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.3,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: getHorizontalSize(26.00),
                            top: getVerticalSize(10.00),
                            right: getHorizontalSize(26.00),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    height: getSize(24.00),
                                    width: getSize(24.00),
                                    child: SvgPicture.asset(
                                        ImageConstant.imgFrame7,
                                        fit: BoxFit.fill)),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: getHorizontalSize(9.00),
                                      top: getVerticalSize(4.00),
                                    ),
                                    child: GestureDetector(
                                      onTap: (() {
                                        showAlertDialog(context);
                                        //print("logout");
                                      }),
                                      child: Text("Logout",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.textstylelatomedium183
                                              .copyWith(
                                                  fontSize: getFontSize(18),
                                                  height: 0.89)),
                                    ))
                              ]))
                    ])),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  onTapProfile() {
    print("on profile Tap");
    print(jsonData);
    Navigator.of(context).pushNamed(UserProfileRoute, arguments: {
      "firstName": jsonData["userDetails"]["firstName"],
      "lastName": jsonData["userDetails"]["lastName"],
      "gender": jsonData["userDetails"]["gender"],
      "dateOfBirth": jsonData["userDetails"]["dateOfBirth"],
      "countryPhnCode": jsonData["userDetails"]["countryPhnCode"],
      "phoneNumber": jsonData["userDetails"]["phoneNumber"]
    });
  }

  onTapChangepassword() {
    // Get.toNamed(AppRoutes.doctorProfileChangePasswordScreen);
    Navigator.of(context).pushNamed(UserProfilechangePasswordRoute, arguments: {
      "firstName": data["userDetails"]["firstName"],
      "lastName": data["userDetails"]["lastName"],
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        final CacheService _cacheService = CacheService();
        
        await _cacheService.removeCache(context: context);
     
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Do you want to Logout?",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'lato',
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ),
      //content: const Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
      elevation: 2.0,
      //shape: CircleBorder(),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
