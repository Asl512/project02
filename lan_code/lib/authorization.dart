import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';

class Authorization extends StatefulWidget
{
  const Authorization({Key? key}) : super(key: key);

  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
bool passwordVisible = false;
var errorPassword = [true,'errorPassword'];
var errorEmail = [false,'errorEmail'];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:ListView(shrinkWrap: true,children:
        [
          Container(alignment: Alignment.center,decoration: BoxDecoration(color: Colors.black),
            child:Text(textWelcome, style: Montserrat(style:Bold,color:Blue, size: 28))
          ),

          ///EMAIL
          Container(
              child: Column(children:
              [
                Container(width: double.infinity,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(textEmail, style: Montserrat(color:Blue,size:18)),
                ),

                TextField(style: Montserrat(style:SemiBold),
                    obscureText: passwordVisible,
                    decoration: InputDecoration(

                      //ИКОНКА
                        prefixIcon: Container(margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: iconPassword
                        ),

                        //ВЫВОД ОШИБКИ
                        errorText: errorEmail[0] == true ? errorEmail[1].toString() : null,
                        errorStyle: Montserrat(style:Medium,color: Red),

                        isDense: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                            borderSide: BorderSide(width: 0, style: errorEmail[0] == true ? BorderStyle.solid : BorderStyle.none)
                        ),
                        fillColor: White,
                        filled: true
                    )
                )
              ]
              )
          ),

          ///PASSWORD
          Container(
              child: Column(children:
              [
                Container(width: double.infinity,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(textPassword, style: Montserrat(color:Blue,size:18)),
                ),

                TextField(style: Montserrat(style:SemiBold),
                    obscureText: passwordVisible,
                    decoration: InputDecoration(

                      //ИКОНКА
                        prefixIcon: Container(margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: iconPassword
                        ),

                        //СКРЫТЬ/ПОКАЗАТЬ
                        suffixIcon: Container(margin: EdgeInsets.only(right: 10),
                            child: IconButton(
                              icon: Image.asset(passwordVisible ? iconShow : iconHide,width: 20, height: 20,),
                              onPressed: ()
                              {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            )
                        ),

                        //ВЫВОД ОШИБКИ
                        errorText: errorPassword[0] == true ? errorPassword[1].toString() : null,
                        errorStyle: Montserrat(style:Medium,color: Red),

                        isDense: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                            borderSide: BorderSide(width: 0, style: errorPassword[0] == true ? BorderStyle.solid : BorderStyle.none)
                        ),
                        fillColor: White,
                        filled: true
                    )
                )
              ]
              )
          ),

        ]
    )
    );
  }
}