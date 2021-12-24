import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../excursion/excursion.dart';
import 'city/functionCity.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';

class Settings extends StatefulWidget
{
  const Settings({Key? key}) : super(key: key);


  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double heigthBar = MediaQuery.of(context).size.height/6;
    return Scaffold(backgroundColor: LigthGreen,
        ///МЕНЮ
        drawer: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black.withOpacity(0.9),),
            child:Menu(context)
        ),


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
                    child: Text(textSettings.toUpperCase(),style: Montserrat(style:SemiBold,size: 18)),
                  )
                ]),
                  preferredSize: Size.fromHeight(50),)
            )
        ),

        ///ТЕЛО
        body: Column(children: [
          Container(margin: EdgeInsets.only(top: 30),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(color: Green),
                  child: TextButton(onPressed:() {},
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                      child:Container(width: double.infinity, height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Green),
                          child: Row(children: [
                            Container(margin: EdgeInsets.only(right: 15),
                              child:  iconPersonWhite,),
                            Text(textEditName, style: Montserrat(),),
                          ],)
                      )
                  ),
                )
              ])
          ),

          Container(margin: EdgeInsets.only(top: 15),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(color: Green),
                  child: TextButton(onPressed:() {},
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                      child:Container(width: double.infinity, height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Green),
                          child: Row(children: [
                            Container(margin: EdgeInsets.only(right: 15),
                              child:  iconEmailWhite,),
                            Text(textEditEmail, style: Montserrat(),),
                          ],)
                      )
                  ),
                ),
                Container(decoration: BoxDecoration(color: Green),
                  child: TextButton(onPressed:() {
                  },
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                      child:Container(width: double.infinity, height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Green),
                          child: Row(children: [
                            Container(margin: EdgeInsets.only(right: 15),
                              child:  iconPhone,),
                            Text(textEditPhone, style: Montserrat(),),
                          ],)
                      )
                  ),
                ),

                Container(decoration: BoxDecoration(color: Green),
                  child: TextButton(onPressed:() {
                  },
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                      child:Container(width: double.infinity, height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Green),
                          child: Row(children: [
                            Container(margin: EdgeInsets.only(right: 15),
                              child:  iconPasswordWhite,),
                            Text(textEditPassword, style: Montserrat(),),
                          ],)
                      )
                  ),
                )
              ])
          ),
        ]),
    );
  }
}