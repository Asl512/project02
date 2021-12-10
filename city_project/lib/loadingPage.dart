import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';

class Loading extends StatefulWidget
{
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  Widget build(BuildContext context)
  {

    ///ПРОВЕРКА НА СУПЕР ГЛОБАЛЬНУЮ ПЕРЕМЕННУЮ
    Future checkFirstSeen() async
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? _seen = prefs.getInt('seer');

      if (_seen == 10)
      {
        Navigator.pushNamedAndRemoveUntil(context, '/authorization', (route) => false);
      }
      else
      {
        prefs.setInt('seer', 10);
        Navigator.pushNamedAndRemoveUntil(context, '/perfomanceOne', (route) => false);
      }
    }

    checkFirstSeen();

    return Scaffold(backgroundColor: LigthGreen,
        body:Center(
          child: Text('ЗАГРУЗКА...', style: Montserrat(style: Bold,size: 20,color:Blue)),
        )
    );
  }
}