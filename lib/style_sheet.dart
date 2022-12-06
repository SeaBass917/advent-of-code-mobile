import 'package:flutter/material.dart';

abstract class Style {
  static const Color scaffoldColor = Color.fromRGBO(0x0f, 0x0f, 0x23, 1);
  static const Color navColor = Color.fromARGB(255, 30, 30, 69);
  static const Color textBoldColor = Color.fromARGB(255, 233, 233, 233);
  static const Color textColor = Color.fromARGB(255, 192, 192, 192);
  static const Color textDisableColor = Color.fromARGB(255, 123, 123, 123);
  static const Color linkColor = Color.fromRGBO(0, 0x99, 0, 1);
  static const Color linkHoverColor = Color.fromRGBO(0x99, 0xff, 0x99, 1);
  static const MaterialColor actionColor = MaterialColor(
    0xffff66,
    <int, Color>{
      50: Color.fromRGBO(0xff, 0xff, 0x66, 0.775),
      100: Color.fromRGBO(0xff, 0xff, 0x66, 0.800),
      200: Color.fromRGBO(0xff, 0xff, 0x66, 0.825),
      300: Color.fromRGBO(0xff, 0xff, 0x66, 0.850),
      400: Color.fromRGBO(0xff, 0xff, 0x66, 0.875),
      500: Color.fromRGBO(0xff, 0xff, 0x66, 0.900),
      600: Color.fromRGBO(0xff, 0xff, 0x66, 0.925),
      700: Color.fromRGBO(0xff, 0xff, 0x66, 0.950),
      800: Color.fromRGBO(0xff, 0xff, 0x66, 0.975),
      900: Color.fromRGBO(0xff, 0xff, 0x66, 1),
    },
  );
  static const List<List<Color>> cardThemeMainColors = [
    [Color.fromRGBO(0xa6, 0xce, 0xe3, 1), Color.fromRGBO(0x1f, 0x78, 0xb4, 1)],
    [Color.fromRGBO(0xb2, 0xdf, 0x8a, 1), Color.fromRGBO(0x33, 0xa0, 0x2c, 1)],
    [Color.fromRGBO(0xfb, 0x9a, 0x99, 1), Color.fromRGBO(0xe3, 0x1a, 0x1c, 1)],
    [Color.fromRGBO(0xfd, 0xbf, 0x6f, 1), Color.fromRGBO(0xff, 0x7f, 0x00, 1)],
    [Color.fromRGBO(0xca, 0xb2, 0xd6, 1), Color.fromRGBO(0x6a, 0x3d, 0x9a, 1)],
    [Color.fromRGBO(0xff, 0xff, 0x99, 1), Color.fromRGBO(0xb1, 0x59, 0x28, 1)],
  ];

  static const double padding0 = 16.0;
  static const double padding1 = 4.0;
}
