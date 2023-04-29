import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_decoration.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/meta/views/userregistrationview/notifier/RegistrationNotifier.dart';
import 'package:provider/provider.dart';

class UserPatientRegistrationStep2Screen extends StatefulWidget {
  const UserPatientRegistrationStep2Screen({Key? key}) : super(key: key);

//  final String firtname ;
//   final String lastname;
//   final String date;
//   final String email;
//   const UserPatientRegistrationStep2Screen({Key? key,required this.date,required this.email,required this.firtname,required this.lastname,}) : super(key: key);

  @override
  State<UserPatientRegistrationStep2Screen> createState() => _UserPatientRegistrationStep2ScreenState();
}

class _UserPatientRegistrationStep2ScreenState extends State<UserPatientRegistrationStep2Screen> {
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController ninController = TextEditingController();

  TextEditingController ssnController = TextEditingController();

  TextEditingController houseNoController = TextEditingController();

  TextEditingController streetNameController = TextEditingController();

  TextEditingController apprController = TextEditingController();

  //SelectionPopupModel? selectedDropDownValue;
  String dropdownValue = 'National Identification';
  String dropdownValue1 = 'Texas';
  String dropdownValue2 = 'USA';
  late String countrycode;
  late String country;
  var _timezone = "";

  var data;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
          backgroundColor: ColorConstant.indigo800,
          resizeToAvoidBottomInset: false,
          body:
          Container(
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
                                top: getVerticalSize(56.00),
                                right: getHorizontalSize(29.00)),
                            child: SizedBox(
                                height: getVerticalSize(27.00),
                                width: getHorizontalSize(138.00),
                                child: SvgPicture.asset(
                                    ImageConstant.imgApplogo2,
                                    fit: BoxFit.fill)))),
                    Expanded(child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: getVerticalSize(21.00)),
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
                                    getHorizontalSize(0.00)))),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getHorizontalSize(
                                          29.00),
                                      top: getVerticalSize(
                                          25.00),
                                      right: getHorizontalSize(
                                          29.00)),
                                  child: Text(
                                      "Register Now",
                                      overflow:
                                      TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle
                                          .textstylelatobold22
                                          .copyWith(
                                          fontSize:
                                          getFontSize(
                                              22)))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                      getVerticalSize(14.00)),
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      mainAxisSize:
                                      MainAxisSize.max,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets
                                                .only(
                                                left:
                                                getHorizontalSize(
                                                    29.00)),
                                            child: Text(
                                                "Contact Details",
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                textAlign:
                                                TextAlign
                                                    .left,
                                                style: AppStyle
                                                    .textstylelatobold18
                                                    .copyWith(
                                                    fontSize:
                                                    getFontSize(
                                                        18)))),
                                        Container(
                                            margin: EdgeInsets
                                                .only(
                                                top:
                                                getVerticalSize(
                                                    5.00),
                                                right:
                                                getHorizontalSize(
                                                    30.00)),
                                            child: RichText(
                                                text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "Step ",
                                                          style: TextStyle(
                                                              color: ColorConstant
                                                                  .indigo900,
                                                              fontSize: getFontSize(
                                                                  14),
                                                              fontFamily:
                                                              'Lato',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700)),
                                                      TextSpan(
                                                          text: "02/"
                                                          ,
                                                          style: TextStyle(
                                                              color: ColorConstant
                                                                  .cyan400,
                                                              fontSize: getFontSize(
                                                                  14),
                                                              fontFamily:
                                                              'Lato',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700)),
                                                      TextSpan(
                                                          text: "02"
                                                          ,
                                                          style: TextStyle(
                                                              color: ColorConstant
                                                                  .bluegray900,
                                                              fontSize: getFontSize(
                                                                  14),
                                                              fontFamily:
                                                              'Lato',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700))
                                                    ]),
                                                textAlign: TextAlign
                                                    .left))
                                      ])),
                              Row(
                                children: <Widget>[
                                  Flexible(child:  Align(
                                    alignment: Alignment.center,
                                    child:
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(29.00),
                                            top: getVerticalSize(10.00),
                                       ),
                                        child:  SizedBox(
                                            height:
                                            getVerticalSize(
                                                45.00),
                                            child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: "+1",
                                                  hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                      borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                      borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                )
                                            )
                                        )
                                    ),
                                  ), flex: 2,),
                                  Flexible(child:  Align(
                                    alignment: Alignment.center,
                                    child:
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(
                                                5.00),
                                            top: getVerticalSize(
                                                10.00),
                                            right:
                                            getHorizontalSize(
                                                28.00)),
                                        child:  SizedBox(
                                            height:
                                            getVerticalSize(
                                                45.00),
                                            width:
                                            getHorizontalSize(
                                                318.00),
                                            child: TextFormField(
                                              controller: phoneNumberController,
                                              inputFormatters: [
                                                 LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                              ],
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: "Phone number",
                                                  hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                      borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                      borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                )
                                            )

                                        )

                                    ),
                                  ), flex: 8,)
                                ],
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              19.00),
                                          right:
                                          getHorizontalSize(
                                              29.00)),
                                      child: Column(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets
                                                    .only(
                                                    right:
                                                    getHorizontalSize(
                                                        10.00)),
                                                child: Text(
                                                    "National Identification Number",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.textstylelatomedium142.copyWith(fontSize: getFontSize(14)))),
                                            Container(
                                                height:
                                                getVerticalSize(
                                                    45.00),
                                                width:
                                                getHorizontalSize(
                                                    316.00),
                                                decoration: BoxDecoration(
                                                    color:
                                                    ColorConstant
                                                        .gray50,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        getHorizontalSize(
                                                            3.85)),
                                                    border: Border
                                                        .all(
                                                        color: ColorConstant
                                                            .indigo80026,
                                                        width: getHorizontalSize(
                                                            0.77))),
                                                margin: EdgeInsets
                                                    .only(
                                                    top:
                                                    getVerticalSize(
                                                        5.00)),
                                                child: TextFormField(
                                                  controller: ninController,
                                                    decoration: InputDecoration(
                                                      hintText: "NIN",
                                                      hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),


                                                    )
                                                )
                                            )

                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              19.00),
                                          right:
                                          getHorizontalSize(
                                              29.00)),
                                      child: Column(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets
                                                    .only(
                                                    right:
                                                    getHorizontalSize(
                                                        10.00)),
                                                child: Text(
                                                    "SSN",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.textstylelatomedium142.copyWith(fontSize: getFontSize(14)))),
                                            Container(
                                                height:
                                                getVerticalSize(
                                                    45.00),
                                                width:
                                                getHorizontalSize(
                                                    316.00),
                                                decoration: BoxDecoration(
                                                    color:
                                                    ColorConstant
                                                        .gray50,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        getHorizontalSize(
                                                            3.85)),
                                                    border: Border
                                                        .all(
                                                        color: ColorConstant
                                                            .indigo80026,
                                                        width: getHorizontalSize(
                                                            0.77))),
                                                margin: EdgeInsets
                                                    .only(
                                                    top:
                                                    getVerticalSize(
                                                        5.00)),
                                                child: TextFormField(
                                                    controller: ssnController,
                                                    decoration: InputDecoration(
                                                      hintText: "Type here",
                                                      hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),


                                                    )
                                                )
                                            )

                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              19.00),
                                          right:
                                          getHorizontalSize(
                                              29.00)),
                                      child: Column(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets
                                                    .only(
                                                    right:
                                                    getHorizontalSize(
                                                        10.00)),
                                                child: Text(
                                                    "House No *",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.textstylelatomedium142.copyWith(fontSize: getFontSize(14)))),
                                            Container(
                                                height:
                                                getVerticalSize(
                                                    45.00),
                                                width:
                                                getHorizontalSize(
                                                    316.00),
                                                decoration: BoxDecoration(
                                                    color:
                                                    ColorConstant
                                                        .gray50,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        getHorizontalSize(
                                                            3.85)),
                                                    border: Border
                                                        .all(
                                                        color: ColorConstant
                                                            .indigo80026,
                                                        width: getHorizontalSize(
                                                            0.77))),
                                                margin: EdgeInsets
                                                    .only(
                                                    top:
                                                    getVerticalSize(
                                                        5.00)),
                                                child: TextFormField(
                                                    controller: houseNoController,
                                                    decoration: InputDecoration(
                                                      hintText: "House No",
                                                      hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    )
                                                )
                                            )

                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              19.00),
                                          right:
                                          getHorizontalSize(
                                              29.00)),
                                      child: Column(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets
                                                    .only(
                                                    right:
                                                    getHorizontalSize(
                                                        10.00)),
                                                child: Text(
                                                    "Street Name *",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.textstylelatomedium142.copyWith(fontSize: getFontSize(14)))),
                                            Container(
                                                height:
                                                getVerticalSize(
                                                    45.00),
                                                width:
                                                getHorizontalSize(
                                                    316.00),
                                                decoration: BoxDecoration(
                                                    color:
                                                    ColorConstant
                                                        .gray50,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        getHorizontalSize(
                                                            3.85)),
                                                    border: Border
                                                        .all(
                                                        color: ColorConstant
                                                            .indigo80026,
                                                        width: getHorizontalSize(
                                                            0.77))),
                                                margin: EdgeInsets
                                                    .only(
                                                    top:
                                                    getVerticalSize(
                                                        5.00)),
                                                child: TextFormField(
                                                    controller: streetNameController,
                                                    decoration: InputDecoration(
                                                      hintText: "Street Name",
                                                      hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    )
                                                )
                                            )

                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              19.00),
                                          right:
                                          getHorizontalSize(
                                              29.00)),
                                      child: Column(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets
                                                    .only(
                                                    right:
                                                    getHorizontalSize(
                                                        10.00)),
                                                child: Text(
                                                    "Appartment/Unit No.(Optional)",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.textstylelatomedium142.copyWith(fontSize: getFontSize(14)))),
                                            Container(
                                                height:
                                                getVerticalSize(
                                                    45.00),
                                                width:
                                                getHorizontalSize(
                                                    316.00),
                                                decoration: BoxDecoration(
                                                    color:
                                                    ColorConstant
                                                        .gray50,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        getHorizontalSize(
                                                            3.85)),
                                                    border: Border
                                                        .all(
                                                        color: ColorConstant
                                                            .indigo80026,
                                                        width: getHorizontalSize(
                                                            0.77))),
                                                margin: EdgeInsets
                                                    .only(
                                                    top:
                                                    getVerticalSize(
                                                        5.00)),
                                                child: TextFormField(
                                                    controller: apprController,
                                                    decoration: InputDecoration(
                                                      hintText: "",
                                                      hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    )
                                                )
                                            )

                                          ]))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: getVerticalSize(
                                          34.00),
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
                                            padding: EdgeInsets
                                                .only(
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
                                                    "Go Back"
                                                    ,
                                                    textAlign:
                                                    TextAlign
                                                        .left,
                                                    style: AppStyle
                                                        .textstylelatomedium161
                                                        .copyWith(
                                                        fontSize: getFontSize(
                                                            16))))),
                                        Padding(
                                            padding: EdgeInsets
                                                .only(
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
                                                            .copyWith(
                                                            fontSize: getFontSize(
                                                                16))))))
                                      ]))
                            ])))
                  ]))
      );
  }

 void onTapBtnGoback() {
    Navigator.of(context).pushNamed(UserRegistrationscreenone);
  }

  void onTapBtnNext() async {
    if (phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Mobile Number")));
      return;
    }

    if (houseNoController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter House Name")));
      return;
    }

    if (streetNameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Street Name")));
      return;
    }

    //Navigator.of(context).pushNamed(UserOtpRoute);

    var doctorNotifier = Provider.of<RegistrationNotifier>(context, listen: false);

    final jsonData = jsonEncode({
      "countryCode": "US",
      "countryPhnCode": "+1",
      "middleName": "",
      "dateOfBirth": data[2],
      "email": data[3],
      "firstName": data[0],
      "gender": data[4],
      "lastName": data[1],
      "phoneNumber": phoneNumberController.text.trim(),
      "state": dropdownValue1,
      "zipCode": "",
      "country": "United States",
      "timeZone": _timezone,
      "nin": ninController.text,
      "ssn": ssnController.text,
      "houseNbr": houseNoController.text,
      "streetName": streetNameController.text,
      "aptNbr": apprController.text,
      "mfa": "true",
      "city": "LA",
      "masterCityGuId": "",
      "masterStateGuId": "",
      "userType": "PATIENT",

    });

    doctorNotifier.registerPatient(docData: jsonData, context: context);

  }
}