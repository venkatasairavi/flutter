
import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray51 = fromHex('#fafaff');

  static Color gray30071 = fromHex('#71d9d9e3');

  static Color teal400Null = fromHex('#2aafb2');

  static Color indigoA200 = fromHex('#7878f2');

  static Color gray50 = fromHex('#fafafa');

  static Color black9001f = fromHex('#1f000000');

  static Color gray30099 = fromHex('#99d9d9e3');

  static Color black900 = fromHex('#000000');

  static Color indigo80026 = fromHex('#2633338f');

  static Color black90040 = fromHex('#40000000');

  static Color redA400 = fromHex('#ff2b38');

  static Color tealA700 = fromHex('#00ba96');

  static Color gray303 = fromHex('#e0e0ed');

  static Color indigo20070 = fromHex('#70a8baf0');

  static Color gray301 = fromHex('#e0e3e3');

  static Color gray302 = fromHex('#e3e3e3');

  static Color orangeA400 = fromHex('#ff9400');

  static Color redA200 = fromHex('#ff475e');

  static Color indigo8001e = fromHex('#1e33338f');

  static Color gray200 = fromHex('#edebeb');

  static Color gray300 = fromHex('#e6e6e6');

  static Color blue50 = fromHex('#ebf2fa');

  static Color black9000d = fromHex('#0d000000');

  static Color gray100 = fromHex('#f5f7fa');

  static Color bluegray900 = fromHex('#262e4a');

  static Color bluegray600 = fromHex('#5e698a');

  static Color indigo200 = fromHex('#a8baf0');

  static Color bluegray400 = fromHex('#888888');

  static Color bluegray300 = fromHex('#8c99b0');

  static Color bluegray6002b = fromHex('#2b5e698a');

  static Color indigo900 = fromHex('#292b69');

  static Color indigo800 = fromHex('#33338f');

  static Color whiteA700 = fromHex('#ffffff');

  static Color bluegray600Af = fromHex('#af5e698a');

  static Color cyan400 = fromHex('#1cc7c7');

  static Color indigo80052 = fromHex('#5233338f');

  static Color indigo80030 = fromHex('#3033338f');

  static Color bluegray901 = fromHex('#031c47');

  static Color lightGray = fromHex('#8D98B1');

  static Color green = fromHex('#1BC8C8');

  static Color lightGreen = fromHex('#00B998');

  static Color grayLight = fromHex('#5F6989');

  static Color teal = fromHex('#FF03DAC5');

  static Color orange = fromHex('#FF9500');

  static Color blueLighter = fromHex('#EAF1FB');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
