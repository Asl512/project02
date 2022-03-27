import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lan_code/common/images.dart';
import 'package:lan_code/feature/presentation/libary/customSnackBar.dart';
import 'package:lan_code/feature/presentation/libary/topSnackBart.dart';
import 'package:lan_code/feature/presentation/widgets/button_widget.dart';
import 'package:lan_code/feature/presentation/widgets/link_to_document_widget.dart';
import 'package:lan_code/feature/presentation/widgets/loading_widget.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/icons.dart';
import '../../../../../common/textStyle.dart';
import '../../../../../service.dart';
import '../../../widgets/text_field_style.dart';
import '../../../navigation.dart';
import 'recovery/first_step_age.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
bool passwordVisible = true;
bool isChecked = false;
List errorPassword = [false,"errorPassword"];
List errorEmail = [false,"errorEmail"];
String email = '';
String password = '';
bool isLoading = false;

AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size sizePage = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
            backgroundColor: Grey,
            appBar: AppBar(
              backgroundColor:Grey,
              elevation: 0.0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,size: 20,color: Blue),
                  onPressed: ()=>Navigator.pop(context)
              ),
              title: Text("Авторизация",style: Montserrat(size: 25,style: Bold)),
            ),

            body:ListView(
              children: [

                Container(
                  height: sizePage.height/7,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: sizePage.width/7),
                  child: Image.asset(logo)
                ),

                SizedBox(
                    height: sizePage.height/2.2,
                    child: Container(
                      margin: const EdgeInsets.only(top: 80),
                      padding: EdgeInsets.symmetric(horizontal: sizePage.width/15),
                      child: Column(
                          children:[

                            ///EMAIL
                            Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      const TitleTextFormField(text: "Почта:"),
                                      TextFieldWithShadow(
                                        TextField(
                                            style: Montserrat(color:Blue,size: 15),
                                            onChanged: (String value)
                                            {setState(() {
                                              email = value;
                                              errorEmail[0] = false;
                                            });},
                                            decoration: TextFieldDecoration(
                                                hintText: "Введите свою почту",
                                                prefixIcon: PrefixIconTextField(
                                                    color: const Color(0xFF546eff),
                                                    icon: iconEmail
                                                )
                                            ).inputDecoration
                                        ),
                                        errorText: true,
                                        error: errorEmail,
                                      )
                                    ]
                                )
                            ),

                            ///PASSWORD
                            Column(
                                children:[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[
                                        Container(margin: const EdgeInsets.only(left: 10),
                                          child: Text("Пароль:", style: Montserrat(size: 17,style: SemiBold)),
                                        ),

                                        //КНОПКА "напомнить?"
                                        TextButton(
                                          child: Text("Напомнить", style: Montserrat(size: 17,style: SemiBold)),
                                          onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> const FirstStepPage()))
                                        )
                                      ]
                                  ),

                                  TextFieldWithShadow(
                                    TextField(
                                        style: Montserrat(color:Blue,size: 15),
                                        obscureText: passwordVisible,
                                        onChanged: (String value)
                                        {setState(() {
                                          password = value;
                                          errorPassword[0] = false;
                                        });},
                                        decoration: InputDecoration(
                                          //ИКОНКА
                                            prefixIcon: PrefixIconTextField(
                                                color: const Color(0xFF00f069),
                                                icon: iconPassword
                                            ),

                                            //СКРЫТЬ/ПОКАЗАТЬ
                                            suffixIcon: Container(
                                                margin: const EdgeInsets.only(right: 10),
                                                child: IconButton(
                                                  icon: passwordVisible == true ? iconShow : iconHide,
                                                  onPressed: ()=>setState(()=>passwordVisible = !passwordVisible)
                                                )
                                            ),
                                            hintStyle: Montserrat(color: Colors.black26, size: 15),
                                            hintText: "Введите ваш пароль",

                                            //СТИЛЬ
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20),
                                                borderSide: const BorderSide(width: 0, style: BorderStyle.none)
                                            ),
                                            fillColor: White,
                                            isDense: true,
                                            filled: true
                                        )
                                    ),
                                    errorText: true,
                                    error: errorPassword,
                                  )
                                ]
                            )
                          ]
                      )
                    )
                ),

                SizedBox(
                    height: sizePage.height/4.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///КНОПКА ВОЙТИ
                        ButtonWidget(
                          text: "Войти",
                          func: ()=>Validation(),
                        ),
                        ///ТЕКСТ
                        const ListToDocumentWidget(
                          mainText: "При входе, вы принимаете условия пользования сервисом.",
                          func: null,
                        )
                      ]
                    )
                )

              ]
            )
        ),

        Positioned(
          child: isLoading ? Container(
            child: const LoadingWidget(),
            color: Colors.white.withOpacity(0.8),
          ) : Container(),
        )
      ]
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
        showTopSnackBar(context, CustomSnackBar.error(message:"Вы ввели не правильные данные",textStyle: Montserrat(size: 15,color: White)));
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const Navigation(index: 3)), (route) => false);
      }
      setState(() => isLoading = false);
    }
    else {
      showTopSnackBar(context, CustomSnackBar.error(message:"Ошибка валидации полей",textStyle: Montserrat(size: 15,color: White)));
    }
  }
}
