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
bool isChecked = false;
List errorPassword = [false,'errorPassword'];
List errorEmail = [false,'errorEmail'];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: LigthGreen,
        body:Stack(children: [
          ///ТРЕУГОЛЬНИКИ
          ListView(children:[Stack(children:[
            ClipPath(
              child: Container(decoration: BoxDecoration(color: GreenReady.withOpacity(0.5)),height: 500,width: 500,),
              clipper: Triangle(1),),
            ClipPath(
              child: Container(decoration: BoxDecoration(color: LigthGreen,),height: 500,width: 500,),
              clipper: Triangle(2),),
          ])]),


          ListView(shrinkWrap: true,padding: EdgeInsets.symmetric(horizontal: 14),
              children:[
                ///ВОЙТИ
                Container(alignment: Alignment.center,margin: EdgeInsets.symmetric(vertical: 70),
                    child:Text(textWelcome, style: Montserrat(style:SemiBold,color:Blue, size: 28))),

                Column(mainAxisAlignment:MainAxisAlignment.center,
                    children:[

                      ///EMAIL
                      Container(height: 112,
                          child: Column(children:
                          [
                            Container(width: double.infinity,
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text(textEmail, style: Montserrat(color:Blue)),
                            ),

                            Stack(
                                children: [
                                  Container(decoration: BoxDecoration(color:LigthGreen,
                                    borderRadius: BorderRadius.circular(500),
                                    boxShadow: [BoxShadow(
                                      color: Colors.grey, blurRadius: 5, spreadRadius: 0.5,
                                      offset: Offset(0, 3),
                                    )],),height: 50,),

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
                          ]
                          )
                      ),

                      ///PASSWORD
                      Container(height: 128,
                          child: Column(children:
                          [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(textPassword, style: Montserrat(color:Blue)),
                                ),

                                TextButton(
                                  child: Text(textHelp, style: Montserrat(color:Blue)),
                                  onPressed: ()
                                  {
                                    setState(() {
                                      errorPassword[0] = !errorPassword[0];
                                      errorEmail[0] = !errorEmail[0];
                                    });
                                  },
                                )
                              ],),

                            Stack(children: [
                              Container(decoration: BoxDecoration(color:LigthGreen,
                                borderRadius: BorderRadius.circular(500),
                                boxShadow: [BoxShadow(
                                  color: Colors.grey, blurRadius: 5, spreadRadius: 0.5,
                                  offset: Offset(0, 3),
                                )],),height: 50,),

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
                                            icon: IconShowHide(passwordVisible),
                                            onPressed: ()
                                            {
                                              setState(() {
                                                passwordVisible = !passwordVisible;
                                              });
                                            },
                                          )
                                      ),

                                      //ВЫВОД ОШИБКИ
                                      errorText: errorPassword[0] == true ? errorPassword[1] : null,
                                      errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                      isDense: true,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                          borderSide: BorderSide(width: 0, style: errorPassword[0] == true ? BorderStyle.solid : BorderStyle.none)
                                      ),
                                      fillColor: White,
                                      filled: true
                                  )
                              )])
                          ]
                          )
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
                          child: Column(
                            children: [
                              Text(textPreRegister, style: Montserrat(color:Grey,style: Regular,size: 16)),

                              TextButton(
                                  child: Text(textRegister, style: Montserrat(size:16,color:Green,style: Regular)),
                                  onPressed: (){
                                    Navigator.pushNamed(context, '/registration');
                                  })
                            ],)
                      )
                    ])
              ]
          )
        ],)
    );
  }
}