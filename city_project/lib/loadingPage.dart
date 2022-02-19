import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Size SizePage = MediaQuery.of(context).size;

    ///ПРОВЕРКА НА СУПЕР ГЛОБАЛЬНУЮ ПЕРЕМЕННУЮ
    Future checkFirstSeen() async
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? _seen = prefs.getInt('seer');
      if (_seen == 115)
      {
        prefs.setInt('seer', 115);
      }
    }

    return Scaffold(backgroundColor: Grey,

        body:Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iLoading, width: SizePage.width/1.3, height: SizePage.width/1.3, fit:BoxFit.fill),
              Container( padding: EdgeInsets.symmetric(horizontal: SizePage.width/6),
                child:Text(textLoading, style: Montserrat(style: SemiBold,size: 18,color:Blue)),
              )
            ])
    );
  }
}