import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../assets/style.dart';
import '../assets/finally.dart';
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
List errorPassword = [false,'errorPassword'];
List errorEmail = [false,'errorEmail'];
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
        appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/10),
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

        body:ListView(shrinkWrap: true,
          children: [
            Container(
                height: SizePage.height/20*12,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(
                      children:[

                        ///EMAIL
                        Container(child: Column(children:[
                              Container(width: double.infinity,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text("Почта:", style: Montserrat(color:Blue,style: SemiBold)),
                              ),

                              Stack(children: [
                                Shadow(50,500), // ТЕНЬ
                                TextField(style: Montserrat(color:Blue,style: SemiBold),
                                    onChanged: (String value)
                                    {setState(() {
                                      email = value;
                                      errorEmail[0] = false;
                                    });},
                                    decoration: InputDecoration(
                                      //ИКОНКА
                                        prefixIcon: Container(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Color(0xFF546eff),
                                            ),
                                            width: 40,
                                            padding: EdgeInsets.all(6),
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
                        Container(child: Column(children:[
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

                              Stack(children:[
                                Shadow(50,500),// ТЕНЬ

                                TextField(style: Montserrat(color:Blue,style: SemiBold),
                                    obscureText: passwordVisible,
                                    onChanged: (String value)
                                    {setState(() {
                                      password = value;
                                      errorPassword[0] = false;
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

                      ]),
                )
            ),

            Container(
                height: SizePage.height/4,
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
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "При входе, вы принимаете условия пользования сервисом. ",
                              style: Montserrat(style: SemiBold,size: 13, color:Blue),
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
    bool check = true;
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
    r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this.email);
    if(email == '') {
      check = false;
      setState(() => errorEmail = [true,"Введите почту"]);
    }
    else if (emailValid == false) {
      setState(()=>errorEmail = [true,"Неверный формат почты"]);
      check = false;
    }

    if(password == '') {
      check = false;
      setState(() => errorPassword = [true,"Введите пароль"]);
    }

    if(check == true) {
      setState(() => isLoading = true);

      dynamic user = await authService.signIn(email.trim(), password.trim());
      if(user == null){
        setState(()=>errorEmail = [true,"Вы ввели не правильные данные"]);
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Navigation(index: 3)), (route) => false);
      }
      setState(() => isLoading = false);
    }
  }
}
