
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';

class ChatMessagingScreen extends StatefulWidget {
  const ChatMessagingScreen({Key? key}) : super(key: key);

  @override
  State<ChatMessagingScreen> createState() => _ChatMessagingScreenState();
}

class _ChatMessagingScreenState extends State<ChatMessagingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.indigo800,
      body: Container(
          height: MediaQuery.of(context).size.height * .95,
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
              Container(
                width: size.width,
                margin: EdgeInsets.only(
                  top: getVerticalSize(
                    49.00,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: getHorizontalSize(
                      20.00,
                    ),
                    right: getHorizontalSize(
                      149.00,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: getSize(
                            46.00,
                          ),
                          width: getSize(
                            46.00,
                          ),
                          child: SvgPicture.asset(
                            ImageConstant.imgBack1,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getVerticalSize(
                            14.00,
                          ),
                          // bottom: getVerticalSize(
                          //   8.00,
                          // ),
                        ),
                        child: Text(
                          "Messages",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(
                              18,
                            ),
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.33,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: getVerticalSize(
                    73.00,
                  ),
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.whiteA700,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      getHorizontalSize(
                        0.00,
                      ),
                    ),
                    topRight: Radius.circular(
                      getHorizontalSize(
                        0.00,
                      ),
                    ),
                    bottomLeft: Radius.circular(
                      getHorizontalSize(
                        30.00,
                      ),
                    ),
                    bottomRight: Radius.circular(
                      getHorizontalSize(
                        30.00,
                      ),
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.black90040,
                      spreadRadius: getHorizontalSize(
                        2.00,
                      ),
                      blurRadius: getHorizontalSize(
                        2.00,
                      ),
                      offset: Offset(
                        0,
                        -2,
                      ),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          12.00,
                        ),
                        bottom: getVerticalSize(
                          9.00,
                        ),
                      ),
                      child: Container(
                        height: getVerticalSize(
                          45.00,
                        ),
                        width: getHorizontalSize(
                          288.00,
                        ),
                        child: TextFormField(
                          focusNode: FocusNode(),
                          decoration: InputDecoration(
                            hintText: 'Type something here...',
                            hintStyle: TextStyle(
                              fontSize: getFontSize(
                                14.0,
                              ),
                              color: ColorConstant.bluegray600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  5.00,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: ColorConstant.indigo80026,
                                width: 0.77,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  5.00,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: ColorConstant.indigo80026,
                                width: 0.77,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  5.00,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: ColorConstant.indigo80026,
                                width: 0.77,
                              ),
                            ),
                            // suffixIcon: Container(
                            //   padding: EdgeInsets.only(
                            //     left: getHorizontalSize(
                            //       10.00,
                            //     ),
                            //     right: getHorizontalSize(
                            //       18.00,
                            //     ),
                            //   ),
                            //   child: Container(
                            //     height: getSize(
                            //       18.00,
                            //     ),
                            //     width: getSize(
                            //       18.00,
                            //     ),
                            //     child: SvgPicture.asset(
                            //       ImageConstant.imgGroup99413,
                            //       fit: BoxFit.fill,
                            //     ),
                            //   ),
                            // ),
                            // suffixIconConstraints: BoxConstraints(
                            //   minWidth: getSize(
                            //     18.00,
                            //   ),
                            //   minHeight: getSize(
                            //     18.00,
                            //   ),
                            // ),
                            filled: true,
                            fillColor: ColorConstant.gray50,
                            isDense: true,
                            contentPadding: EdgeInsets.only(
                              left: getHorizontalSize(
                                18.00,
                              ),
                              top: getVerticalSize(
                                14.71,
                              ),
                              bottom: getVerticalSize(
                                15.71,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ColorConstant.bluegray600,
                            fontSize: getFontSize(
                              14.0,
                            ),
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          12.00,
                        ),
                        bottom: getVerticalSize(
                          9.00,
                        ),
                      ),
                      child: Container(
                        height: getSize(
                          50.00,
                        ),
                        width: getSize(
                          50.00,
                        ),
                        child: SvgPicture.asset(
                          ImageConstant.imgButton,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Align(alignment: ,)
            ],
          )),
    );
  }
}
