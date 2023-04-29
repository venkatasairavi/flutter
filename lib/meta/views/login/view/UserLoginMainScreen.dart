
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/meta/views/login/notifier/LoginNotifier.dart';
import 'package:moibleapi/meta/views/user_registration_otp_view/notifier/OTPNotifier.dart';
import 'package:moibleapi/utils/Utils/Utils.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/cache.service.dart';

class UserLoginMainScreen extends StatefulWidget {
  const UserLoginMainScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginMainScreen> createState() => _UserLoginMainScreenState();
}

class _UserLoginMainScreenState extends State<UserLoginMainScreen> {
  var password = TextEditingController();
  var email = TextEditingController();

  bool _passwordVisible = false;
  late final timeZone;
  bool _isChecked = false;

  @override
  void initState() {
    _loadUserEmailPassword();
    tz();
    super.initState();
  }

  Future tz() async {
    final Utils utils = Utils();
    timeZone = await utils.timeZone();
    print(timeZone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.indigo800,
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(color: ColorConstant.indigo800),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(UserOption);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: getVerticalSize(56.00),
                                  left: getHorizontalSize(25.0)),
                              child: Container(
                                  height: getSize(46.00),
                                  width: getSize(46.00),
                                  child: SvgPicture.asset(
                                      ImageConstant.imgBack3,
                                      fit: BoxFit.fill))))),
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding:
                                  EdgeInsets.only(top: getVerticalSize(25.00)),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: size.width,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: getHorizontalSize(29.00),
                                                right:
                                                    getHorizontalSize(28.00)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                      height: getVerticalSize(
                                                          27.00),
                                                      width: getHorizontalSize(
                                                          138.00),
                                                      child: SvgPicture.asset(
                                                          ImageConstant
                                                              .imgApplogo5,
                                                          fit: BoxFit.fill)),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: getVerticalSize(
                                                              5.00),
                                                          bottom:
                                                              getVerticalSize(
                                                                  3.00)),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            onTapBtnRegisterNow();
                                                          },
                                                          child: Text(
                                                              "Register Now",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .textstylelatomedium163
                                                                  .copyWith(
                                                                      fontSize:
                                                                          getFontSize(
                                                                              16),
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline))))
                                                ]))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(29.00),
                                            top: getVerticalSize(46.00),
                                            right: getHorizontalSize(29.00)),
                                        child: Text("Welcome,",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.textstylelatobold221
                                                .copyWith(
                                                    fontSize:
                                                        getFontSize(22)))),
                                    Container(
                                        width: getHorizontalSize(318.00),
                                        margin: EdgeInsets.only(
                                            left: getHorizontalSize(29.00),
                                            top: getVerticalSize(11.00),
                                            right: getHorizontalSize(28.00)),
                                        child: Text(
                                            "Login with your email and password. You will receive authentication code that you will enter on the next screen to login.",
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium164
                                                .copyWith(
                                                    fontSize: getFontSize(16),
                                                    height: 1.50))),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: getVerticalSize(34.00)),
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
                                                        top: getVerticalSize(
                                                            34.00),
                                                        right:
                                                            getHorizontalSize(
                                                                29.00)),
                                                    child: Text(
                                                        "Email  or Mobile Number *",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .textstylelatomedium142
                                                            .copyWith(
                                                                fontSize:
                                                                    getFontSize(
                                                                        14)))),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            29.00),
                                                        top: getVerticalSize(
                                                            5.00),
                                                        right: getHorizontalSize(
                                                            28.00)),
                                                    child: Container(
                                                        height: getVerticalSize(
                                                            45.00),
                                                        width: getHorizontalSize(
                                                            318.00),
                                                        child: TextFormField(
                                                            controller: email,
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Enter email/mobile number",
                                                                hintStyle: AppStyle.textstylelatoregular14.copyWith(
                                                                    fontSize: getFontSize(
                                                                        14.0),
                                                                    color: ColorConstant
                                                                        .bluegray600),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                                    borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)), borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                                suffixIcon: Padding(padding: EdgeInsets.only(left: getHorizontalSize(10.00), right: getHorizontalSize(18.00)), child: Container(height: getSize(18.00), width: getSize(18.00), child: SvgPicture.asset(ImageConstant.imgFrame8531, fit: BoxFit.contain))),
                                                                suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                                                                filled: true,
                                                                fillColor: ColorConstant.gray50,
                                                                isDense: true,
                                                                contentPadding: EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.21), bottom: getVerticalSize(15.21))),
                                                            style: TextStyle(color: ColorConstant.bluegray900, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500)))),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            29.00),
                                                        top: getVerticalSize(
                                                            18.00),
                                                        right:
                                                            getHorizontalSize(
                                                                29.00)),
                                                    child: Text("Password *",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .textstylelatomedium142
                                                            .copyWith(
                                                                fontSize:
                                                                    getFontSize(
                                                                        14)))),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            29.00),
                                                        top: getVerticalSize(
                                                            5.00),
                                                        right:
                                                            getHorizontalSize(
                                                                28.00)),
                                                    child: Container(
                                                        height: getVerticalSize(
                                                            45.00),
                                                        width:
                                                            getHorizontalSize(
                                                                318.00),
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          controller: password,
                                                          obscureText:
                                                              !_passwordVisible,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Enter password",
                                                                  hintStyle: AppStyle.textstylelatoregular14.copyWith(
                                                                      fontSize: getFontSize(
                                                                          14.0),
                                                                      color: ColorConstant
                                                                          .bluegray600),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(getHorizontalSize(
                                                                          3.85)),
                                                                      borderSide: BorderSide(
                                                                          color: ColorConstant
                                                                              .indigo80026,
                                                                          width:
                                                                              0.77)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(getHorizontalSize(
                                                                          3.85)),
                                                                      borderSide: BorderSide(
                                                                          color: ColorConstant
                                                                              .indigo80026,
                                                                          width:
                                                                              0.77)),
                                                                  suffixIcon:
                                                                      IconButton(
                                                                    icon: Icon(
                                                                        // Based on passwordVisible state choose the icon
                                                                        _passwordVisible
                                                                            ? Icons
                                                                                .visibility
                                                                            : Icons
                                                                                .visibility_off,
                                                                        color: ColorConstant
                                                                            .black900),
                                                                    onPressed:
                                                                        () {
                                                                      // Update the state i.e. toogle the state of passwordVisible variable
                                                                      setState(
                                                                          () {
                                                                        _passwordVisible =
                                                                            !_passwordVisible;
                                                                      });
                                                                    },
                                                                  ),
                                                                  suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                                                                  filled: true,
                                                                  fillColor: ColorConstant.gray50,
                                                                  isDense: true,
                                                                  contentPadding: EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.21), bottom: getVerticalSize(15.21))),
                                                          //This will obscure text dynamically
                                                        ))),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            20.00),
                                                        top: getVerticalSize(
                                                            15.00),
                                                        right:
                                                            getHorizontalSize(
                                                                29.00)),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                              child: Row(
                                                                  children: [
                                                                Checkbox(
                                                                    activeColor:
                                                                        Color(
                                                                            0XFF1BC8C8),
                                                                    // shape:
                                                                    //     RoundedRectangleBorder(),
                                                                    // materialTapTargetSize: MaterialTapTargetSize
                                                                    //     .shrinkWrap,
                                                                    value:
                                                                        _isChecked,
                                                                    onChanged:
                                                                        _handleRemeberMe
                                                                    //     (value) {
                                                                    //   setState(
                                                                    //       () {
                                                                    //     print(
                                                                    //         value);

                                                                    //     this.value =
                                                                    //         value!;
                                                                    //   });
                                                                    // }
                                                                    ),
                                                                Text(
                                                                    "Remember Me",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: AppStyle
                                                                        .textstylelatomedium142
                                                                        .copyWith(
                                                                            fontSize:
                                                                                getFontSize(14)))
                                                                // Text("lbl_checkbox"
                                                                //     )
                                                              ])),
                                                          /*   Padding(
                                                                  padding: EdgeInsets.only(

                                                                      top: getVerticalSize(
                                                                          1.00),
                                                                      bottom:
                                                                      getVerticalSize(
                                                                          2.00)),
                                                                  child: Text(
                                                                      "Remember Me"
                                                                          ,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style: AppStyle
                                                                          .textstylelatomedium142
                                                                          .copyWith(
                                                                          fontSize:
                                                                          getFontSize(14))))*/
                                                        ])),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            29.00),
                                                        top: getVerticalSize(
                                                            18.00),
                                                        right:
                                                            getHorizontalSize(
                                                                29.00)),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                              "Unable to Login?",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: AppStyle
                                                                  .textstylelatomedium142
                                                                  .copyWith(
                                                                      fontSize:
                                                                          getFontSize(
                                                                              14))),
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  left:
                                                                      getHorizontalSize(
                                                                          5.00)),
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        onTapBtnReset();
                                                                      },
                                                                      child: Text(
                                                                          "Reset Password",
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style: AppStyle.textstylelatomedium141.copyWith(
                                                                              fontSize: getFontSize(14),
                                                                              decoration: TextDecoration.underline))))
                                                        ])),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                Container(
                                                    height: 55,
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16),
                                                    child:
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        login();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  ColorConstant
                                                                      .green,
                                                              shape:
                                                                  const StadiumBorder(),
                                                              elevation: 7,
                                                              onPrimary:
                                                                  ColorConstant
                                                                      .redA400),
                                                      child: const Text(
                                                        "Login",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/qm.png',
                                                        ),
                                                        Text(
                                                            "Have a question for us?",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .textstylelatomedium162
                                                                .copyWith(
                                                                    fontSize:
                                                                        getFontSize(
                                                                            16)))
                                                      ]),
                                                ),
                                              ])),
                                    )
                                  ]))))
                ])));
  }

  Future<void> login() async {
    final CacheService _cacheService = CacheService();
    String? userType = await _cacheService.readCache(key: 'userType');

    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      loginNotifier.login(
          context: context,
          useremail: email.text,
          userpassword: password.text,
          userType: userType,
          rememberMe: _isChecked);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Fill in the details", style: TextStyle(fontSize: 12))));
    }
  }

  void _handleRemeberMe(var value) {
    print("Handle Rember Me");
    _isChecked = value;
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      final CacheService _cacheService = CacheService();
      var _email = await _cacheService.readCache(key: "email") ?? "";
      var _password = await _cacheService.readCache(key: "password") ?? "";
      var _remeberMe = await _cacheService.readCache(key: "remember_me") ?? "false";

      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe == "true") {
        setState(() {
          _isChecked = true;
        });
        email.text = _email ?? "";
        password.text = _password ?? "";
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void onTapBtnRegisterNow() {
    Navigator.of(context).pushReplacementNamed(UserRegistrationscreenone);
  }

  void onTapBtnReset() {
    var otpNotifier = Provider.of<OTPNotifier>(context, listen: false);

    if (email.text.isNotEmpty) {
      otpNotifier.sendOTP(context: context, email: email.text, screen: "Login");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Please enter email", style: TextStyle(fontSize: 12))));
    }
  }
}
