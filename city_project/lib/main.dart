import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loadingPage.dart';
import 'authorization/authorization.dart';
import 'authorization/registration.dart';
import 'performance/performanceOne.dart';
import 'performance/performanceTwo.dart';
import 'performance/performanceThree.dart';
import 'performance/performanceFour.dart';
import 'selectCity.dart';
import 'recovery/recoveryOne.dart';
import 'recovery/recoveryTwo.dart';
import 'recovery/recoveryThree.dart';
import 'conditions.dart';
import 'personal/records.dart';
import 'personal/personalArea.dart';
import 'excursion/excursion.dart';
import 'settings.dart';
import 'personal/favorite.dart';
import 'excursionsPeaple.dart';
import 'personal/excursionsMy.dart';
import 'personal/addExcursion.dart';

import 'city/city.dart';
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

      '/recoveryOne': (context) => const RecoveryOne(),
      '/recoveryTwo': (context) => const RecoveryTwo(),
      '/recoveryThree': (context) => const RecoveryThree(),

      '/selectCity': (context) => const SelectCity(),
      '/city': (context) => const City(),
      '/excursion': (context) => const Excursion(),

      '/records': (context) => const Records(),
      '/personalArea': (context) => const PersonalArea(),
      '/settings': (context) => const Settings(),
      '/favorite': (context) => const Favorite(),
      '/excursionPeaple': (context) => const ExcursionPeaple(),
      '/excursionMy': (context) => const ExcursionMy(),
      '/addExcursion': (context) => const AddExcursion(),

      '/conditions': (context) => const Conditions(),
    },
  ));
}