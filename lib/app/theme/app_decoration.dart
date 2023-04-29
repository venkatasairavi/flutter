import 'package:flutter/material.dart';
import 'package:moibleapi/app/shared/utils/color_constant.dart';
import 'package:moibleapi/app/shared/utils/math_utils.dart';

class AppDecoration {
  static BoxDecoration get groupstylewhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get groupstylewhite1 => BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            50.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9000d,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get groupstylewhite3 => BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            4.00,
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
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get groupstylewhite2 => BoxDecoration(
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
      );
  static BoxDecoration get groupstylewhite5 => BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
        ),
        border: Border.all(
          color: ColorConstant.indigo8001e,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get groupstylewhite4 => BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            6.00,
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
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get groupstylewhite6 => BoxDecoration(
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
      );
  static BoxDecoration get groupstylegray3 => BoxDecoration(
        color: ColorConstant.gray50,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            3.85,
          ),
        ),
        border: Border.all(
          color: ColorConstant.indigo80026,
          width: getHorizontalSize(
            0.77,
          ),
        ),
      );
  static BoxDecoration get groupstylegray2 => BoxDecoration(
        color: ColorConstant.gray50,
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
            color: ColorConstant.indigo900,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              -9,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get groupstylecyan400cornerradius => BoxDecoration(
        color: ColorConstant.cyan400,
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
      );
  static BoxDecoration get groupstylegray1 => BoxDecoration(
        color: ColorConstant.gray50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              30.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              30.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
        ),
      );
  static BoxDecoration get groupstyleblue50cornerradius => BoxDecoration(
        color: ColorConstant.blue50,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            25.00,
          ),
        ),
        border: Border.all(
          color: ColorConstant.gray303,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get textstylelatomedium121 => BoxDecoration(
        color: ColorConstant.gray300,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            17.00,
          ),
        ),
        border: Border.all(
          color: ColorConstant.indigo800,
          width: getHorizontalSize(
            2.00,
          ),
        ),
      );
  static BoxDecoration get groupstyleindigo800 => BoxDecoration(
        color: ColorConstant.indigo800,
      );
  static BoxDecoration get textstylelatomedium16 => BoxDecoration(
        color: ColorConstant.indigo800,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            35.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.indigo80026,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get groupstylegray51cornerradius => BoxDecoration(
        color: ColorConstant.gray51,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        ),
        border: Border.all(
          color: ColorConstant.indigoA200,
          width: getHorizontalSize(
            2.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.indigo20070,
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
      );
  static BoxDecoration get textstylelatomedium169 => BoxDecoration(
        color: ColorConstant.bluegray900,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            50.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.indigo80030,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get groupstylegray50cornerradius => BoxDecoration(
        color: ColorConstant.gray50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              30.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              30.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.indigo900,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              -9,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get textstylelatomedium148 => BoxDecoration(
        color: ColorConstant.gray30071,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
        ),
      );
  static BoxDecoration get textstylelatomedium165 => BoxDecoration(
        color: ColorConstant.cyan400,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            35.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.indigo80052,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get textstylelatomedium147 => BoxDecoration(
        color: ColorConstant.gray30071,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              15.00,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              30.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              30.00,
            ),
          ),
        ),
      );
  static BoxDecoration get groupstylewhiteA700cornerradius => BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.indigo20070,
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
      );
  static BoxDecoration get textstylelatomedium149 => BoxDecoration(
        color: ColorConstant.indigo800,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            35.00,
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
              4,
            ),
          ),
        ],
      );
}
