import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../assets/style.dart';
import '../../assets/finally.dart';
import '../../assets/text.dart';
import '../../assets/data.dart';

class PersonalArea extends StatefulWidget
{
  const PersonalArea({Key? key}) : super(key: key);


  @override
  State<PersonalArea> createState() => _PersonalAreaState();
}

class _PersonalAreaState extends State<PersonalArea> {

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
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Container(margin: EdgeInsets.only(right: 20),
                        child: ClipRRect(borderRadius: BorderRadius.circular(500),
                            child: Image.asset(dataUser[auth][3], fit: BoxFit.cover,
                              width: 60, height: 60,)
                        ),
                      ),

                        RichText(textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(text:textHi,style: Montserrat(style:SemiBold,size: 20)),
                              TextSpan(text:dataUser[auth][0],style: Montserrat(style:SemiBold,size: 20))
                            ])
                        )
                    ],),
                  )
                ]),
                  preferredSize: Size.fromHeight(50),)
            )
        ),

        ///ТЕЛО
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(children: [
              Container(margin: EdgeInsets.only(top: 30),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(color: Green),
                      child: TextButton(onPressed:() {
                        Navigator.pushNamed(context, '/records');
                      },
                          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                          child:Container(width: double.infinity, height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Green),
                              child: Row(children: [
                                Container(margin: EdgeInsets.only(right: 15),
                                  child:  iconTickets,),
                                Text(textMyTickets, style: Montserrat(),),
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
                      child: TextButton(onPressed:() {
                        Navigator.pushNamed(context, '/addExcursion');
                      },
                          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                          child:Container(width: double.infinity, height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Green),
                              child: Row(children: [
                                Container(margin: EdgeInsets.only(right: 15),
                                  child:  iconAdd,),
                                Text(textAddExcursion, style: Montserrat(),),
                              ],)
                          )
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Green),
                      child: TextButton(onPressed:() {
                        Navigator.pushNamed(context, '/excursionMy');
                      },
                          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                          child:Container(width: double.infinity, height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Green),
                              child: Row(children: [
                                Container(margin: EdgeInsets.only(right: 15),
                                  child:  iconExcursion,),
                                Text(textMyExcursion, style: Montserrat(),),
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
                      child: TextButton(onPressed:() {
                        Navigator.pushNamed(context, '/favorite');
                      },
                          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                          child:Container(width: double.infinity, height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Green),
                              child: Row(children: [
                                Container(margin: EdgeInsets.only(right: 15),
                                  child:  iconFavoriteLi,),
                                Text(textFavorite, style: Montserrat(),),
                              ],)
                          )
                      ),
                    )
                  ])
              ),
            ]),

            ///ПОДВАЛ
            Column(children: [
              Container(margin: EdgeInsets.only(bottom: 30),
                  child: Column(children: [
                    Container(decoration: BoxDecoration(color: Green),
                      margin: EdgeInsets.only(bottom: 15),
                      child: TextButton(onPressed:() {
                        Navigator.pushNamed(context, '/settings');
                      },
                          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                          child:Container(width: double.infinity, height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Green),
                              child: Row(children: [
                                Container(margin: EdgeInsets.only(right: 15),
                                  child:  iconSettings,),
                                Text(textSettings, style: Montserrat(),),
                              ],)
                          )
                      ),
                    ),

                    Container(decoration: BoxDecoration(color: Red),
                      child: TextButton(onPressed:() {
                        auth = -1;
                        Future checkFirstSeen() async
                        {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setInt('auth', -1);
                        }
                        checkFirstSeen();
                        Navigator.pushNamedAndRemoveUntil(context, '/authorization', (route) => false);
                      },
                          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50))),
                          child:Container(width: double.infinity, height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Red),
                              child: Row(children: [
                                Container(margin: EdgeInsets.only(right: 15),
                                  child:  iconExit,),
                                Text(textExit, style: Montserrat(),),
                              ],)
                          )
                      ),
                    )
                  ])
              ),
            ],
            )
          ],
        )
    );
  }
}