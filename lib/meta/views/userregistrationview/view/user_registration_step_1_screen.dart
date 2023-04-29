import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_decoration.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/core/services/cache.service.dart';
import 'package:moibleapi/meta/views/userregistrationview/view/user_registration_step_2_screen.dart';

class UserRegistrationStep1Screen extends StatefulWidget {
  const UserRegistrationStep1Screen({Key? key}) : super(key: key);

  @override
  State<UserRegistrationStep1Screen> createState() =>
      _UserRegistrationStep1ScreenState();
}

class _UserRegistrationStep1ScreenState
    extends State<UserRegistrationStep1Screen> {
  TextEditingController enterFirstnamController = TextEditingController();

  TextEditingController enterLastnameController = TextEditingController();

  TextEditingController mMDDYYYYController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController dateCtl = TextEditingController();

  late CacheService _cacheService;

  final _form = GlobalKey<FormState>();
  String dropdownValue = 'Male';
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }

  @override
  void initState() {
    _cacheService = CacheService();
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: getHorizontalSize(29.00),
                              top: getVerticalSize(56.00),
                              right: getHorizontalSize(29.00)),
                          child: Container(
                              height: getVerticalSize(27.00),
                              width: getHorizontalSize(138.00),
                              child: SvgPicture.asset(ImageConstant.imgApplogo1,
                                  fit: BoxFit.fill)))),
                  Expanded(
                      child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: getVerticalSize(21.00)),
                          decoration: BoxDecoration(
                            color: ColorConstant.gray50,
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(getHorizontalSize(30.00)),
                              topRight:
                                  Radius.circular(getHorizontalSize(30.00)),
                            ),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: ColorConstant.indigo900,
                            //       spreadRadius:
                            //           getHorizontalSize(2.00),
                            //       blurRadius:
                            //           getHorizontalSize(2.00),
                            //       offset: Offset(-9, 0))
                            // ]
                          ),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(25.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Text("Register Now",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatobold22
                                            .copyWith(
                                                fontSize: getFontSize(22)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: getVerticalSize(13.00)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(29.00)),
                                              child: Text(
                                                  "Already have an account?",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .textstylelatomedium14
                                                      .copyWith(
                                                          fontSize: getFontSize(
                                                              14)))),
                                          GestureDetector(
                                              onTap: () {
                                                onTapTxtLoginnow();
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                          10.00),
                                                      right: getHorizontalSize(
                                                          112.00)),
                                                  child: Text("Login Now",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .textstylelatomedium141
                                                          .copyWith(
                                                              fontSize:
                                                                  getFontSize(
                                                                      14),
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline))))
                                        ])),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: getVerticalSize(29.00)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(29.00)),
                                              child: Text("User Information",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .textstylelatobold18
                                                      .copyWith(
                                                          fontSize: getFontSize(
                                                              18)))),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: getVerticalSize(5.00),
                                                  right:
                                                      getHorizontalSize(30.00)),
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "Step ",
                                                        style: TextStyle(
                                                            color: ColorConstant
                                                                .indigo900,
                                                            fontSize:
                                                                getFontSize(14),
                                                            fontFamily: 'Lato',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    TextSpan(
                                                        text: "01/",
                                                        style: TextStyle(
                                                            color: ColorConstant
                                                                .cyan400,
                                                            fontSize:
                                                                getFontSize(14),
                                                            fontFamily: 'Lato',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    TextSpan(
                                                        text: "02",
                                                        style: TextStyle(
                                                            color: ColorConstant
                                                                .bluegray900,
                                                            fontSize:
                                                                getFontSize(14),
                                                            fontFamily: 'Lato',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))
                                                  ]),
                                                  textAlign: TextAlign.left))
                                        ])),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(16.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Text("First Name *",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium142
                                            .copyWith(
                                                fontSize: getFontSize(14)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(6.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Container(
                                        height: getVerticalSize(45.00),
                                        width: getHorizontalSize(316.00),
                                        child: TextFormField(
                                            controller: enterFirstnamController,
                                            decoration: InputDecoration(
                                                hintText: "Enter First Name",
                                                hintStyle: AppStyle
                                                    .textstylelatoregular14
                                                    .copyWith(
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
                                                contentPadding: EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                                            style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(19.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Text("Last Name *",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium142
                                            .copyWith(
                                                fontSize: getFontSize(14)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(6.00),
                                        right: getHorizontalSize(28.00)),
                                    child: Container(
                                        height: getVerticalSize(45.00),
                                        width: getHorizontalSize(318.00),
                                        child: TextFormField(
                                            controller: enterLastnameController,
                                            decoration: InputDecoration(
                                                hintText: "Enter Last Name",
                                                hintStyle: AppStyle
                                                    .textstylelatoregular14
                                                    .copyWith(
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
                                                contentPadding: EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                                            style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.03),
                                        top: getVerticalSize(18.57),
                                        right: getHorizontalSize(29.03)),
                                    child: Text("Date of Birth *",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium142
                                            .copyWith(
                                                fontSize: getFontSize(14)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(3.86),
                                        right: getHorizontalSize(28.00)),
                                    child: Container(
                                        height: getVerticalSize(45.00),
                                        width: getHorizontalSize(318.00),
                                        child: TextFormField(
                                            controller: dateCtl,
                                            //onChanged: valiDate(),
                                            onTap: () async {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2025),
                                              ).then((selectedDate) {
                                                setState(() {
                                                  if (selectedDate != null) {
                                                    dateCtl.text = DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(selectedDate);
                                                  }
                                                });
                                                valiDate();
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter date.';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                hintText: "YYYY / MM / DD",
                                                hintStyle: AppStyle.textstylelatoregular14.copyWith(
                                                    fontSize: getFontSize(14.0),
                                                    color: ColorConstant
                                                        .bluegray600),
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
                                                        BorderRadius.circular(getHorizontalSize(3.85)),
                                                    borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                suffixIcon: Padding(padding: EdgeInsets.only(left: getHorizontalSize(10.00), right: getHorizontalSize(18.00)), child: Container(height: getSize(18.00), width: getSize(18.00), child: SvgPicture.asset(ImageConstant.imgFrame853, fit: BoxFit.contain))),
                                                suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                                                filled: true,
                                                fillColor: ColorConstant.gray50,
                                                isDense: true,
                                                contentPadding: EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.50), bottom: getVerticalSize(15.50))),
                                            style: TextStyle(color: ColorConstant.bluegray600, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w400)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(20.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Text("Select Gender *",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium142
                                            .copyWith(
                                                fontSize: getFontSize(14)))),
                                Container(
                                    height: getVerticalSize(45.00),
                                    width: getHorizontalSize(318.00),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.gray50,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(3.85)),
                                        border: Border.all(
                                            color: ColorConstant.indigo80026,
                                            width: getHorizontalSize(0.77))),
                                    margin: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(15.00),
                                        right: getHorizontalSize(28.00)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: DropdownButton<String>(
                                        underline: const SizedBox(),
                                        autofocus: true,
                                        isExpanded: true,
                                        // hint: Text('$dropdownValue',style: TextStyle(fontSize: 10),),
                                        // Step 3.
                                        value: dropdownValue,
                                        // Step 4.
                                        items: <String>[
                                          'Male',
                                          'Female',
                                          'Others'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant
                                                      .bluegray600),
                                            ),
                                          );
                                        }).toList(),
                                        // Step 5.
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                      ),
                                    )),
                                //  DropdownButton<
                                //     SelectionPopupModel>(
                                //   autofocus: true,
                                //   isExpanded: true,
                                //   underline: const SizedBox(),

                                //   hint: Text("lbl_select",
                                //       textAlign:
                                //           TextAlign.center,
                                //       style: TextStyle(
                                //           color: ColorConstant
                                //               .bluegray600,
                                //           fontSize:
                                //               getFontSize(14),
                                //           fontFamily: 'Lato',
                                //           fontWeight:
                                //               FontWeight.w400,
                                //           height: 1.50)),
                                //   value: dropdownItemList
                                //       .firstWhere((element) =>
                                //           element.isSelected),

                                //   items: dropdownItemList.map(
                                //       (SelectionPopupModel
                                //           itemCount) {
                                //     //print(itemCount);
                                //     return DropdownMenuItem<
                                //             SelectionPopupModel>(
                                //         value: itemCount,
                                //         child: Text(
                                //             itemCount.title,
                                //             textAlign: TextAlign
                                //                 .left));
                                //   }).toList(),
                                //   onChanged: (value) {
                                //     onSelected(value);
                                //   },
                                //   // selectedItemBuilder: (BuildContext context) {
                                //   //   return dropdownItemList.map(
                                //   //       (SelectionPopupModel
                                //   //         itemCount) {
                                //   //     return Text(
                                //   //         itemCount.title,
                                //   //         textAlign:
                                //   //             TextAlign.left,
                                //   //         style: TextStyle(
                                //   //             color: ColorConstant
                                //   //                 .bluegray600,
                                //   //             fontSize:
                                //   //                 getFontSize(
                                //   //                     14),
                                //   //             fontFamily:
                                //   //                 'Lato',
                                //   //             fontWeight:
                                //   //                 FontWeight
                                //   //                     .w400,
                                //   //             height: 1.50));
                                //   //   }).toList();
                                //   // }
                                // )
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(20.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Text("Email *",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium142
                                            .copyWith(
                                                fontSize: getFontSize(14)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(6.00),
                                        right: getHorizontalSize(28.00)),
                                    child: Form(
                                      key: _form,
                                      child: Container(
                                          height: getVerticalSize(45.00),
                                          width: getHorizontalSize(318.00),
                                          child: TextFormField(
                                              validator: (value) {
                                                print(value);
                                                // Check if this field is empty
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'This field is required';
                                                }

                                                // using regular expression
                                                if (!RegExp(r'\S+@\S+\.\S+')
                                                    .hasMatch(value)) {
                                                  return "Please enter a valid email address";
                                                }

                                                // the email is valid
                                                return null;
                                              },
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                  hintText: "Enter Email",
                                                  hintStyle: AppStyle
                                                      .textstylelatoregular14
                                                      .copyWith(
                                                          fontSize:
                                                              getFontSize(14.0),
                                                          color: ColorConstant
                                                              .bluegray600),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          getHorizontalSize(
                                                              3.85)),
                                                      borderSide: BorderSide(
                                                          color: ColorConstant
                                                              .indigo80026,
                                                          width: 0.77)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          getHorizontalSize(3.85)),
                                                      borderSide: BorderSide(color: ColorConstant.indigo80026, width: 0.77)),
                                                  suffixIcon: Padding(padding: EdgeInsets.only(left: getHorizontalSize(10.00), right: getHorizontalSize(18.00)), child: Container(height: getSize(18.00), width: getSize(18.00), child: SvgPicture.asset(ImageConstant.imgFrame8531, fit: BoxFit.contain))),
                                                  suffixIconConstraints: BoxConstraints(minWidth: getSize(18.00), minHeight: getSize(18.00)),
                                                  filled: true,
                                                  fillColor: ColorConstant.gray50,
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.only(left: getHorizontalSize(10.00), top: getVerticalSize(15.21), bottom: getVerticalSize(15.21))),
                                              style: TextStyle(color: ColorConstant.bluegray900, fontSize: getFontSize(14.0), fontFamily: 'Lato', fontWeight: FontWeight.w500))),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: getVerticalSize(30.00),
                                        bottom: getVerticalSize(50.00)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      getHorizontalSize(36.00),
                                                  top: getVerticalSize(16.00),
                                                  bottom:
                                                      getVerticalSize(15.00)),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    onTapTxtLoginnow();
                                                  },
                                                  child: Text("Go Back",
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .textstylelatomedium161
                                                          .copyWith(
                                                              fontSize:
                                                                  getFontSize(
                                                                      16))))),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      getHorizontalSize(31.00)),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    onTapBtnNext();
                                                  },
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: getVerticalSize(
                                                          50.00),
                                                      width: getHorizontalSize(
                                                          145.00),
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
                                        ])),
                              ])))
                ])));
  }

  onTapTxtLoginnow() {
    Navigator.of(context).pushNamed(LoginRoute);
  }

  onTapBtnNext() async {
    //print(dropdownValue);
    if (enterFirstnamController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Full name")));
      return;
    }
    if (enterLastnameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter Last name.")));
      return;
    }
    if (dateCtl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Pick date")));
      return;
    }
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter email")));
      return;
    }

    // var email = emailController.text;
/*    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if(!emailValid){
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter valid email")));
      return ;
    }*/

    if (valiDate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Age must be 18+")));
      return;
    }

    String? userType = await _cacheService.readCache(key: "userType");
    print("aaaaaaaaaausertypeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    print(userType);

    if (userType == 'doctor') {
      Navigator.of(context).pushNamed(UserRestrationscreentwo, arguments: [
        enterFirstnamController.text.trim(),
        enterLastnameController.text.trim(),
        dateCtl.text.trim(),
        emailController.text.trim(),
        dropdownValue
      ]);
    } else if (userType == 'patient') {
      Navigator.of(context)
          .pushNamed(UserPatientRestrationscreentwo, arguments: [
        enterFirstnamController.text.trim(),
        enterLastnameController.text.trim(),
        dateCtl.text.trim(),
        emailController.text.trim(),
        dropdownValue
      ]);
    }
  }

  valiDate() {
    int Dt = int.parse(dateCtl.text.split("-")[0]);
    int limit = DateTime.now().year - 18;
    if (Dt - limit >= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Age must be 18+")));
      return true;
    }
    return false;
  }
}
