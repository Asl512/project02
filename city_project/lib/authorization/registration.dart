import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';


class Registration extends StatefulWidget
{
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
bool passwordVisible = true;
bool isChecked = false;
List errorNameSurname = [false,'errorNameSurname'];
List errorPassword = [false,'errorPassword'];
List errorEmail = [false,'errorEmail'];
String nameUser = '';
String email = '';
String password = '';

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                                onChanged: (String value)
                                {setState(() {
                                  nameUser = value;
                                  errorNameSurname[0] = false;
                                });},
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
                                onChanged: (String value)
                                {setState(() {
                                  email = value;
                                  errorEmail[0] = false;
                                });},
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
                                onChanged: (String value)
                                {setState(() {
                                  password = value;
                                  errorPassword[0] = false;
                                });},
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
                          onPressed: () {
                            Validation();
                          },
                          child: Text(textReady, style: Montserrat(style:Bold)),
                        )
                      ),

                    ///ТЕКСТ
                    Container(margin: EdgeInsets.symmetric(vertical:50),
                      child:  RichText(textAlign: TextAlign.center,
                          text: TextSpan(children: [
                        TextSpan(style: Montserrat(color:Grey,style: Regular,size: 16),
                          text: 'Регистрируясь, вы принимаете',
                        ),

                        TextSpan(style: Montserrat(size:16,color:Green,style: Regular),
                          text: ' условия сервиса.',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = ()
                            {
                              Navigator.pushNamed(context, '/conditions');
                            },
                        ),

                        TextSpan(style: Montserrat(color:Grey,style: Regular,size: 16),
                          text: ' Если вы уже регестрировались, то',
                        ),

                        TextSpan(style: Montserrat(size:16,color:Green,style: Regular),
                          text: ' вам сюда.',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = ()
                            {
                              Navigator.pushNamed(context, '/authorization');
                            },
                        ),

                      ]))
                    ),
                  ]
              )
            ]
        )
      ])
    );
  }

void Validation()
{
  setState(() {
    bool check = true;
    if(nameUser == '')
      {
        check = false;
        errorNameSurname[0] = true;
        errorNameSurname[1] = 'Введите имя';
      }

    if(email == '')
    {
      check = false;
      errorEmail[0] = true;
      errorEmail[1] = 'Введите почту';
    }

    if(password == '')
    {
      check = false;
      errorPassword[0] = true;
      errorPassword[1] = 'Введите пароль';
    }

    ///проверка в бд
    if(check == true)
    {
      bool index = false;
      for(int i = 0; i < dataUser.length; i++)
      {
        if(dataUser[i][1] == email)
        {
          index = true;
          break;
        }
      }

      if(index == true)
      {
        errorEmail[0] = true;
        errorEmail[1] = 'Данный пользователь уже зарегестрирован';
      }
      else
      {
        dataUser.add([nameUser,email,password,'image/defoult/defoultUser.jpg']);
        Navigator.pushNamedAndRemoveUntil(context, '/authorization', (route) => false);
      }
    }
  });
}
}