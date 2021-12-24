import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'city/city.dart';

import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';

class Conditions extends StatefulWidget
{
  const Conditions({Key? key}) : super(key: key);

  @override
  State<Conditions> createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {

  @override
  Widget build(BuildContext context)
  {
    double heigthBar = MediaQuery.of(context).size.height/6;
    return Scaffold(backgroundColor: LigthGreen,
        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(heigthBar),
            child: AppBar(flexibleSpace: Image(image: AssetImage(imgBackCity),
                fit: BoxFit.cover),
                centerTitle: false,
                titleSpacing: 0.0,
                bottom: PreferredSize(child:Stack(children: [
                  Container(width: double.infinity,
                      height: heigthBar/2,
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.7))
                  ),

                  Container(height: heigthBar/2,
                      padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child: Text(textServiceConditions,style: Montserrat(style:SemiBold,size: 18)),
                  )
                ]),
                  preferredSize: Size.fromHeight(50),)
            )
        ),

        ///ТЕЛО
        body: ListView(padding: EdgeInsets.zero,
                children: [
                  Container(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                    child: Text(textConditions,style: Montserrat(color:Colors.black, size: 18)),
                  )
            ])
    );
  }
}