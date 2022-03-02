import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lan_code/service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


import '../assets/style.dart';
import '../assets/finally.dart';
import 'authorization.dart';
import '../navigation.dart';

class Registration extends StatefulWidget
{
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool passwordVisible = true;
  bool isChecked = false;
  List errorName = [false, 'errorName'];
  List errorPassword = [false, 'errorPassword'];
  List errorEmail = [false, 'errorEmail'];
  String name = '';
  String email = '';
  String password = '';
  bool isLoading = false;
  final TextEditingController controllerValidPassword = new TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size SizePage = MediaQuery
        .of(context)
        .size;
    return Stack(children: [
        Scaffold(backgroundColor: Grey,

            ///ШАПКА
            appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/10),
                child: AppBar(backgroundColor:Grey, elevation: 0.0,
                    leading: Container(),
                    flexibleSpace:Stack(alignment: Alignment.topLeft,
                        children: [
                          Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              alignment: Alignment.center,
                              child: Text("registration".tr(),style: Montserrat(color:Blue,size: 35,style: Bold)),
                              padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                            ),
                          ]),
                          Container(
                              height: 70,width: 50,
                              decoration: BoxDecoration(color: Blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                              child: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: White,),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  })
                          ),

                        ])
                )
            ),

        body: ListView(shrinkWrap: true,
          children: [
            Container(
                height: SizePage.height /20*12 ,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizePage.width / 15),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        ///NAME
                        Container(
                            child: Column(children: [
                              Container(width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text("nameSurname".tr(),
                                    style: Montserrat(
                                        color: Blue, style: SemiBold)),
                              ),

                              Stack(children: [
                                Shadow(50, 500), // ТЕНЬ
                                TextField(style: Montserrat(
                                    color: Blue, style: SemiBold),
                                    onChanged: (String value) {
                                      setState(() {
                                        name = value;
                                        errorName[0] = false;
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
                                              color: Color(0xFFffaf5a),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
                                            child: iconMenuProfil
                                        ),

                                        //ВЫВОД ОШИБКИ
                                        errorText: errorName[0] == true
                                            ? errorName[1]
                                            : null,
                                        errorStyle: Montserrat(style: Medium,
                                            color: Red,
                                            size: 15),

                                        //СТИЛЬ
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                500),
                                            borderSide: BorderSide(width: 0,
                                                style: errorName[0] == true
                                                    ? BorderStyle.solid
                                                    : BorderStyle.none)
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
                        Container(
                            child: Column(children: [
                              Container(width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text("email".tr(), style: Montserrat(
                                    color: Blue, style: SemiBold)),
                              ),

                              Stack(children: [
                                Shadow(50, 500), // ТЕНЬ
                                TextField(style: Montserrat(
                                    color: Blue, style: SemiBold),
                                    onChanged: (String value) {
                                      setState(() {
                                        email = value;
                                        errorEmail[0] = false;
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
                                              color: Color(0xFF546eff),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
                                            child: iconEmail
                                        ),

                                        //ВЫВОД ОШИБКИ
                                        errorText: errorEmail[0] == true
                                            ? errorEmail[1]
                                            : null,
                                        errorStyle: Montserrat(style: Medium,
                                            color: Red,
                                            size: 15),

                                        //СТИЛЬ
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                500),
                                            borderSide: BorderSide(width: 0,
                                                style: errorEmail[0] == true
                                                    ? BorderStyle.solid
                                                    : BorderStyle.none)
                                        ),
                                        fillColor: White,
                                        isDense: true,
                                        filled: true
                                    )
                                )
                              ])
                            ])
                        ),

                        Column(
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
                              height: SizePage.height/13,
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
                        )
                      ]),
                )
            ),

            Container(
                height: SizePage.height / 4,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    ///КНОПКА ЗАРЕГЕСТРИРОВАТЬСЯ
                    TextButton(onPressed: () {
                      Validation();
                    },
                        child: Container(
                            width: SizePage.width - SizePage.width / 15 * 2,
                            height: 50,
                            decoration: BoxDecoration(color: Blue,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(500))),
                            child: Center(child: Text("registration2".tr(),
                                style: Montserrat(style: SemiBold, size: 19)),)
                        )
                    ),

                    ///ТЕКСТ
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizePage.width / 5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "terms".tr(),
                              style: Montserrat(
                                  style: SemiBold, size: 13, color: Blue),
                            ),
                            TextSpan(
                              text: "more".tr(),
                              style: Montserrat(
                                  style: SemiBold, size: 13, color: Red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showModalBottomSheet(
                                      backgroundColor: White.withOpacity(0),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ShowDialog();
                                      });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        )
    ),

      Positioned(
        child: isLoading
            ? Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Blue),
            ),
          ),
          color: Colors.white.withOpacity(0.8),
        ) : Container(),
      ),
    ]);
  }

  void Validation()async{
    int countError = 0;
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
      r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
      if(email == '') {
          setState(()=>errorEmail = [true,"errorEmptyEmail".tr()]);
          countError++;
        }
      else if (emailValid == false) {
        setState(()=>errorEmail = [true,"errorValidEmail".tr()]);
        countError++;
      }

      if (name == '') {
        setState(() {
          errorName = [true,"errorEmptyName".tr()];
        });
        countError++;
      }
      else if(name.length < 5){
        setState(() {
          errorName = [true,"errorMiniName".tr()];
        });
        countError++;
      }

      if(countError == 0 && !errorPassword[0])
        {
          setState(() {isLoading = true;});

          dynamic user = await authService.register(email.trim(), password.trim());
          if(user == null){
            setState(()=>errorEmail = [true,"123".tr()]);
          }else{
            await FirebaseFirestore.instance.collection('user').add({
              "id": user.id,
              "name":this.name,
              "verified": false,
              "photo": 'null'
            });
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LocaleNavigation(index: 3)), (route) => false);
          }
          setState(() {isLoading = false;});
        }
    }
}