import 'package:flutter/material.dart';
import 'colors.dart';


TextStyle Montserrat({
  FontWeight style = Medium,
  Color color = Blue,
  double? size,
  double? heigth
})
{
  return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: 'Montserrat',
      fontWeight: style,
      height: heigth,
      decoration:TextDecoration.none
  );
}

const FontWeight Black = FontWeight.w900;
const FontWeight ExtraBold = FontWeight.w800;
const FontWeight Bold = FontWeight.w700;
const FontWeight SemiBold = FontWeight.w600;
const FontWeight Medium = FontWeight.w500;
const FontWeight Regular = FontWeight.w400;
const FontWeight Light = FontWeight.w300;
const FontWeight ExtraLight = FontWeight.w200;
const FontWeight Thin = FontWeight.w100;