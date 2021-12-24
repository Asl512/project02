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
const Color LigthGrey = Color(0xFFF2F2F2);
const Color Black = Colors.black;

///ICON
final Widget iconPassword = SvgPicture.asset('image/icon/password.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconEmail = SvgPicture.asset('image/icon/email.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconShow = SvgPicture.asset('image/icon/show.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconHide = SvgPicture.asset('image/icon/hide.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconPerson = SvgPicture.asset('image/icon/person.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);

final Widget iconTickets = SvgPicture.asset('image/icon/tickets.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconSettings = SvgPicture.asset('image/icon/settings.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconAdd = SvgPicture.asset('image/icon/add.svg', height: 20, width: 20, allowDrawingOutsideViewBox: true, color: White);
final Widget iconExcursion = SvgPicture.asset('image/icon/myExcursion.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconExit = SvgPicture.asset('image/icon/exit.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconFavoriteLi = SvgPicture.asset('image/icon/favorite.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true,color: White,);
final Widget iconPersonWhite = SvgPicture.asset('image/icon/person.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconPasswordWhite = SvgPicture.asset('image/icon/password.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconEmailWhite = SvgPicture.asset('image/icon/email.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconPhone = SvgPicture.asset('image/icon/phone.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);

final Widget iconReverse = SvgPicture.asset('image/icon/reverse.svg', height: 40, width: 40, allowDrawingOutsideViewBox: true);
final Widget iconHandbook = SvgPicture.asset('image/icon/handbook.svg', height: 30, width: 30, allowDrawingOutsideViewBox: true,color: White,);
final Widget iconFavoriteRed = SvgPicture.asset('image/icon/favorite.svg', height: 30, width: 30, allowDrawingOutsideViewBox: true,color: Red,);
final Widget iconFavoriteWhite = SvgPicture.asset('image/icon/favorite.svg', height: 30, width: 30, allowDrawingOutsideViewBox: true,color: White,);
final Widget iconArrow = SvgPicture.asset('image/icon/arrow.svg', allowDrawingOutsideViewBox: true, color: White);
final Widget iconArrowBottom = SvgPicture.asset('image/icon/arrowBottom.svg', height: 15, width: 15, allowDrawingOutsideViewBox: true);
final Widget iconArrowBottomWhite = SvgPicture.asset('image/icon/arrowBottom.svg', height: 15, width: 15, allowDrawingOutsideViewBox: true,color: White);
final Widget iconMagnifier = SvgPicture.asset('image/icon/magnifier.svg', height: 30, width: 30,allowDrawingOutsideViewBox: true, color: White);
final Widget iconDate = SvgPicture.asset('image/icon/date.svg', height: 25, width: 25,allowDrawingOutsideViewBox: true);
final Widget iconDateWhite = SvgPicture.asset('image/icon/date.svg', height: 20, width: 20,allowDrawingOutsideViewBox: true,color: White);
final Widget iconTime = SvgPicture.asset('image/icon/time.svg', height: 20, width: 20,allowDrawingOutsideViewBox: true,color: White);
final Widget iconLocation = SvgPicture.asset('image/icon/location.svg', height: 15, width: 15,allowDrawingOutsideViewBox: true);
final Widget iconRuble = SvgPicture.asset('image/icon/ruble.svg', height: 15, width: 15,allowDrawingOutsideViewBox: true);

final Widget iconVK = SvgPicture.asset('image/icon/vk.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF5181B8));
final Widget iconGoogle = SvgPicture.asset('image/icon/google.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFFEB4335));
final Widget iconOkRu = SvgPicture.asset('image/icon/okru.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFFEB722E));
final Widget iconFacebook = SvgPicture.asset('image/icon/facebook.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF3C5A9A));
final Widget iconTwitter = SvgPicture.asset('image/icon/twitter.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF1DA1F2));

///IMAGES
const String imgPerformanceOne = "image/performance/One.png";
const String imgPerformanceTwo = "image/performance/Two.png";
const String imgPerformanceThree = "image/performance/Three.png";
const String imgPerformanceFour = "image/performance/Four.png";
const String imgBackCity = 'image/backCity.png';
const String imgDefoultExcursion = 'image/backCity.png';

///STYLE TEXT
const FontWeight Bold = FontWeight.w900;
const FontWeight SemiBold = FontWeight.w800;
const FontWeight Medium = FontWeight.w500;
const FontWeight Regular = FontWeight.w400;
const FontWeight Light = FontWeight.w200;