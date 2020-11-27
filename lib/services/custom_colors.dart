import 'package:flutter/material.dart';

class CustomColors {
  Brightness brightness;
  Color text1, primary;

  CustomColors(Brightness brightness) {
    this.brightness = brightness;

    if(brightness == Brightness.dark) {
      this.text1 = Color(0xff252223);
      this.primary = Colors.deepOrange;

    } else {
      this.text1 = Colors.white;
      this.primary = Color(0xFFffa726);
    }
  }

}