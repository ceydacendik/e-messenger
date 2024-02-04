import 'package:flutter/material.dart';

enum Screen { mobile, tablet, desktop }
//emülatörün booyutuna göre ne mobil tablet desktop ayarı
detectScreen(Size size) {
  if (size.width < 600) {
    return Screen.mobile;
  } else if (size.width < 840) {
    return Screen.tablet;
  } else {
    return Screen.desktop;
  }
}
