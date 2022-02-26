import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';


import '../../assets/style.dart';
import '../../assets/finally.dart';

class doublePsw extends StatefulWidget
{
  const doublePsw({Key? key}) : super(key: key);

  @override
  State<doublePsw> createState() => _doublePswState();
}

class _doublePswState extends State<doublePsw> {
  bool passwordVisible = true;
  bool passwordVisibleTwo = true;
  List errorPassword = [false,'errorPassword'];
  List errorPasswordTwo = [false,'errorPasswordTwo'];
  String password = '';
  String passwordTwo = '';

  final TextEditingController controllerValidPassword = new TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size SizePage = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Grey,

        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(50),
            child: AppBar(backgroundColor:Grey, elevation: 0.0,
                leading: Container(
                  width: 70,
                  decoration: BoxDecoration(color: Blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                  child: Transform.rotate(angle: 45*3.14/90,
                    child: IconButton(icon: iconArrowBottomWhite,
                      onPressed: (){
                        Navigator.pop(context);
                      },),
                  ),
                )
            )
        ),

        body:ListView(shrinkWrap: true,
          children: [
            Container(
              height: SizePage.height/5-70,
              child: Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: SizePage.width/15),
                  child:Text("newPsw".tr(), style: Montserrat(style:Bold,color:Blue, size: 30))
              ),
            ),
            Container(
                height: SizePage.height/2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(
                      children:[

                        ///PASSWORD
                        Container(margin: EdgeInsets.only(bottom: 25),
                          child: Column(
                            children: [
                              ///PASSWORD
                              Container(
                                  child: Column(children: [
                                    Container(width: double.infinity,
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                      child: Text("password".tr(), style: Montserrat(
                                          color: Blue, style: SemiBold)),
                                    ),

                                    Stack(children: [
                                      Shadow(50, 500), // ТЕНЬ

                                      TextField(
                                          controller: controllerValidPassword,
                                          style: Montserrat(
                                              color: Blue, style: SemiBold),
                                          obscureText: passwordVisible,
                                          onChanged: (String value) {
                                            setState(() {
                                              password = value;
                                              errorPassword[0] = false;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            //ИКОНКА
                                              prefixIcon: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15, vertical: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    color: Color(0xFF00f069),
                                                  ),
                                                  width: 40,
                                                  padding: EdgeInsets.all(6),
                                                  child: iconPassword
                                              ),

                                              //СКРЫТЬ/ПОКАЗАТЬ
                                              suffixIcon: Container(
                                                  margin: EdgeInsets.only(right: 10),
                                                  child: IconButton(
                                                    icon: passwordVisible == true
                                                        ? iconShow
                                                        : iconHide,
                                                    onPressed: () {
                                                      setState(() {
                                                        passwordVisible =
                                                        !passwordVisible;
                                                      });
                                                    },
                                                  )
                                              ),

                                              //СТИЛЬ
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      500),
                                                  borderSide: BorderSide(width: 0,
                                                      style: errorPassword[0] == true
                                                          ? BorderStyle.solid
                                                          : BorderStyle.none)
                                              ),
                                              fillColor: White,
                                              isDense: true,
                                              filled: true
                                          )
                                      ),
                                    ])
                                  ])
                              ),
                              new SizedBox(
                                height: 10,
                              ),
                              new FlutterPwValidator(
                                controller: controllerValidPassword,
                                minLength: 6,
                                numericCharCount: 1,
                                width: SizePage.width,
                                height: SizePage.height/15,
                                onSuccess: (){
                                  setState(() {
                                    errorPassword[0] = false;
                                  });
                                },
                                onFail: (){
                                  setState(() {
                                    errorPassword[0] = true;
                                  });
                                },
                              )
                            ],
                          )),

                        ///PASSWORD
                        Container(child: Column(children:[
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(margin: EdgeInsets.only(left: 10),
                                      child: Text("passwordAgain".tr(), style: Montserrat(color:Blue,style: SemiBold)),
                                    ),

                                  ]
                              ),

                              Stack(children:[
                                Shadow(50,500),// ТЕНЬ

                                TextField(style: Montserrat(color:Blue,style: SemiBold),
                                    obscureText: passwordVisibleTwo,
                                    onChanged: (String value)
                                    {setState(() {
                                      passwordTwo = value;
                                      errorPasswordTwo[0] = false;
                                    });},
                                    decoration: InputDecoration(
                                      //ИКОНКА
                                        prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Color(0xFF00f069),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
                                            child: iconPassword
                                        ),

                                        //СКРЫТЬ/ПОКАЗАТЬ
                                        suffixIcon: Container(margin: EdgeInsets.only(right: 10),
                                            child: IconButton(
                                              icon: passwordVisibleTwo == true ? iconShow : iconHide,
                                              onPressed: ()
                                              {
                                                setState(()
                                                {
                                                  passwordVisibleTwo = !passwordVisibleTwo;
                                                });
                                              },
                                            )
                                        ),

                                        //ВЫВОД ОШИБКИ
                                        errorText: errorPasswordTwo[0] == true ? errorPasswordTwo[1] : null,
                                        errorStyle: Montserrat(style:Medium,color: Red,size: 15),

                                        //СТИЛЬ
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                            borderSide: BorderSide(width: 0, style: errorPasswordTwo[0] == true ? BorderStyle.solid : BorderStyle.none)
                                        ),
                                        fillColor: White,
                                        isDense: true,
                                        filled: true
                                    )
                                )
                              ])
                            ])
                        ),

                      ]),
                )
            ),

            Container(
                height: SizePage.height/3-60,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///КНОПКА ВОЙТИ
                    TextButton(onPressed: (){
                      Validation();
                    },
                        child: Container(width: SizePage.width-SizePage.width/15*2,
                            height: 50,
                            decoration: BoxDecoration(color: Blue,
                                borderRadius: BorderRadius.all(Radius.circular(500))),
                            child: Center(child: Text("next".tr(), style: Montserrat(style: SemiBold,size: 19)),)
                        )
                    ),
                  ],
                )
            ),
          ],
        )
    );
  }

  void Validation(){

    if(!errorPassword[0])
      {
        if(password == passwordTwo){
          ///проходит
        }
        else{
          setState(() {
            errorPasswordTwo = [true,'errorPasswordMatch'.tr()];
          });
        }
      }
  }

}
