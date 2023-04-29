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

class UserRegistrationStep2Screen extends StatefulWidget {
  const UserRegistrationStep2Screen({Key? key}) : super(key: key);

//  final String firtname ;
//   final String lastname;
//   final String date;
//   final String email;
//   const UserRegistrationStep2Screen({Key? key,required this.date,required this.email,required this.firtname,required this.lastname,}) : super(key: key);

  @override
  State<UserRegistrationStep2Screen> createState() => _UserRegistrationStep2ScreenState();
}

class _UserRegistrationStep2ScreenState extends State<UserRegistrationStep2Screen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryPhnCode = TextEditingController();

  TextEditingController idtypeController = TextEditingController();

  TextEditingController zipCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();

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
                                                          text: "02/",
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
                                              controller: countryPhnCode,
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
                                              28.00)),
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
                                                child: Text("ID Type *",
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle.textstylelatomedium142.copyWith(fontSize: getFontSize(14)))),
                                            Container(
                                                height:
                                                getVerticalSize(
                                                    45.00),
                                                width:
                                                getHorizontalSize(
                                                    318.00),
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
                                                        6.00)),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                  child: DropdownButton<String>(
                                                    underline:
                                                    const SizedBox(),
                                                    autofocus: true,
                                                    isExpanded: true,
                                                    // hint: Text('$dropdownValue',style: TextStyle(fontSize: 10),),
                                                    // Step 3.
                                                    value: dropdownValue,
                                                    // Step 4.
                                                    items: <String>[
                                                      'National Identification',
                                                      'Passport',
                                                      'Driving License'
                                                    ].map<
                                                        DropdownMenuItem<
                                                            String>>((String
                                                    value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(value,
                                                          style: TextStyle(
                                                              fontSize:
                                                              14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              color: ColorConstant
                                                                  .bluegray600),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    // Step 5.
                                                    onChanged: (
                                                        String?
                                                        newValue) {
                                                      setState(() {
                                                        dropdownValue = newValue!;
                                                      });
                                                    },
                                                  ),
                                                )
                                            )
                                            // DropdownButton<
                                            //         SelectionPopupModel>(
                                            //     autofocus:
                                            //         true,
                                            //     isExpanded:
                                            //         true,
                                            //     underline:
                                            //         const SizedBox(),
                                            //     hint: Text("lbl_select_id_type",
                                            //         textAlign: TextAlign
                                            //             .left,
                                            //         style: TextStyle(
                                            //             color: ColorConstant.bluegray600,
                                            //             fontSize: getFontSize(14),
                                            //             fontFamily: 'Lato',
                                            //             fontWeight: FontWeight.w400,
                                            //             height: 1.50)),
                                            //     value: dropdownItemList.firstWhere((element) => element.isSelected),
                                            //     onChanged: (value) {
                                            //       onSelected(
                                            //           value);
                                            //     },
                                            //     items: dropdownItemList.map((SelectionPopupModel itemCount) {
                                            //       return DropdownMenuItem<SelectionPopupModel>(
                                            //           value:
                                            //               itemCount,
                                            //           child:
                                            //               Text(itemCount.title, textAlign: TextAlign.left));
                                            //     }).toList(),
                                            //     selectedItemBuilder: (BuildContext context) {
                                            //       return dropdownItemList.map((SelectionPopupModel
                                            //           itemCount) {
                                            //         return Text(
                                            //             itemCount.title,
                                            //             textAlign: TextAlign.left,
                                            //             style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14), fontFamily: 'Lato', fontWeight: FontWeight.w400, height: 1.50));
                                            //       }).toList();
                                            //     })
                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              20.00),
                                          right:
                                          getHorizontalSize(
                                              28.00)),
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
                                                    "Document ID Number *"
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
                                                        getFontSize(
                                                            14)))),
                                            Padding(
                                                padding: EdgeInsets
                                                    .only(
                                                    top: getVerticalSize(
                                                        6.00)),
                                                child: SizedBox(
                                                    height:
                                                    getVerticalSize(
                                                        45.00),
                                                    width:
                                                    getHorizontalSize(
                                                        318.00),
                                                    child: TextFormField(
                                                        controller:
                                                        idtypeController,
                                                        decoration: InputDecoration(
                                                            hintText: "Type here"
                                                            ,
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
                                                            suffixIcon: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    left: getHorizontalSize(
                                                                        10.00),
                                                                    right: getHorizontalSize(
                                                                        18.00)),
                                                                child: SizedBox(
                                                                    height: getSize(
                                                                        18.00),
                                                                    width: getSize(
                                                                        18.00),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                        ImageConstant
                                                                            .imgFrame8532,
                                                                        fit: BoxFit
                                                                            .contain))),
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
                                                                    15.50),
                                                                bottom: getVerticalSize(
                                                                    15.50))),
                                                        style: TextStyle(
                                                            color: ColorConstant
                                                                .bluegray600,
                                                            fontSize: getFontSize(
                                                                14.0),
                                                            fontFamily: 'Lato',
                                                            fontWeight: FontWeight
                                                                .w400))))
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
                                                    "State *",
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
                                                            14)))),
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
                                                  controller: stateController,
                                                    decoration: InputDecoration(
                                                      hintText: "State",
                                                      hintStyle: AppStyle.textstylelatoregular14.copyWith(fontSize: getFontSize(14.0), color: ColorConstant.bluegray600),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                          borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),


                                                    )
                                                )
                                            )
                                            // DropdownButton<
                                            //         SelectionPopupModel>(
                                            //     autofocus:
                                            //         true,
                                            //     isExpanded:
                                            //         true,
                                            //     underline:
                                            //         const SizedBox(),
                                            //     hint: Text("lbl_state",
                                            //         textAlign: TextAlign
                                            //             .left,
                                            //         style: TextStyle(
                                            //             color: ColorConstant.bluegray600,
                                            //             fontSize: getFontSize(14),
                                            //             fontFamily: 'Lato',
                                            //             fontWeight: FontWeight.w400,
                                            //             height: 1.50)),
                                            //     value: dropdownItemList1.firstWhere((element) => element.isSelected),
                                            //     onChanged: (value) {
                                            //       onSelected1(
                                            //           value);
                                            //     },
                                            //     items: dropdownItemList1.map((SelectionPopupModel itemCount) {
                                            //       return DropdownMenuItem<SelectionPopupModel>(
                                            //           value:
                                            //               itemCount,
                                            //           child:
                                            //               Text(itemCount.title, textAlign: TextAlign.left));
                                            //     }).toList(),
                                            //     selectedItemBuilder: (BuildContext context) {
                                            //       return dropdownItemList1.map((SelectionPopupModel
                                            //           itemCount) {
                                            //         return Text(
                                            //             itemCount.title,
                                            //             textAlign: TextAlign.left,
                                            //             style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14), fontFamily: 'Lato', fontWeight: FontWeight.w400, height: 1.50));
                                            //       }).toList();
                                            //     })
                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              18.00),
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
                                                    left:
                                                    getHorizontalSize(
                                                        1.00),
                                                    right:
                                                    getHorizontalSize(
                                                        10.00)),
                                                child: Text(
                                                    "Country *"
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
                                                        getFontSize(
                                                            14)))),
                                            Container(
                                                height:
                                                getVerticalSize(
                                                    45.00),
                                                width:
                                                getHorizontalSize(
                                                    317.00),
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
                                                        8.00)),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:EdgeInsets.only(
                                                        left: getHorizontalSize(
                                                            10.00),
                                                      ),
                                                      child: Text(
                                                          "USA",
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .textstylelatomedium142
                                                              .copyWith(
                                                              fontSize:
                                                              getFontSize(
                                                                  14))),
                                                    )
                                                )
                                            )
                                            // DropdownButton<
                                            //         SelectionPopupModel>(
                                            //     autofocus:
                                            //         true,
                                            //     isExpanded:
                                            //         true,
                                            //     underline:
                                            //         const SizedBox(),
                                            //     hint: Text("lbl_country",
                                            //         textAlign: TextAlign
                                            //             .left,
                                            //         style: TextStyle(
                                            //             color: ColorConstant.bluegray600,
                                            //             fontSize: getFontSize(14),
                                            //             fontFamily: 'Lato',
                                            //             fontWeight: FontWeight.w400,
                                            //             height: 1.50)),
                                            //     value: dropdownItemList2.firstWhere((element) => element.isSelected),
                                            //     onChanged: (value) {
                                            //       onSelected2(
                                            //           value);
                                            //     },
                                            //     items: dropdownItemList2.map((SelectionPopupModel itemCount) {
                                            //       return DropdownMenuItem<SelectionPopupModel>(
                                            //           value:
                                            //               itemCount,
                                            //           child:
                                            //               Text(itemCount.title, textAlign: TextAlign.left));
                                            //     }).toList(),
                                            //     selectedItemBuilder: (BuildContext context) {
                                            //       return dropdownItemList2.map((SelectionPopupModel
                                            //           itemCount) {
                                            //         return Text(
                                            //             itemCount.title,
                                            //             textAlign: TextAlign.left,
                                            //             style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14), fontFamily: 'Lato', fontWeight: FontWeight.w400, height: 1.50));
                                            //       }).toList();
                                            //     })
                                          ]))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(
                                              29.00),
                                          top: getVerticalSize(
                                              21.00),
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
                                                    "Zip Code *"
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
                                                        getFontSize(
                                                            14)))),
                                            Padding(
                                                padding: EdgeInsets
                                                    .only(
                                                    top: getVerticalSize(
                                                        8.00)),
                                                child: SizedBox(
                                                    height:
                                                    getVerticalSize(
                                                        45.00),
                                                    width:
                                                    getHorizontalSize(
                                                        316.00),
                                                    child: TextFormField(
                                                        keyboardType:
                                                        TextInputType
                                                            .number,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                        ],
                                                        controller:
                                                        zipCodeController,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                            "Zip Code",
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
                                                            filled: true,
                                                            fillColor: ColorConstant
                                                                .gray50,
                                                            isDense: true,
                                                            contentPadding: EdgeInsets
                                                                .only(
                                                                left: getHorizontalSize(
                                                                    10.00),
                                                                top: getVerticalSize(
                                                                    15.50),
                                                                bottom: getVerticalSize(
                                                                    15.50))),
                                                        style: TextStyle(
                                                            color: ColorConstant
                                                                .bluegray600,
                                                            fontSize: getFontSize(
                                                                14.0),
                                                            fontFamily: 'Lato',
                                                            fontWeight: FontWeight
                                                                .w400))))
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
          .showSnackBar(const SnackBar(content: Text("Enter mobile number")));
      return;
    }

    if (idtypeController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter ID Number")));
      return;
    }

    if (zipCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter ZIP code")));
      return;
    }

    //Navigator.of(context).pushNamed(UserOtpRoute);

    var doctorNotifier = Provider.of<RegistrationNotifier>(context, listen: false);

    final jsonData = jsonEncode({
      "countryCode": "US",
      "countryPhnCode": "+1",
      "middleName": "",
      "dateOfBirth": data[2],
      "documentNumber": idtypeController.text.trim(),
      "email": data[3],
      "firstName": data[0],
      "gender": data[4],
      "lastName": data[1],
      "phoneNumber": phoneNumberController.text.trim(),
      "state": stateController.text.trim(),
      "zipCode": zipCodeController.text.trim(),
      "country": "United States",
      "typeId": dropdownValue,
      "timeZone": _timezone,
      "userType": "DOCTOR",

    });

    doctorNotifier.registerDoctor(docData: jsonData, context: context);

  }
}