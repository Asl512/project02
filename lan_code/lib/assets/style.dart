import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'finally.dart';

TextStyle Montserrat({FontWeight? style, Color? color, double? size})
{
  color ??= Blue;
  style ??= Medium;
  size ??= 16;

  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: 'Montserrat',
    fontWeight: style,
  );
}
