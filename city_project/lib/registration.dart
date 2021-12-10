import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';


class Registration extends StatefulWidget
{
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
bool passwordVisible = false;
bool isChecked = false;
List errorNameSurname = [false,'errorNameSurname'];
List errorPassword = [false,'errorPassword'];
List errorEmail = [false,'errorEmail'];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: LigthGreen,
      body:Stack(children:[
        ///ТРЕУГОЛЬНИКИ
        ListView(children:[
          Stack(children:[
            ClipPath(clipper: Triangle(1),
                child: Container(decoration: BoxDecoration(color: GreenReady.withOpacity(0.5)),height: 500,width: 500,)
            ),
            ClipPath(clipper: Triangle(2),
                child: Container(decoration: BoxDecoration(color: LigthGreen,),height: 500,width: 500,)
            ),
          ])
        ]),

        ListView(shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 14),
            children:[
              ///РЕГИСТРАЦИЯ
              Container(alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 70),
                  child:Text(textRegistration, style: Montserrat(style:SemiBold,color:Blue, size: 28))
              ),

              Column(mainAxisAlignment:MainAxisAlignment.center,
                  children:[

                    ///ИМЯ И ФАМИЛИЯ
                    Container(height: 112,
                        child: Column(children: [
                          Container(width: double.infinity,
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(textNameSurname, style: Montserrat(color:Blue))
                          ),

                          Stack(children:[
                            Shadow(50,500),//ТЕНЬ

                            TextField(style: Montserrat(color:Blue),
                                decoration: InputDecoration(

                                  //ИКОНКА
                                    prefixIcon: Container(margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: iconPerson
                                    ),

                                    //ВЫВОД ОШИБКИ
                                    errorText: errorNameSurname[0] == true ? errorNameSurname[1] : null,
                                    errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                    //СТИЛЬ
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                        borderSide: BorderSide(width: 0, style: errorNameSurname[0] == true ? BorderStyle.solid : BorderStyle.none)
                                    ),
                                    fillColor: White,
                                    isDense: true,
                                    filled: true
                                )
                            )
                          ])
                        ])
                      ),

                    ///EMAIL
                    Container(height: 112,
                        child: Column(children:[
                          Container(width: double.infinity,
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(textEmail, style: Montserrat(color:Blue))
                          ),

                          Stack(children: [
                            Shadow(50,500),//ТЕНЬ

                            TextField(style: Montserrat(color:Blue),
                                obscureText: passwordVisible,
                                decoration: InputDecoration(

                                  //ИКОНКА
                                    prefixIcon: Container(margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: iconEmail
                                    ),

                                    //ВЫВОД ОШИБКИ
                                    errorText: errorEmail[0] == true ? errorEmail[1] : null,
                                    errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                    //СТИЛЬ
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                        borderSide: BorderSide(width: 0, style: errorEmail[0] == true ? BorderStyle.solid : BorderStyle.none)
                                    ),
                                    fillColor: White,
                                    isDense: true,
                                    filled: true
                                )
                            )
                          ])
                        ])
                    ),

                    ///PASSWORD
                    Container(height: 128,
                        child: Column(children:[
                          Container(width: double.infinity,
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(textComePassword, style: Montserrat(color:Blue)),
                          ),

                          Stack(children:[
                            Shadow(50,500),//ТЕНЬ

                            TextField(style: Montserrat(color:Blue),
                                obscureText: passwordVisible,
                                decoration: InputDecoration(

                                  //ИКОНКА
                                    prefixIcon: Container(margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: iconPassword
                                    ),

                                    //СКРЫТЬ/ПОКАЗАТЬ
                                    suffixIcon: Container(margin: EdgeInsets.only(right: 10),
                                        child: IconButton(
                                          icon: passwordVisible == true ? iconShow : iconHide,
                                          onPressed: ()
                                          {
                                            setState(()
                                            {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                        )
                                    ),

                                    //ВЫВОД ОШИБКИ
                                    errorText: errorPassword[0] == true ? errorPassword[1] : null,
                                    errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                    //СТИЛЬ
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                        borderSide: BorderSide(width: 0, style: errorPassword[0] == true ? BorderStyle.solid : BorderStyle.none)
                                    ),
                                    fillColor: White,
                                    isDense: true,
                                    filled: true
                                )
                            )
                          ])
                        ])
                    ),

                    ///ВОЙТИ ЧЕРЕЗ
                    LoginHrough(textLoginThrough),

                    ///КНОПКА
                    Container(padding: EdgeInsets.symmetric(horizontal: 106),
                        margin: EdgeInsets.only(top:30),
                        child:TextButton(
                          style: TextButton.styleFrom(minimumSize: Size.fromHeight(60),
                              primary: Green,
                              backgroundColor: GreenReady),
                          onPressed: () {},
                          child: Text(textReady, style: Montserrat(style:Bold)),
                        )
                      ),

                    ///ТЕКСТ
                    Container(margin: EdgeInsets.only(top:50),
                        child: Column(children:[
                          Text('Регистрируясь, вы принимаете', style: Montserrat(color:Grey,style: Regular,size: 16)),

                          Row(children: [
                            TextButton(child: Text('условия сервиса.', style: Montserrat(size:16,color:Green,style: Regular)),
                                onPressed: () {}
                            ),
                            Text('Если вы уже', style: Montserrat(color:Grey,style: Regular,size: 16)),
                          ]),

                          Row(children: [
                            Text('регестрировались, то', style: Montserrat(color:Grey,style: Regular,size: 16)),
                            TextButton(child: Text('вам сюда.', style: Montserrat(size:16,color:Green,style: Regular)),
                                onPressed: () {Navigator.pop(context);}
                            )
                          ],)
                        ])
                    )
                  ]
              )
            ]
        )
      ])
    );
  }
}