// ignore_for_file: prefer_const_declarations

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///COLORS
const Color Blue = Color(0xFF548B9C);
const Color White = Colors.white;
const Color Red = Colors.red;

///ICON
final Widget iconPassword = SvgPicture.asset('image/icon/password.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
const String iconShow = 'image/icon/show.png';
const String iconHide = 'image/icon/hide.png';

///STYLE TEXT
const FontWeight Bold = FontWeight.w900;
const FontWeight SemiBold = FontWeight.w800;
const FontWeight Medium = FontWeight.w500;
const FontWeight Regular = FontWeight.w400;
const FontWeight Light = FontWeight.w200;