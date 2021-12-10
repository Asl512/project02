import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loadingPage.dart';
import 'authorization.dart';
import 'registration.dart';
import 'performance/performanceOne.dart';
import 'performance/performanceTwo.dart';
import 'performance/performanceThree.dart';
import 'performance/performanceFour.dart';
import 'selectCity.dart';
import 'city.dart';
import 'test.dart';

void main() async
{

  runApp(MaterialApp(
    initialRoute: '/loading',

    routes:
    {
      '/loading': (context) => const Loading(),
      '/test': (context) => const Test(),

      '/perfomanceOne': (context) => const PerfomanceOne(),
      '/perfomanceTwo': (context) => const PerfomanceTwo(),
      '/perfomanceThree': (context) => const PerfomanceThree(),
      '/perfomanceFour': (context) => const PerfomanceFour(),

      '/authorization': (context) => const Authorization(),
      '/registration': (context) => const Registration(),

      '/selectCity': (context) => const SelectCity(),
      '/city': (context) => const City(),
    },
  ));
}