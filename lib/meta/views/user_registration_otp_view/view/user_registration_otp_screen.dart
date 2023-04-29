import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_decoration.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/meta/views/user_registration_otp_view/notifier/OTPNotifier.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/cache.service.dart';

class UserRegistrationEmailMobileOtpVerificationScreen extends StatefulWidget {

  @override
  State<UserRegistrationEmailMobileOtpVerificationScreen> createState() => _UserRegistrationEmailMobileOtpVerificationScreenState();
}

class _UserRegistrationEmailMobileOtpVerificationScreenState extends State<UserRegistrationEmailMobileOtpVerificationScreen> {

  TextEditingController otpController = TextEditingController();

  final CacheService _cacheService = CacheService();
  var data;
  var updateTimer = true;
  late Timer _timer;
  late final timeZone;

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;
  int currentSeconds = 0;

  String get timerText => '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
    startTimeout();
    tz();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    print('data : ${data[0]}');
    print("object");
    //print(email);
    return Scaffold(
        backgroundColor: ColorConstant.indigo800,
        resizeToAvoidBottomInset: false,
        body: Container(
            width: size.width,
            child: Container(
                decoration:
                BoxDecoration(color: ColorConstant.indigo800),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(29.00),
                                  top: getVerticalSize(76.00),
                                  right: getHorizontalSize(29.00)),
                              child: Container(
                                  height: getVerticalSize(27.00),
                                  width: getHorizontalSize(138.00),
                                  child: SvgPicture.asset(
                                      ImageConstant.imgApplogo3,
                                      fit: BoxFit.fill)))),
                      Expanded(
                          child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  top: getVerticalSize(35.00)),
                              decoration: BoxDecoration(
                                color: ColorConstant.gray50,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        getHorizontalSize(30.00)),
                                    topRight: Radius.circular(
                                        getHorizontalSize(30.00)),
                                    bottomLeft: Radius.circular(
                                        getHorizontalSize(0.00)),
                                    bottomRight: Radius.circular(
                                        getHorizontalSize(0.00))),
                              ),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                                29.00),
                                            top: getVerticalSize(21.00),
                                            right: getHorizontalSize(
                                                29.00)),
                                        child: Text("OTP Verification",
                                            overflow:
                                            TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatobold22
                                                .copyWith(
                                                fontSize:
                                                getFontSize(
                                                    22)))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: getHorizontalSize(
                                                29.00),
                                            top: getVerticalSize(21.00),
                                            right: getHorizontalSize(
                                                29.00)),
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                  "Please enter the verification code which is sent to ",
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .bluegray600,
                                                      fontSize:
                                                      getFontSize(
                                                          14),
                                                      fontFamily:
                                                      'Lato',
                                                      fontWeight:
                                                      FontWeight.w500)),
                                              TextSpan(
                                                  text: data[0],
                                                  style: TextStyle(
                                                      color: Colors.indigo,
                                                      fontSize:
                                                      getFontSize(
                                                          14),
                                                      fontFamily:
                                                      'Lato',
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      decoration: TextDecoration.underline,
                                                      height: 1.86)),
                                            ]),
                                            textAlign: TextAlign.left)),

                                    const SizedBox(height: 20),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                                29.00),
                                            right: getHorizontalSize(
                                                29.00)
                                         ),
                                        child: Container(
                                            width: double.infinity,
                                            child: PinCodeTextField(
                                                autoFocus: true,
                                                appContext: context,
                                                cursorColor: ColorConstant.black900,
                                                controller: otpController,
                                                length: 6,
                                                obscureText: false,
                                                obscuringCharacter: '*',
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                ],
                                                autoDismissKeyboard:
                                                true,
                                                enableActiveFill: true,
                                                onChanged: (value) {},
                                                textStyle: TextStyle(
                                                    fontSize: getFontSize(
                                                        14.0),
                                                    color: ColorConstant
                                                        .bluegray600),
                                                pinTheme: PinTheme(
                                                    fieldHeight:
                                                    getHorizontalSize(
                                                        50.00),
                                                    fieldWidth:
                                                    getHorizontalSize(
                                                        40.00),
                                                    shape: PinCodeFieldShape
                                                        .box,
                                                    borderRadius:
                                                    BorderRadius.circular(getHorizontalSize(3.85)),
                                                    selectedFillColor: ColorConstant.gray50,
                                                    activeFillColor: ColorConstant.gray50,
                                                    inactiveFillColor: ColorConstant.gray50,
                                                    inactiveColor: ColorConstant.indigo80026,
                                                    selectedColor: ColorConstant.indigo80026,
                                                    activeColor: ColorConstant.indigo80026)))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: getHorizontalSize(
                                                29.00),
                                            top: getVerticalSize(21.00),
                                            right: getHorizontalSize(
                                                29.00)),
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                  "Time Remaining:  ",
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .bluegray600,
                                                      fontSize:
                                                      getFontSize(
                                                          14),
                                                      fontFamily:
                                                      'Lato',
                                                      fontWeight:
                                                      FontWeight
                                                          .w500)),
                                              TextSpan(
                                                  text: "  $timerText",
                                                  style: TextStyle(
                                                      color: ColorConstant
                                                          .bluegray600,
                                                      fontSize:
                                                      getFontSize(
                                                          14),
                                                      fontFamily:
                                                      'Lato',
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      height: 1.86)),
                                            ]),
                                            textAlign: TextAlign.left)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                            getVerticalSize(11.00)),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      getHorizontalSize(
                                                          30.00)),
                                                  child: Text(
                                                      "Didn’t recieve an OTP yet?",
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      textAlign:
                                                      TextAlign
                                                          .left,
                                                      style: AppStyle
                                                          .textstylelatomedium14
                                                          .copyWith(
                                                          fontSize:
                                                          getFontSize(
                                                              14)))),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      getHorizontalSize(
                                                          10.00),
                                                      right:
                                                      getHorizontalSize(
                                                          50.00)),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        onTapResendBtn();
                                                      },
                                                      child: Text(
                                                      "Resend OTP",
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle.textstylelatomedium14.copyWith(fontSize: getFontSize(14),
                                                          color: updateTimer == false ? Colors.indigo : Colors.grey,
                                                              decoration: TextDecoration.underline))))
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                            getVerticalSize(325.00),
                                            bottom:
                                            getVerticalSize(50.00)),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            mainAxisSize:
                                            MainAxisSize.max,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      getHorizontalSize(
                                                          36.00),
                                                      top:
                                                      getVerticalSize(
                                                          16.00),
                                                      bottom:
                                                      getVerticalSize(
                                                          15.00)),
                                                  child:
                                                  GestureDetector(
                                                      onTap: () {
                                                        onTapBtnGoback();
                                                      },
                                                      child: Text(
                                                          "Go Back",
                                                          textAlign:
                                                          TextAlign
                                                              .left,
                                                          style: AppStyle
                                                              .textstylelatomedium161
                                                              .copyWith(
                                                              fontSize: getFontSize(16))))
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                      getHorizontalSize(
                                                          31.00)),
                                                  child:
                                                  GestureDetector(
                                                      onTap: () {
                                                        onTapBtnNext();
                                                      },
                                                      child: Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          height: getVerticalSize(
                                                              50.00),
                                                          width: getHorizontalSize(
                                                              145.00),
                                                          decoration:
                                                          AppDecoration
                                                              .textstylelatomedium16,
                                                          child: Text(
                                                              "Next",
                                                              textAlign: TextAlign
                                                                  .left,
                                                              style: AppStyle
                                                                  .textstylelatomedium16
                                                                  .copyWith(fontSize: getFontSize(16)))))
                                              )
                                            ]))
                                  ])))
                    ]))));
  }

  Future tz() async{
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);
  }

  void startTimeout([int? milliseconds]) {
    var duration = interval;
     _timer = Timer.periodic(duration, (timer) {
      setState(() {
        print(_timer.tick);
        currentSeconds = _timer.tick;
        if (_timer.tick >= timerMaxSeconds) {
          updateTimer = false;
          _timer.cancel();
        }
      });
    });

  }

  void onTapBtnGoback() {
    Navigator.pop(context);
  }

  void onTapResendBtn(){
    if(!updateTimer){
      var otpNotifier = Provider.of<OTPNotifier>(context, listen: false);
      otpNotifier.sendOTP(context: context, email: data[0], screen : "OTP");
      startTimeout();
      setState(() {
        updateTimer = true;
      });
      }
  }

  void onTapBtnNext() async {
    String? userType = await _cacheService.readCache(key: "userType");

    if(otpController.text.length == 6){
      if(data[2] != null && data[2] == true){
        if(userType != null && userType == 'patient'){

          var mfaNotifier =  Provider.of<OTPNotifier>(context, listen: false);

          final jsonData = jsonEncode({
            "email": data[0],
            "otp": otpController.text,
            "password": data[1],
          });

          mfaNotifier.mfa(
              context: context,
              mfaData: jsonData,
              timeZone: timeZone);

        }else{
          var otpNotifier = Provider.of<OTPNotifier>(context, listen: false);

          final jsonData = jsonEncode({
            "email": data[0],
            "otp": otpController.text,
          });
          // print(jsonData);
          print("calling notifier method");
          otpNotifier.validateOTP(
              context: context,
              otpData: jsonData,
              firstName: "",
              lastName: "",
              timeZone: timeZone);
        }
      }else{
        var otpNotifier = Provider.of<OTPNotifier>(context, listen: false);

        final jsonData = jsonEncode({
          "email": data[0],
          "otp": otpController.text,
        });
        // print(jsonData);
        print("calling notifier method");
        otpNotifier.validateOTP(
            context: context,
            otpData: jsonData,
            firstName: "",
            lastName: "",
            timeZone: timeZone);
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Please enter OTP", style: TextStyle(fontSize: 12))));
    }
    // print(AES().encryptJSON(jsonData));
    // String jsondata = AES().encryptJSON(jsonData);
    // String timezone = AES().encryptJSON("GMT");
    // print(AES().encryptJSON(timeZone));

    // print(Uri.parse(
    //     "https://dev.gtcure.com/api/auth/otp-validation?otpValidationDTO=" +
    //         Uri.encodeComponent(jsondata) +
    //         "&timeZone=" +
    //         Uri.encodeComponent(timezone)));
    // final response = await http.post(Uri.parse(
    //     "https://dev.gtcure.com/api/auth/otp-validation?otpValidationDTO=" +
    //         Uri.encodeComponent(jsondata) +
    //         "&timeZone=" +
    //         Uri.encodeComponent(timezone)));
    // var resp = await jsonDecode(response.body);
    // print(resp);
    // if (resp["success"] == true) {
    //   String userdetails = (AES().decryptString(resp["data"]));

    // ScaffoldMessenger.of(context)
    //     .showSnackBar(const SnackBar(content: Text("OTP Success")));
    // Get.toNamed(AppRoutes.userRegistrationProfilePasswordScreen,
    //     arguments:  [userdetails,data,timezone]);
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
    // }
  }

  @override
  void dispose(){
    super.dispose();
    if(_timer.isActive){
      _timer.cancel();
    }
  }
}
