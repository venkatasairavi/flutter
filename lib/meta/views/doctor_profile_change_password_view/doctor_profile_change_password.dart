import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_decoration.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/core/notifiers/authentication.notifier.dart';
import 'package:moibleapi/meta/views/doctor_profile_change_password_view/changepasswordnotifier/changepasswordnotifier.dart';
import 'package:provider/provider.dart';

class DoctorProfileChangePasswordScreen extends StatefulWidget {
  @override
  State<DoctorProfileChangePasswordScreen> createState() =>
      _DoctorProfileChangePasswordScreenState();
}

class _DoctorProfileChangePasswordScreenState
    extends State<DoctorProfileChangePasswordScreen> {
  bool _secureText = true;
  bool _secureText1 = true;
  bool _secureText2 = true;
  TextEditingController oldpassword = TextEditingController();
  TextEditingController setpassword = TextEditingController();

  TextEditingController confirmpassword = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final _formkey1 = GlobalKey<FormState>();

  final _formkey2 = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  double password_strength = 0;

  var data;

  var passwordStrength1 = false;
  var passwordStrength2 = false;
  var passwordStrength3 = false;
  var passwordStrength4 = false;

  bool validatePassword(String pass) {
    String _password = pass.trim();

    if (_password.isEmpty) {
      setState(() {
        passwordStrength1 = false;
        passwordStrength2 = false;
        passwordStrength3 = false;
        passwordStrength4 = false;
      });
    } else if (_password.length >= 2 && _password.length <= 4) {
      setState(() {
        passwordStrength1 = true;
        passwordStrength2 = false;
        passwordStrength3 = false;
        passwordStrength4 = false; //string length less then 6 character
      });
    } else if (_password.length >= 5 && _password.length <= 7) {
      setState(() {
        passwordStrength1 = true;
        passwordStrength2 = true;
        passwordStrength3 = true;
        passwordStrength4 = false; //string length less then 6 character
      });
    } else if (_password.length >= 8) {
      setState(() {
        passwordStrength1 = true;
        passwordStrength2 = true;
        passwordStrength3 = true;
        passwordStrength4 = true; //string length greater then 6 & less then 8
      });
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstant.indigo800,
            body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: getHorizontalSize(29.00),
                          top: getVerticalSize(56.00),
                          right: getHorizontalSize(29.00)),
                      child: Container(
                          height: getVerticalSize(27.00),
                          width: getHorizontalSize(138.00),
                          child: SvgPicture.asset(ImageConstant.imgApplogo3,
                              fit: BoxFit.fill))),
                  Container(
                      width: getHorizontalSize(318.00),
                      margin: EdgeInsets.only(
                          left: getHorizontalSize(29.00),
                          top: getVerticalSize(20.00),
                          right: getHorizontalSize(28.00)),
                      child: Text("Change Password",
                          textAlign: TextAlign.left,
                          style: AppStyle.textstylelatomedium167.copyWith(
                              fontSize: getFontSize(22), height: 1.50))),
                  Expanded(
                    flex: 5,
                    child: Container(
                      
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height*9,
                        //height: 500,
                        //margin: EdgeInsets.only(top: getVerticalSize(36.00)),
                        decoration: BoxDecoration(
                          color: ColorConstant.gray50,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(getHorizontalSize(30.00)),
                              topRight:
                                  Radius.circular(getHorizontalSize(30.00)),
                              bottomLeft:
                                  Radius.circular(getHorizontalSize(0.00)),
                              bottomRight:
                                  Radius.circular(getHorizontalSize(0.00))),
                        ),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: getVerticalSize(20.00)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                        29.00)),
                                                height: getSize(40.00),
                                                width: getSize(40.00),
                                                child: SvgPicture.asset(
                                                    ImageConstant
                                                        .imgUseravatarp,
                                                    fit: BoxFit.fill)),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(16.00),
                                                  top: getVerticalSize(9.00),
                                                  right:
                                                      getHorizontalSize(148.00),
                                                  // bottom:
                                                  //     getVerticalSize(
                                                  //         9.76)
                                                ),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  getHorizontalSize(
                                                                      10.00)),
                                                          child: Text(
                                                              "Username",
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
                                                      Row(
                                                        children: [
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: getVerticalSize(
                                                                          3.24)),
                                                              child: Text(
                                                                  data["firstName"] +
                                                                      " " +
                                                                      data[
                                                                          "lastName"],
                                                                  // data["firstName"],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: AppStyle
                                                                      .textstylelatomedium18
                                                                      .copyWith(
                                                                          fontSize:
                                                                              getFontSize(18)))),
                                                        ],
                                                      ),
                                                    ]))
                                          ]))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(29.00),
                                          top: getVerticalSize(21.00),
                                          right: getHorizontalSize(29.00)),
                                      child: Text("Old Password *",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.textstylelatomedium142
                                              .copyWith(
                                                  fontSize: getFontSize(14))))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(29.00),
                                      top: getVerticalSize(6.00),
                                      right: getHorizontalSize(24.00)),
                                  child: Container(
                                    width: double.infinity,

                                     height: 45,
                                    child: TextFormField(
                                        obscureText: _secureText,
                                        controller: oldpassword,
                                        onChanged: (value) {
                                          //  _formkey.currentState?.validate();
                                        },
                                        decoration: InputDecoration(
                                          // hintText: "old password",
                                          hintStyle: AppStyle
                                              .textstylelatomedium142
                                              .copyWith(
                                                  fontSize: getFontSize(14.0),
                                                  color: ColorConstant
                                                      .bluegray900),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(
                                                          3.85)),
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.black900,
                                                  width: 0.77)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(
                                                          3.85)),
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.black900,
                                                  width: 0.77)),
                                          suffixIcon: IconButton(
                                            icon: Icon(_secureText
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            color: ColorConstant.black900,
                                            iconSize: 20,
                                            onPressed: () {
                                              setState(() {
                                                _secureText = !_secureText;
                                              });
                                            },
                                          ),
                                        ),
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "please enter old password";
                                        //   }
                                        // },
                                        style: TextStyle(
                                            color: ColorConstant.bluegray900,
                                            fontSize: getFontSize(14.0),
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w500)),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(29.00),
                                          top: getVerticalSize(21.00),
                                          right: getHorizontalSize(29.00)),
                                      child: Text("New Password *",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.textstylelatomedium142
                                              .copyWith(
                                                  fontSize: getFontSize(14))))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(29.00),
                                      top: getVerticalSize(6.00),
                                      right: getHorizontalSize(24.00)),
                                  child: Container(
                                    width: double.infinity,
                                     height: 45,
                                    child: TextFormField(
                                        obscureText: _secureText1,
                                        controller: setpassword,
                                        onChanged: (value) {
                                          validatePassword(setpassword.text);
                                        },
                                        decoration: InputDecoration(
                                          // hintText: "set password",
                                          hintStyle: AppStyle
                                              .textstylelatomedium142
                                              .copyWith(
                                                  fontSize: getFontSize(14.0),
                                                  color: ColorConstant
                                                      .bluegray900),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(
                                                          3.85)),
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.black900,
                                                  width: 0.77)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(
                                                          3.85)),
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.black900,
                                                  width: 0.77)),
                                          suffixIcon: IconButton(
                                            icon: Icon(_secureText1
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            color: ColorConstant.black900,
                                            iconSize: 20,
                                            onPressed: () {
                                              setState(() {
                                                _secureText1 = !_secureText1;
                                              });
                                            },
                                          ),
                                          // Padding(
                                          //     padding: EdgeInsets.only(left: getHorizontalSize(10.00), right: getHorizontalSize(18.00)),
                                          //     child: Container(height: getSize(18.00), width: getSize(18.00), child: SvgPicture.asset(ImageConstant.imgFrame8541, fit: BoxFit.contain))),
                                          // suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                                          // filled: true,
                                          // fillColor: ColorConstant.gray50,
                                          // isDense: true,
                                          //contentPadding: EdgeInsets.only(left: getHorizontalSize(20.00), top: getVerticalSize(15.21), bottom: getVerticalSize(15.21))
                                        ),
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "please enter password";
                                        //   }
                                        //   // else {
                                        //   //   bool result =
                                        //   //       validatePassword(value);
                                        //   //   // if (result) {
                                        //   //   // } else {
                                        //   //   //   return "Password Should contain Capital ,small letter & Number &\n Special ";
                                        //   //   // }
                                        //   // }
                                        // },
                                        style: TextStyle(
                                            color: ColorConstant.bluegray900,
                                            fontSize: getFontSize(14.0),
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w500)),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(29.00),
                                          top: getVerticalSize(22.00),
                                          right: getHorizontalSize(29.00)),
                                      child: Text("Confirm Password *",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.textstylelatomedium142
                                              .copyWith(
                                                  fontSize: getFontSize(14))))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(29.00),
                                      top: getVerticalSize(6.00),
                                      right: getHorizontalSize(24.00)),
                                  child: Container(
                                    width: double.infinity,
                                     height: 45,
                                    child: TextFormField(
                                        controller: confirmpassword,
                                        obscureText: _secureText2,
                                        onChanged: (value) {
                                          //_formkey2.currentState?.validate();
                                        },
                                        decoration: InputDecoration(
                                          // hintText:
                                          //     "confirm password",
                                          hintStyle: AppStyle
                                              .textstylelatomedium142
                                              .copyWith(
                                                  fontSize: getFontSize(14.0),
                                                  color: ColorConstant
                                                      .bluegray900),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(
                                                          3.85)),
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.black900,
                                                  width: 0.77)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(
                                                          3.85)),
                                              borderSide: BorderSide(
                                                  color:
                                                      ColorConstant.black900,
                                                  width: 0.77)),

                                          suffixIcon: IconButton(
                                            icon: Icon(_secureText2
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            color: ColorConstant.black900,
                                            iconSize: 20,
                                            onPressed: () {
                                              setState(() {
                                                _secureText2 = !_secureText2;
                                              });
                                            },
                                          ),
                                          // Padding(
                                          //     padding: EdgeInsets.only(
                                          //         left: getHorizontalSize(10.00),
                                          //         right: getHorizontalSize(18.00)),
                                          //     child: Container(height: getSize(18.00), width: getSize(18.00), child: SvgPicture.asset(ImageConstant.imgFrame8542, fit: BoxFit.contain))),
                                          // suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                                          // filled: true,
                                          // fillColor: ColorConstant.gray50,
                                          // isDense: true,
                                          // contentPadding: EdgeInsets.only(left: getHorizontalSize(20.00), top: getVerticalSize(15.21), bottom: getVerticalSize(15.21))
                                        ),
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "please enter confirm password ";
                                        //   }
                                        //   if (setpassword.text !=
                                        //       confirmpassword.text) {
                                        //     return "password Does match";
                                        //   }
                                        // },
                                        style: TextStyle(
                                            color: ColorConstant.bluegray900,
                                            fontSize: getFontSize(14.0),
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w500)),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: getVerticalSize(22.00)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                                height: getSize(7.00),
                                                width: getSize(7.00),
                                                margin: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(29.00),
                                                  top: getVerticalSize(5.00),
                                                  // bottom:
                                                  //     getVerticalSize(
                                                  //         16.00)
                                                ),
                                                decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.tealA700,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getHorizontalSize(
                                                                30.00)))),
                                            Container(
                                                width:
                                                    getHorizontalSize(301.00),
                                                margin: EdgeInsets.only(
                                                    left:
                                                        getHorizontalSize(8.00),
                                                    right: getHorizontalSize(
                                                        30.00)),
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              "Your password must be 8 or more character long & mix of\nupper & lower case letters, nmuber & symbols.",
                                                          style: TextStyle(
                                                              color: ColorConstant
                                                                  .bluegray600,
                                                              fontSize:
                                                                  getFontSize(
                                                                      12),
                                                              fontFamily:
                                                                  'Lato',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ]),
                                                    textAlign: TextAlign.left))
                                          ]))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: getVerticalSize(22.00)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                                height: getVerticalSize(6.00),
                                                width: getHorizontalSize(74.00),
                                                margin: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                        30.00)),
                                                decoration: BoxDecoration(
                                                    color: passwordStrength1 ==
                                                            true
                                                        ? ColorConstant.tealA700
                                                        : ColorConstant
                                                            .gray30099,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getHorizontalSize(
                                                                10.00)))),
                                            Container(
                                                height: getVerticalSize(6.00),
                                                width: getHorizontalSize(74.00),
                                                margin: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                        7.00)),
                                                decoration: BoxDecoration(
                                                    color: passwordStrength2 ==
                                                            true
                                                        ? ColorConstant.tealA700
                                                        : ColorConstant
                                                            .gray30099,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getHorizontalSize(
                                                                10.00)))),
                                            Container(
                                                height: getVerticalSize(6.00),
                                                width: getHorizontalSize(74.00),
                                                margin: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                        6.00)),
                                                decoration: BoxDecoration(
                                                    color: passwordStrength3 ==
                                                            true
                                                        ? ColorConstant.tealA700
                                                        : ColorConstant
                                                            .gray30099,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getHorizontalSize(
                                                                10.00)))),
                                            Container(
                                                height: getVerticalSize(6.00),
                                                width: getHorizontalSize(74.00),
                                                margin: EdgeInsets.only(
                                                    left:
                                                        getHorizontalSize(7.00),
                                                    right: getHorizontalSize(
                                                        29.00)),
                                                decoration: BoxDecoration(
                                                    color: passwordStrength4 ==
                                                            true
                                                        ? ColorConstant.tealA700
                                                        : ColorConstant
                                                            .gray30099,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getHorizontalSize(
                                                                10.00)))),
                                          ]))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(29.00),
                                          top: getVerticalSize(10.00),
                                          right: getHorizontalSize(29.00)),
                                      child: Text("Password Strength",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle.textstylelatomedium12
                                              .copyWith(
                                                  fontSize: getFontSize(12))))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                        top: getVerticalSize(64.00),
                                        // bottom:
                                        //     getVerticalSize(50.00)
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                        36.00),
                                                    top: getVerticalSize(5.00),
                                                    bottom:
                                                        getVerticalSize(15.00)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      onTapBtnGoback();
                                                    },
                                                    child: Text("Go Back",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .textstylelatomedium161
                                                            .copyWith(
                                                                fontSize:
                                                                    getFontSize(
                                                                        16))))),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    right: getHorizontalSize(
                                                        24.00)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      onTapBtnNext();
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: getVerticalSize(
                                                            50.00),
                                                        width:
                                                            getHorizontalSize(
                                                                152.00),
                                                        decoration: AppDecoration
                                                            .textstylelatomedium16,
                                                        child: Text("Next",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .textstylelatomedium16
                                                                .copyWith(
                                                                    fontSize:
                                                                        getFontSize(
                                                                            16))))))
                                          ])))
                            ])),
                  )
                ])));
  }

  onTapBtnGoback() {
    //Get.toNamed(AppRoutes.userRegistrationEmailMobileOtpVerificationScreen);
    Navigator.of(context).pop();
  }

  Future<void> onTapBtnNext() async {
    if (oldpassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Enter old Password", style: TextStyle(fontSize: 12))));
      return;
    }
    if (setpassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Enter New Password", style: TextStyle(fontSize: 12))));
          return;
    }

    if (confirmpassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text("Enter confirm Password", style: TextStyle(fontSize: 12))));
              return;
    }
    if (setpassword.text.length < 8 && !pass_valid.hasMatch(setpassword.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text(
              "Your password must be 8 or more character long & mix of\nupper & lower case letters, nmuber & symbols.",
              style: TextStyle(fontSize: 12))));
              return;
    }
    if (setpassword.text != confirmpassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
              Text("Password Doesnot match", style: TextStyle(fontSize: 12))));
              return;
    }
    

    if (setpassword.text == confirmpassword.text &&
        setpassword.text.length >= 8 &&
        pass_valid.hasMatch(setpassword.text)) {
      var authNotifier =
          Provider.of<ChangePasswordNotifier>(context, listen: false);
      authNotifier.changepassword(
          context: context,
          oldpassword: oldpassword.text,
          newpassword: confirmpassword.text);
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       backgroundColor: Colors.black,
    //       content:
    //           Text("Fill in the details", style: TextStyle(fontSize: 12))));
    // }
    // check if set and confirm password both are same
    // if (_formkey.currentState!.validate()) {
    //   createuser.creatUser(
    //       context: context,
    //       useremail: data["email"],
    //       userpassword: confirmpassword.text.trim(),
    //       userotp: data["otp"]);
    // } else {
    //   return "Unsuccesfull";
    // }
  }
}
