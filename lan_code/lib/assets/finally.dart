// ignore_for_file: prefer_const_declarations

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///COLORS
const Color Blue = Color(0xFF548B9C);
const Color White = Colors.white;
const Color Red = Colors.red;
const Color LigthGreen = Color(0xFFF1FFFF);
const Color GreenReady = Color(0xFFAAD9A5);
const Color Green = Color(0xFF48C28B);
const Color Grey = Color(0xFF9D9F9F);

///ICON
final Widget iconPassword = SvgPicture.asset('image/icon/password.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, cacheColorFilter: true);
final Widget iconEmail = SvgPicture.asset('image/icon/email.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconShow = SvgPicture.asset('image/icon/show.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconHide = SvgPicture.asset('image/icon/hide.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);

final Widget iconVK = SvgPicture.asset('image/icon/vk.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF5181B8));
final Widget iconGoogle = SvgPicture.asset('image/icon/google.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFFEB4335));
final Widget iconOkRu = SvgPicture.asset('image/icon/okru.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFFEB722E));
final Widget iconFacebook = SvgPicture.asset('image/icon/facebook.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF3C5A9A));
final Widget iconTwitter = SvgPicture.asset('image/icon/twitter.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF1DA1F2));



///STYLE TEXT
const FontWeight Bold = FontWeight.w900;
const FontWeight SemiBold = FontWeight.w800;
const FontWeight Medium = FontWeight.w500;
const FontWeight Regular = FontWeight.w400;
const FontWeight Light = FontWeight.w200;