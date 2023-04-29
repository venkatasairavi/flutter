
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_decoration.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/core/notifiers/authentication.notifier.dart';
import 'package:moibleapi/meta/views/setPassword/notifier/PasswordNotifier.dart';
import 'package:provider/provider.dart';

class UserRegistrationProfilePasswordScreen extends StatefulWidget {
  const UserRegistrationProfilePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UserRegistrationProfilePasswordScreen> createState() => _UserRegistrationProfilePasswordScreenState();
}

class _UserRegistrationProfilePasswordScreenState extends State<UserRegistrationProfilePasswordScreen> {

  TextEditingController setpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  double password_strength = 0;

  var data;

  var _isReset = "";

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
    } else if (_password.length  >= 2 && _password.length <= 4) {
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
        passwordStrength4 = true;  //string length greater then 6 & less then 8
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
         resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.indigo800,
        body: Container(
            decoration: BoxDecoration(color: ColorConstant.indigo800),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding:
                              EdgeInsets.only(top: getVerticalSize(55.00)),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(29.00),
                                          right: getHorizontalSize(28.00)),
                                      child: SizedBox(
                                          height: getVerticalSize(27.00),
                                          width: getHorizontalSize(138.00),
                                          child: SvgPicture.asset(
                                              ImageConstant.imgApplogo5,
                                              fit: BoxFit.fill)),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                                29.00),
                                            top: getVerticalSize(46.00),
                                            right: getHorizontalSize(
                                                29.00)),
                                        child: Text("Welcome,",
                                            overflow:
                                            TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatobold221
                                                .copyWith(
                                                fontSize:
                                                getFontSize(
                                                    22)))),
                                    Container(
                                        width:
                                        getHorizontalSize(318.00),
                                        margin: EdgeInsets.only(
                                            left: getHorizontalSize(
                                                29.00),
                                            top: getVerticalSize(11.00),
                                            right: getHorizontalSize(
                                                28.00)),
                                        child: Text(
                                            "Let’s get you all set up so you can verify your personal details and begin setting up your profile.",
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium164
                                                .copyWith(
                                                fontSize:
                                                getFontSize(16),
                                                height: 1.50))),
                                    Expanded(
                                        flex: 1,
                                        child:
                                        Container(
                                            margin: EdgeInsets.only(
                                                top:
                                                getVerticalSize(34.00)),
                                            decoration: BoxDecoration(
                                                color: ColorConstant.gray50,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        getHorizontalSize(
                                                            30.00)),
                                                    topRight: Radius.circular(
                                                        getHorizontalSize(
                                                            30.00)),
                                                    bottomLeft: Radius.circular(
                                                        getHorizontalSize(
                                                            0.00)),
                                                    bottomRight: Radius.circular(
                                                        getHorizontalSize(0.00))),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: ColorConstant
                                                          .indigo900,
                                                      spreadRadius:
                                                      getHorizontalSize(
                                                          2.00),
                                                      blurRadius:
                                                      getHorizontalSize(
                                                          2.00),
                                                      offset: Offset(-9, 0))
                                                ]),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                      visible: data[0] == null
                                                          ? false
                                                          : true,
                                                      child:
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: getVerticalSize(
                                                                      39.00)),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  children: [
                                                                    Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left: getHorizontalSize(
                                                                                16.00),
                                                                            top: getVerticalSize(
                                                                                9.00),
                                                                            bottom: getVerticalSize(
                                                                                9.76)),
                                                                        child: FittedBox(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          child: SvgPicture
                                                                              .asset(
                                                                              'assets/images/user_male.svg'),
                                                                        )),

                                                                    Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            getHorizontalSize(
                                                                                16.00),
                                                                            top:
                                                                            getVerticalSize(
                                                                                9.00),
                                                                            bottom:
                                                                            getVerticalSize(
                                                                                9.76)),
                                                                        child: Column(
                                                                            mainAxisSize:
                                                                            MainAxisSize
                                                                                .min,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              Text(
                                                                                  "Username",
                                                                                  overflow: TextOverflow
                                                                                      .ellipsis,
                                                                                  textAlign: TextAlign
                                                                                      .left,
                                                                                  style: AppStyle
                                                                                      .textstylelatomedium14
                                                                                      .copyWith(
                                                                                      fontSize: getFontSize(
                                                                                          15))),
                                                                              const SizedBox(
                                                                                height: 10,),
                                                                              Flexible(
                                                                                  child: Text(
                                                                                      data ==
                                                                                          null
                                                                                          ? ""
                                                                                          : data["firstName"] +
                                                                                          " " +
                                                                                          data["lastName"],
                                                                                      overflow: TextOverflow
                                                                                          .ellipsis,
                                                                                      textAlign: TextAlign
                                                                                          .left,
                                                                                      style: AppStyle
                                                                                          .textstylelatomedium18
                                                                                          .copyWith(
                                                                                          fontSize: getFontSize(
                                                                                              15)))),

                                                                            ]))


                                                                  ])
                                                          ))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                          getHorizontalSize(
                                                              25.00),
                                                          top: getVerticalSize(
                                                              20.00),
                                                          right:
                                                          getHorizontalSize(
                                                              29.00)),
                                                      child: Text("Set Password *",
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
                                                              25.00),
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
                                                            keyboardType: TextInputType.text,
                                                            controller: setpassword,
                                                            obscureText: !_passwordVisible,
                                                            onChanged: (value) {
                                                              validatePassword(setpassword.text);
                                                            },
                                                            decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                "Enter password",
                                                                hintStyle: AppStyle
                                                                    .textstylelatoregular14
                                                                    .copyWith(
                                                                    fontSize: getFontSize(
                                                                        14.0),
                                                                    color: ColorConstant
                                                                        .bluegray600),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        getHorizontalSize(
                                                                            3.85)),
                                                                    borderSide: BorderSide(
                                                                        color: ColorConstant
                                                                            .indigo80026,
                                                                        width: 0.77)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        getHorizontalSize(
                                                                            3.85)),
                                                                    borderSide: BorderSide(
                                                                        color: ColorConstant
                                                                            .indigo80026,
                                                                        width: 0.77)),
                                                                suffixIcon: IconButton(
                                                                  icon: Icon(
                                                                    // Based on passwordVisible state choose the icon
                                                                      _passwordVisible
                                                                          ? Icons
                                                                          .visibility
                                                                          : Icons
                                                                          .visibility_off,
                                                                      color: ColorConstant
                                                                          .black900
                                                                  ),
                                                                  onPressed: () {
                                                                    // Update the state i.e. toogle the state of passwordVisible variable
                                                                    setState(() {
                                                                      _passwordVisible =
                                                                      !_passwordVisible;
                                                                    });
                                                                  },
                                                                ),
                                                                suffixIconConstraints: BoxConstraints(
                                                                    minWidth: getSize(
                                                                        18.00),
                                                                    minHeight: getSize(
                                                                        18.00)),
                                                                filled: true,
                                                                fillColor: ColorConstant
                                                                    .gray50,
                                                                isDense: true,
                                                                contentPadding: EdgeInsets
                                                                    .only(
                                                                    left: getHorizontalSize(
                                                                        10.00),
                                                                    top: getVerticalSize(
                                                                        15.21),
                                                                    bottom: getVerticalSize(
                                                                        15.21))),
                                                            //This will obscure text dynamically
                                                          ))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                          getHorizontalSize(
                                                              25.00),
                                                          top: getVerticalSize(
                                                              18.00),
                                                          right:
                                                          getHorizontalSize(
                                                              29.00)),
                                                      child: Text("Confirm Password *",
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
                                                              25.00),
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
                                                            keyboardType: TextInputType.text,
                                                            controller: confirmpassword,
                                                            onChanged: (value) {

                                                            },
                                                            obscureText: !_confirmPasswordVisible,
                                                            decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                "Enter password",
                                                                hintStyle: AppStyle
                                                                    .textstylelatoregular14
                                                                    .copyWith(
                                                                    fontSize: getFontSize(
                                                                        14.0),
                                                                    color: ColorConstant
                                                                        .bluegray600),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        getHorizontalSize(
                                                                            3.85)),
                                                                    borderSide: BorderSide(
                                                                        color: ColorConstant
                                                                            .indigo80026,
                                                                        width: 0.77)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        getHorizontalSize(
                                                                            3.85)),
                                                                    borderSide: BorderSide(
                                                                        color: ColorConstant
                                                                            .indigo80026,
                                                                        width: 0.77)),
                                                                suffixIcon: IconButton(
                                                                  icon: Icon(
                                                                    // Based on passwordVisible state choose the icon
                                                                      _confirmPasswordVisible
                                                                          ? Icons
                                                                          .visibility
                                                                          : Icons
                                                                          .visibility_off,
                                                                      color: ColorConstant
                                                                          .black900
                                                                  ),
                                                                  onPressed: () {
                                                                    // Update the state i.e. toogle the state of passwordVisible variable
                                                                    setState(() {
                                                                      _confirmPasswordVisible = !_confirmPasswordVisible;
                                                                    });
                                                                  },
                                                                ),
                                                                suffixIconConstraints: BoxConstraints(
                                                                    minWidth: getSize(
                                                                        18.00),
                                                                    minHeight: getSize(
                                                                        18.00)),
                                                                filled: true,
                                                                fillColor: ColorConstant
                                                                    .gray50,
                                                                isDense: true,
                                                                contentPadding: EdgeInsets
                                                                    .only(
                                                                    left: getHorizontalSize(
                                                                        10.00),
                                                                    top: getVerticalSize(
                                                                        15.21),
                                                                    bottom: getVerticalSize(
                                                                        15.21))),
                                                            //This will obscure text dynamically
                                                          ))),
                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: EdgeInsets.only(
                                                              top: getVerticalSize(
                                                                  22.00)),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              children: [
                                                                Container(
                                                                    height:
                                                                    getSize(7.00),
                                                                    width:
                                                                    getSize(7.00),
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                        getHorizontalSize(
                                                                            29.00),
                                                                        top:
                                                                        getVerticalSize(
                                                                            5.00),
                                                                        bottom:
                                                                        getVerticalSize(
                                                                            16.00)),
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                        ColorConstant
                                                                            .tealA700,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            getHorizontalSize(30.00)))),
                                                                Container(
                                                                    width:
                                                                    getHorizontalSize(
                                                                        301.00),
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                        getHorizontalSize(
                                                                            8.00),
                                                                        right:
                                                                        getHorizontalSize(
                                                                            30.00)),
                                                                    child: RichText(
                                                                        text: TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                  text:
                                                                                  "Your password must be 8 or more character long & a mix of upper & lower case letters, number & symbols.",
                                                                                  style: TextStyle(
                                                                                      color: ColorConstant.bluegray600,
                                                                                      fontSize: getFontSize(14),
                                                                                      fontFamily: 'Lato',
                                                                                      fontWeight: FontWeight.w500)),
                                                                            ]),
                                                                        textAlign:
                                                                        TextAlign
                                                                            .left))
                                                              ]))),
                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: EdgeInsets.only(
                                                              top: getVerticalSize(
                                                                  22.00)),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              children: [
                                                                Container(
                                                                    height:
                                                                    getVerticalSize(
                                                                        6.00),
                                                                    width:
                                                                    getHorizontalSize(
                                                                        74.00),
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                        getHorizontalSize(
                                                                            30.00)),
                                                                    decoration: BoxDecoration(
                                                                        color: passwordStrength1 == true ? ColorConstant.tealA700 :  ColorConstant.gray30099,
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            getHorizontalSize(
                                                                                10.00)))),
                                                                Container(
                                                                    height:
                                                                    getVerticalSize(
                                                                        6.00),
                                                                    width:
                                                                    getHorizontalSize(
                                                                        74.00),
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                        getHorizontalSize(
                                                                            7.00)),
                                                                    decoration: BoxDecoration(
                                                                        color: passwordStrength2 == true ? ColorConstant.tealA700 :  ColorConstant.gray30099,
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            getHorizontalSize(
                                                                                10.00)))),
                                                                Container(
                                                                    height:
                                                                    getVerticalSize(
                                                                        6.00),
                                                                    width:
                                                                    getHorizontalSize(
                                                                        74.00),
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                        getHorizontalSize(
                                                                            6.00)),
                                                                    decoration: BoxDecoration(
                                                                        color: passwordStrength3 == true ? ColorConstant.tealA700 :  ColorConstant.gray30099,
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            getHorizontalSize(
                                                                                10.00)))),
                                                                Container(
                                                                    height:
                                                                    getVerticalSize(
                                                                        6.00),
                                                                    width:
                                                                    getHorizontalSize(
                                                                        74.00),
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                        getHorizontalSize(
                                                                            7.00),
                                                                        right:
                                                                        getHorizontalSize(
                                                                            29.00)),
                                                                    decoration: BoxDecoration(
                                                                        color: passwordStrength4 == true ? ColorConstant.tealA700 :  ColorConstant.gray30099,
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            getHorizontalSize(
                                                                                10.00)))),
                                                              ]))),
                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: getHorizontalSize(
                                                                  29.00),
                                                              top: getVerticalSize(
                                                                  10.00),
                                                              right: getHorizontalSize(
                                                                  29.00)),
                                                          child: Text(
                                                              "Password Strength",
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                              style: AppStyle
                                                                  .textstylelatomedium12
                                                                  .copyWith(
                                                                  fontSize:
                                                                  getFontSize(
                                                                      12))))),
                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: EdgeInsets.only(
                                                              top: getVerticalSize(
                                                                  64.00),
                                                              bottom: getVerticalSize(
                                                                  50.00)),
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
                                                                                .copyWith(fontSize: getFontSize(16))))),
                                                                Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                        getHorizontalSize(
                                                                            24.00)),
                                                                    child:
                                                                    GestureDetector(
                                                                        onTap: () {
                                                                          onTapBtnFinish();
                                                                        },
                                                                        child: Container(
                                                                            alignment:
                                                                            Alignment
                                                                                .center,
                                                                            height: getVerticalSize(
                                                                                50.00),
                                                                            width: getHorizontalSize(
                                                                                152.00),
                                                                            decoration:
                                                                            AppDecoration
                                                                                .textstylelatomedium16,
                                                                            child: Text(
                                                                                "Finish",
                                                                                textAlign:
                                                                                TextAlign.left,
                                                                                style: AppStyle.textstylelatomedium16.copyWith(fontSize: getFontSize(16))))))
                                                              ])))
                                                ]
                                            )
                                        )
                                    )
                                  ]))))
                ]
            )
        )
    );
  }

  void onTapBtnFinish() async {
    if(setpassword.text.isNotEmpty){
      if(setpassword.text == confirmpassword.text){
        if(setpassword.text.length >= 8){
          if (pass_valid.hasMatch(setpassword.text)) {

            var updatePasswd = Provider.of<PasswordNotifier>(context, listen: false);
            // check if set and confirm password both are same
            updatePasswd.updatePassword(
                context: context,
                useremail: data["email"],
                userpassword: confirmpassword.text.trim(),
                userotp: data["otp"]);

          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.black,
                content:
                Text( "Your password must be 8 or more character long & a mix of upper & lower case letters, number & symbols.",
                    style: TextStyle(fontSize: 12))));
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.black,
              content:
              Text("length of password should be atleast 8 characters", style: TextStyle(fontSize: 12))));
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black,
            content:
            Text("Passwords doesn't match", style: TextStyle(fontSize: 12))));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content:
          Text("Password can't be empty", style: TextStyle(fontSize: 12))));
    }

  }

  void onTapBtnGoback(){
    Navigator.pop(context);
  }

}