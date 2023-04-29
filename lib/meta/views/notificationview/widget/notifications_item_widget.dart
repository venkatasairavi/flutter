import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/image_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';



// ignore: must_be_immutable
class NotificationsItemWidget extends StatelessWidget {
  NotificationsItemWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getVerticalSize(
          3.50,
        ),
        bottom: getVerticalSize(
          3.50,
        ),
      ),
      decoration: BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9001f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: getSize(
              50.00,
            ),
            width: getSize(
              50.00,
            ),
            margin: EdgeInsets.only(
              left: getHorizontalSize(
                16.00,
              ),
              top: getVerticalSize(
                6.00,
              ),
              bottom: getVerticalSize(
                6.00,
              ),
            ),
            decoration: BoxDecoration(
              color: ColorConstant.blue50,
              borderRadius: BorderRadius.circular(
                getHorizontalSize(
                  25.00,
                ),
              ),
              border: Border.all(
                color: ColorConstant.gray300,
                width: getHorizontalSize(
                  1.00,
                ),
              ),
            ),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.all(0),
              color: ColorConstant.blue50,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: ColorConstant.gray300,
                  width: getHorizontalSize(
                    1.00,
                  ),
                ),
                borderRadius: BorderRadius.circular(
                  getHorizontalSize(
                    25.00,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(
                          14.00,
                        ),
                        top: getVerticalSize(
                          14.00,
                        ),
                        right: getHorizontalSize(
                          14.00,
                        ),
                        bottom: getVerticalSize(
                          14.72,
                        ),
                      ),
                      child: Container(
                        height: getVerticalSize(
                          21.28,
                        ),
                        width: getHorizontalSize(
                          22.00,
                        ),
                        child: SvgPicture.asset(
                          ImageConstant.imgCalendaricon,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: getHorizontalSize(
              188.00,
            ),
            margin: EdgeInsets.only(
              left: getHorizontalSize(
                16.00,
              ),
              top: getVerticalSize(
                9.00,
              ),
              bottom: getVerticalSize(
                14.00,
              ),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Albert G. ',
                    style: TextStyle(
                      color: ColorConstant.bluegray900,
                      fontSize: getFontSize(
                        14,
                      ),
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                  TextSpan(
                    text: 'has book an appointment on',
                    style: TextStyle(
                      color: ColorConstant.bluegray600,
                      fontSize: getFontSize(
                        14,
                      ),
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                  TextSpan(
                    text: ' Sep 9,2020',
                    style: TextStyle(
                      color: ColorConstant.bluegray900,
                      fontSize: getFontSize(
                        14,
                      ),
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getHorizontalSize(
                4.00,
              ),
              top: getVerticalSize(
                11.00,
              ),
              right: getHorizontalSize(
                16.00,
              ),
              bottom: getVerticalSize(
                37.00,
              ),
            ),
            child: Text(
              "4:01 PM",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: ColorConstant.bluegray600,
                fontSize: getFontSize(
                  12,
                ),
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}