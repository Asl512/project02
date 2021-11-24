import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authorization.dart';

void main()
{
  runApp(MaterialApp(
    initialRoute: '/authorization',

    routes:
    {
      '/authorization': (context) => const Authorization(),
    },
  ));
}