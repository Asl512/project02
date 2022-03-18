import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../assets/style.dart';
import '../assets/finally.dart';
import '../libary/customSnackBar.dart';
import '../libary/topSnackBart.dart';
import 'recovery/passwRecovery.dart';
import '../navigation.dart';
import '../service.dart';

class Authorization extends StatefulWidget
{
  const Authorization({Key? key}) : super(key: key);

  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
bool passwordVisible = true;
bool isChecked = false;
List errorPassword = [false,"errorPassword"];
List errorEmail = [false,"errorEmail"];
String email = '';
String password = '';
bool isLoading = false;

AuthService authService = AuthService();

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size SizePage = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(backgroundColor: Grey,

        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/9),
            child: AppBar(backgroundColor:Grey, elevation: 0.0,
                leading: Container(),
                flexibleSpace:Stack(alignment: Alignment.topLeft,
                    children: [
                      Column(children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          alignment: Alignment.center,
                          child: Text("Авторизация",style: Montserrat(color:Blue,size: 35,style: Bold)),
                          padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                        ),
                      ]),
                      ButtonBack()
                    ])
            )
        ),

        body:ListView(
          children: [
            Container(
                height: SizePage.height/20*12,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(children:[

                        ///EMAIL
                        Container(margin: EdgeInsets.only(bottom: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                RichTextMethod("Почта:"),

                                TextFieldWithShadow(
                                    TextField(style: Montserrat(color:Blue,size: 15),
                                        onChanged: (String value)
                                        {setState(() {
                                          email = value;
                                          errorEmail[0] = false;
                                        });},
                                        decoration: TextFieldDecoration(
                                          hintText: "Введите свою почту",
                                            prefixIcon: PrefixIconTextField(color: Color(0xFF546eff), icon: iconEmail)
                                        ).InputDecor()
                                    ),
                                  errorText: true,
                                  error: errorEmail,
                                )
                              ]
                          )
                        ),

                        ///PASSWORD
                        Column(children:[
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Container(margin: EdgeInsets.only(left: 10),
                                  child: Text("Пароль:", style: Montserrat(color:Blue,style: SemiBold)),
                                ),

                                //КНОПКА "напомнить?"
                                TextButton(
                                  child: Text("Напомнить", style: Montserrat(color:Blue,style: SemiBold)),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=> passwRecovery()));
                                  },
                                )
                              ]
                          ),

                          TextFieldWithShadow(
                              TextField(style: Montserrat(color:Blue,size: 15),
                                  obscureText: passwordVisible,
                                  onChanged: (String value)
                                  {setState(() {
                                    password = value;
                                    errorPassword[0] = false;
                                  });},
                                  decoration: InputDecoration(
                                      //ИКОНКА
                                      prefixIcon: PrefixIconTextField(color: Color(0xFF00f069), icon: iconPassword),

                                      //СКРЫТЬ/ПОКАЗАТЬ
                                      suffixIcon: Container(margin: EdgeInsets.only(right: 10),
                                          child: IconButton(
                                            icon: passwordVisible == true ? iconShow : iconHide,
                                            onPressed: ()
                                            {
                                              setState(()=>passwordVisible = !passwordVisible);
                                            },
                                          )
                                      ),
                                      hintStyle: Montserrat(color: Colors.black26, size: 15),
                                      hintText: "Введите ваш пароль",

                                      //СТИЛЬ
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(width: 0, style: BorderStyle.none)
                                      ),
                                      fillColor: White,
                                      isDense: true,
                                      filled: true
                                  )
                              ),
                            errorText: true,
                            error: errorPassword,
                          )
                        ])

                      ]),
                )
            ),

            Container(
                height: SizePage.height/4.2,
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
                            child: Center(child: Text("Войти", style: Montserrat(style: SemiBold,size: 19)),)
                        )
                    ),

                    ///ТЕКСТ
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: SizePage.width/5),
                      child: RichText(textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "При входе, вы принимаете условия пользования сервисом. ",
                              style: Montserrat(size: 12, color: Blue),
                            ),
                            TextSpan(
                              text: "Подробнее.", style: Montserrat(style: SemiBold,size: 13, color:Red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showModalBottomSheet(
                                      backgroundColor:White.withOpacity(0),
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
      ],
    );
  }

  void Validation() async {
    int countError = 0;
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
    r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this.email);
    if(email == '') {
      setState(() => errorEmail = [true,"Введите почту"]);
      countError++;
    }
    else if (emailValid == false) {
      setState(()=>errorEmail = [true,"Неверный формат почты"]);
      countError++;
    }

    if(password == '') {
      setState(() => errorPassword = [true,"Введите пароль"]);
      countError++;
    }

    if(countError == 0) {
      setState(() => isLoading = true);

      dynamic user = await authService.signIn(email.trim(), password.trim());
      if(user == null){
        setState((){
          errorEmail = [true];
          errorPassword = [true];
        });
        showTopSnackBar(context, CustomSnackBar.error(message:"Вы ввели не правильные данные",textStyle: Montserrat(size: 15)));
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Navigation(index: 3)), (route) => false);
      }
      setState(() => isLoading = false);
    }
    else showTopSnackBar(context, CustomSnackBar.error(message:"Ошибка валидации полей",textStyle: Montserrat(size: 15)));
  }
}
