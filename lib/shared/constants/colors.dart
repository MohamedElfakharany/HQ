import 'package:flutter/material.dart';

const darkColor = Color(0xFF1F1F1F);

const greyDarkColor = Color(0XFF6A6E83);

const greyLightColor = Color(0XFFA8B1CE);

const greyExtraLightColor = Color(0xFFF2F5FF);

const greenColor = Color(0xFF5FBD5D);

const redColor = Color(0xFFBD3430);

const pinkColor = Color(0xFFE397CC);

const blueColor = Color(0xFF2685C7);

const blueLightColor = Color(0xFF4099D3);

const ofWhiteColor = Color(0xFFF8F9FD);

const whiteColor = Color(0xFFFFFFFF);

const blueGreenGradient = LinearGradient(
  colors: [Color(0xFF0099CC),Color(0xFF99FF66)],
  tileMode: TileMode.clamp,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0,0.0],
);

const transparentGradient = LinearGradient(
  colors: [Color(0xFF000000),Color(0xFF000000)],
  tileMode: TileMode.clamp,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0,1.0],
);