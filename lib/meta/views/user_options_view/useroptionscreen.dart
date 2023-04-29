import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/routes/app.routes.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';
import 'package:moibleapi/app/theme/app_decoration.dart';
import 'package:moibleapi/app/theme/app_style.dart';
import 'package:moibleapi/core/services/cache.service.dart';

class UserLoginOptionsScreen extends StatefulWidget {
  const UserLoginOptionsScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginOptionsScreen> createState() => _UserLoginOptionsScreenState();
}

class _UserLoginOptionsScreenState extends State<UserLoginOptionsScreen> {
  bool isSelect = false;
  bool isDoctor = false;
  bool isButtondisable = false;

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
                  Expanded(child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(top: getVerticalSize(56.00)),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Container(
                                        width: getHorizontalSize(138.00),
                                        child: SvgPicture.asset(
                                            ImageConstant.imgApplogo5,
                                            fit: BoxFit.fill))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(46.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Text("Hello!",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium24
                                            .copyWith(
                                            fontSize: getFontSize(24)))),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(6.00),
                                        right: getHorizontalSize(29.00)),
                                    child: Text("Welcome.",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatobold36
                                            .copyWith(
                                            fontSize: getFontSize(36)))),
                                Container(
                                    width: getHorizontalSize(400.00),
                                    margin: EdgeInsets.only(
                                        left: getHorizontalSize(29.00),
                                        top: getVerticalSize(10.00),
                                        right: getHorizontalSize(28.00)),
                                    child: Text(
                                        "One-stop-solution for personalized healthcare from your comfort space.",
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.textstylelatomedium22
                                            .copyWith(
                                            fontSize: getFontSize(22),
                                            letterSpacing: 0.44,
                                            height: 1.64))),
                                Expanded(flex: 1, child:
                                Container(
                                    margin: EdgeInsets.only(
                                      top: getVerticalSize(30.00),
                                      //  bottom: getVerticalSize(20)
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.gray50,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            getHorizontalSize(30.00)),
                                        topRight: Radius.circular(
                                            getHorizontalSize(30.00)),
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  left: getHorizontalSize(20),
                                                  top: getVerticalSize(37.00),
                                                ),
                                                child: Text(
                                                    "Please select one below to login",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .textstylelatobold36
                                                        .copyWith(
                                                        fontSize:
                                                        getFontSize(18),
                                                        color: ColorConstant
                                                            .indigoA200))),
                                          ),
                                          Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: getHorizontalSize(
                                                          20.00),
                                                      top: getVerticalSize(
                                                          16.00),
                                                      right: getHorizontalSize(
                                                          19.00)),
                                                  child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: InkWell(
                                                              onTap: (() {
                                                                setState(() {
                                                                  isSelect =
                                                                  true;
                                                                  isDoctor =
                                                                  true;
                                                                });
                                                              }),
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                      color: ColorConstant
                                                                          .gray51,
                                                                      borderRadius:
                                                                      BorderRadius.circular(getHorizontalSize(
                                                                          8.00)),
                                                                      border: isDoctor
                                                                          ? Border.all(
                                                                          color: ColorConstant
                                                                              .indigoA200,
                                                                          width: getHorizontalSize(
                                                                              2.00))
                                                                          : Border.all(
                                                                          color: ColorConstant
                                                                              .whiteA700,
                                                                          width: getHorizontalSize(
                                                                              2.00)),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color:
                                                                            ColorConstant.indigo20070,
                                                                            spreadRadius: getHorizontalSize(2.00),
                                                                            blurRadius: getHorizontalSize(2.00),
                                                                            offset: const Offset(0, 1))
                                                                      ]),
                                                                  child: Row(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      children: [
                                                                        Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: getHorizontalSize(27.00),
                                                                                top: getVerticalSize(15.00),
                                                                                bottom: getVerticalSize(16.00)),
                                                                            child: Container(height: getSize(41.00), width: getSize(41.00), child: SvgPicture.asset(ImageConstant.imgUseravatar, fit: BoxFit.fill))),
                                                                        Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: getHorizontalSize(16.00),
                                                                                top: getVerticalSize(19.73),
                                                                                bottom: getVerticalSize(19.72)),
                                                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                              Padding(padding: EdgeInsets.only(right: getHorizontalSize(10.00)), child: Text("I am a Doctor", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.textstylelatomedium14.copyWith(fontSize: getFontSize(14)))),
                                                                              Padding(padding: EdgeInsets.only(top: getVerticalSize(1.97)), child: Text("I provide consultation", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.textstylelatomedium12.copyWith(fontSize: getFontSize(12))))
                                                                            ]))
                                                                      ])),
                                                            )),
                                                        Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: InkWell(
                                                              onTap: (() {
                                                                setState(() {
                                                                  isSelect =
                                                                  true;
                                                                  isDoctor =
                                                                  false;
                                                                });
                                                              }),
                                                              child: Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: getVerticalSize(
                                                                          13.00)),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                      color: ColorConstant
                                                                          .whiteA700,
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                        getHorizontalSize(8.00),
                                                                      ),
                                                                      border: !isDoctor && isSelect
                                                                          ? Border.all(
                                                                          color: Colors
                                                                              .green,
                                                                          width: getHorizontalSize(
                                                                              2.00))
                                                                          : Border.all(
                                                                          color: ColorConstant
                                                                              .whiteA700,
                                                                          width: getHorizontalSize(
                                                                              2.00)),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color:
                                                                            ColorConstant.indigo20070,
                                                                            spreadRadius: getHorizontalSize(2.00),
                                                                            blurRadius: getHorizontalSize(2.00),
                                                                            offset: const Offset(0, 1))
                                                                      ]),
                                                                  child: Row(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                      children: [
                                                                        Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: getHorizontalSize(27.00),
                                                                                top: getVerticalSize(16.00),
                                                                                bottom: getVerticalSize(16.00)),
                                                                            child: Container(height: getSize(40.00), width: getSize(40.00), child: SvgPicture.asset(ImageConstant.imgUseravatarp, fit: BoxFit.fill))),
                                                                        Padding(
                                                                            padding: EdgeInsets.only(
                                                                                left: getHorizontalSize(19.00),
                                                                                top: getVerticalSize(19.00),
                                                                                right: getHorizontalSize(79.00),
                                                                                bottom: getVerticalSize(20.00)),
                                                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                              Container(
                                                                                  margin: EdgeInsets.only(right: getHorizontalSize(10.00)),
                                                                                  child: RichText(
                                                                                      text: TextSpan(children: [
                                                                                        TextSpan(text: "I am not a Doctor", style: TextStyle(color: ColorConstant.bluegray900, fontSize: getFontSize(14), fontFamily: 'Lato', fontWeight: FontWeight.w500)),
                                                                                        //  TextSpan(text: "lbl_not_a_doctor", style: TextStyle(color: ColorConstant.bluegray900, fontSize: getFontSize(14), fontFamily: 'Lato', fontWeight: FontWeight.w500))
                                                                                      ]),
                                                                                      textAlign: TextAlign.left)),
                                                                              Padding(padding: EdgeInsets.only(top: getVerticalSize(2.00)), child: Text("book appointment with a doctor", overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.textstylelatomedium12.copyWith(fontSize: getFontSize(12))))
                                                                            ]))
                                                                      ])),
                                                            ))
                                                      ]))),
                                          const SizedBox(height: 40,),
                                          Container(
                                            height: 55,
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(left: 5, right: 5),
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: ElevatedButton(

                                              onPressed: () {
                                                onTapBtnNext();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: ColorConstant.green,
                                                  shape: const StadiumBorder(),
                                                  elevation: 7,
                                                  onPrimary: ColorConstant.redA400
                                                 ),
                                              child: const Text(
                                                "Next",
                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                              ),)),
                                          const SizedBox(height: 20,),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/qm.png',
                                                  ),
                                                  Text(
                                                      "Have a question for us?",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .textstylelatomedium162
                                                          .copyWith(
                                                          fontSize:
                                                          getFontSize(
                                                              16)))
                                                ]),
                                          ),
                                        ])),)
                              ]))),)

                ])));
  }

 void onTapBtnNext() {
   final CacheService _cacheService = CacheService();

   if (isSelect) {
      // redirection logic based on isDoctor
      if (isDoctor) {
        
        _cacheService.writeCache(key: "userType", value: 'doctor');

        Navigator.of(context).pushNamed(LoginRoute, arguments: "doctor");
        // ScaffoldMessenger.of(context)
        //   .showSnackBar(const SnackBar(content: Text("Doctor Selected")));
      } else {
        _cacheService.writeCache(key: "userType", value: 'patient');

        Navigator.of(context).pushNamed(LoginRoute, arguments: "patient");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select any option")));
    }
    return;
  }
}
