import 'dart:convert';

import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';

import 'package:moibleapi/app/theme/app_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/core/services/cache.service.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  var data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    print(data);
    print(data["firstName"]);
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.indigo800,
            body: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: ColorConstant.indigo800),
                child: Container(
                    width: double.infinity,
                    // height:
                    //     MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(bottom: getVerticalSize(40.00)),
                    decoration: BoxDecoration(
                      color: ColorConstant.gray50,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(getHorizontalSize(0.00)),
                          topRight: Radius.circular(getHorizontalSize(0.00)),
                          bottomLeft: Radius.circular(getHorizontalSize(30.00)),
                          bottomRight:
                              Radius.circular(getHorizontalSize(30.00))),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  width: size.width,
                                  margin: EdgeInsets.only(
                                      top: getVerticalSize(49.00)),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: getHorizontalSize(20.00),
                                          right: getHorizontalSize(130.00)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  onTapImgBack();
                                                },
                                                child: Container(
                                                    height: getSize(46.00),
                                                    width: getSize(46.00),
                                                    child: SvgPicture.asset(
                                                        ImageConstant.imgBack4,
                                                        fit: BoxFit.fill))),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: getHorizontalSize(
                                                        65.00),
                                                    top: getVerticalSize(14.00),
                                                    bottom:
                                                        getVerticalSize(8.00)),
                                                child: Text("Profile",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .textstylelatomedium181
                                                        .copyWith(
                                                            fontSize:
                                                                getFontSize(18),
                                                            height: 1.33)))
                                          ])))),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(19.00),
                                  top: getVerticalSize(42.00),
                                  right: getHorizontalSize(19.00)),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: getHorizontalSize(10.00)),
                                        child: Text("First Name *",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium142
                                                .copyWith(
                                                    fontSize:
                                                        getFontSize(14)))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: getVerticalSize(6.00)),
                                        child: Container(
                                            height: getVerticalSize(45.00),
                                            width: getHorizontalSize(316.00),
                                            child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                    hintText: data["firstName"],
                                                    hintStyle: AppStyle.textstylelatoregular14.copyWith(
                                                        fontSize:
                                                            getFontSize(14.0),
                                                        color: ColorConstant
                                                            .bluegray600),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                getHorizontalSize(
                                                                    3.85)),
                                                        borderSide: BorderSide(
                                                            color: ColorConstant.indigo80026,
                                                            width: 0.77)),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)), borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    filled: true,
                                                    fillColor: ColorConstant.gray50,
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.only(left: getHorizontalSize(20.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                                                style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400))))
                                  ])),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(19.00),
                                  top: getVerticalSize(19.00),
                                  right: getHorizontalSize(19.00)),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: getHorizontalSize(10.00)),
                                        child: Text("Last Name *",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium142
                                                .copyWith(
                                                    fontSize:
                                                        getFontSize(14)))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: getVerticalSize(6.00)),
                                        child: Container(
                                            height: getVerticalSize(45.00),
                                            width: getHorizontalSize(318.00),
                                            child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                    hintText: data["lastName"],
                                                    hintStyle: AppStyle.textstylelatoregular14.copyWith(
                                                        fontSize:
                                                            getFontSize(14.0),
                                                        color: ColorConstant
                                                            .bluegray600),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                getHorizontalSize(
                                                                    3.85)),
                                                        borderSide: BorderSide(
                                                            color: ColorConstant.indigo80026,
                                                            width: 0.77)),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)), borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    filled: true,
                                                    fillColor: ColorConstant.gray50,
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.only(left: getHorizontalSize(20.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                                                style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400))))
                                  ])),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(19.00),
                                  top: getVerticalSize(18.57),
                                  right: getHorizontalSize(19.00)),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: getHorizontalSize(0.03),
                                            right: getHorizontalSize(10.00)),
                                        child: Text("Date of Birth *",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium142
                                                .copyWith(
                                                    fontSize:
                                                        getFontSize(14)))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: getVerticalSize(3.86)),
                                        child: Container(
                                            height: getVerticalSize(45.00),
                                            width: getHorizontalSize(318.00),
                                            child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        data["dateOfBirth"],
                                                    hintStyle: AppStyle
                                                        .textstylelatoregular14
                                                        .copyWith(
                                                            fontSize:
                                                                getFontSize(
                                                                    14.0),
                                                            color: ColorConstant
                                                                .bluegray600),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                getHorizontalSize(3.85)),
                                                        borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)), borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    suffixIcon: Padding(padding: EdgeInsets.only(left: getHorizontalSize(10.00), right: getHorizontalSize(18.00)), child: Container(height: getSize(18.00), width: getSize(18.00), child: SvgPicture.asset(ImageConstant.imgFrame853, fit: BoxFit.contain))),
                                                    suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                                                    filled: true,
                                                    fillColor: ColorConstant.gray50,
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.only(left: getHorizontalSize(20.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                                                style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400))))
                                  ])),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(19.00),
                                  top: getVerticalSize(20.00),
                                  right: getHorizontalSize(19.00)),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: getHorizontalSize(10.00)),
                                        child: Text("Gender *",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .textstylelatomedium142
                                                .copyWith(
                                                    fontSize:
                                                        getFontSize(14)))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: getVerticalSize(6.00)),
                                        child: Container(
                                            height: getVerticalSize(45.00),
                                            width: getHorizontalSize(316.00),
                                            child: TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                    hintText: data["gender"],
                                                    hintStyle: AppStyle.textstylelatoregular14.copyWith(
                                                        fontSize:
                                                            getFontSize(14.0),
                                                        color: ColorConstant
                                                            .bluegray600),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            getHorizontalSize(
                                                                3.85)),
                                                        borderSide: BorderSide(
                                                            color: ColorConstant.indigo80026,
                                                            width: 0.77)),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(getHorizontalSize(3.85)), borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                    filled: true,
                                                    fillColor: ColorConstant.gray50,
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.only(left: getHorizontalSize(20.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                                                style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400))))
                                  ])),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getHorizontalSize(19.00),
                                  top: getVerticalSize(20.00),
                                  right: getHorizontalSize(19.00)),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: getHorizontalSize(10)),
                                      child: Text("Phone *",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .textstylelatomedium142
                                              .copyWith(
                                                  fontSize:
                                                      getFontSize(14))),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                          left: getHorizontalSize(10),
                                            top: getVerticalSize(6.00),
                                            right: getHorizontalSize(10)),
                                        child: Row(
                                          children: [
                                            Container(
                                                height: getVerticalSize(45.00),
                                                width: getHorizontalSize(50.00),
                                                child: TextFormField(
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                        hintText: "+1",
                                                        hintStyle: AppStyle
                                                            .textstylelatoregular14
                                                            .copyWith(
                                                                fontSize: getFontSize(
                                                                    14.0),
                                                                color: ColorConstant
                                                                    .bluegray300),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    getHorizontalSize(
                                                                        3.85)),
                                                            borderSide: BorderSide(
                                                                color: ColorConstant
                                                                    .indigo80026,
                                                                width: 0.77)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    getHorizontalSize(
                                                                        3.85)),
                                                            borderSide: BorderSide(
                                                                color: ColorConstant.indigo80026,
                                                                width: 0.77)),
                                                        // prefixIcon: Padding(padding: EdgeInsets.only(left: getHorizontalSize(44.00), right: getHorizontalSize(10.00)), child: Container(height: getSize(24.00), width: getSize(24.00), child: SvgPicture.asset(ImageConstant.imgRemixiconsLineSystemArrowdropdownline1, fit: BoxFit.contain))),
                                                        // prefixIconConstraints: BoxConstraints(minWidth: getSize(24.00), minHeight: getSize(24.00)),
                                                        // filled: true,
                                                        // fillColor: ColorConstant.gray50,
                                                        // isDense: true,
                                                        contentPadding: EdgeInsets.only(left: getHorizontalSize(6), top: getVerticalSize(14.00), bottom: getVerticalSize(14.00))),
                                                    style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400))),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                                height: getVerticalSize(45.00),
                                                width:
                                                    getHorizontalSize(260.00),
                                                child: TextFormField(
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            data["phoneNumber"],
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
                                                                width: 0.77)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(getHorizontalSize(3.85)),
                                                            borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                        //prefixIcon: Padding(padding: EdgeInsets.only(left: getHorizontalSize(44.00), right: getHorizontalSize(10.00)), child: Container(height: getSize(24.00), width: getSize(24.00), child: SvgPicture.asset(ImageConstant.imgRemixiconsLineSystemArrowdropdownline1, fit: BoxFit.contain))),
                                                        prefixIconConstraints: BoxConstraints(minWidth: getSize(24.00), minHeight: getSize(24.00)),
                                                        filled: true,
                                                        fillColor: ColorConstant.gray50,
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.only(top: getVerticalSize(14.00), right: getHorizontalSize(30.00), bottom: getVerticalSize(14.00),left: getHorizontalSize(25))),
                                                    style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400))),
                                          ],
                                        ))
                                  ])),
                        ])))));
  }

  onTapImgBack() {
    Navigator.of(context).pop();
  }
}
