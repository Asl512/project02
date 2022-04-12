import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/backButtons.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';

class doublePsw extends StatefulWidget
{
  const doublePsw(this.email, {Key? key}) : super(key: key);
  final String? email;

  @override
  State<doublePsw> createState() => _doublePswState();
}

class _doublePswState extends State<doublePsw> {
  bool passwordVisible = true;
  bool passwordVisibleTwo = true;
  bool errorPassword = false;
  bool errorPasswordTwo = false;
  String password = '';
  String passwordTwo = '';
  bool isLoading = false;

  final TextEditingController controllerValidPassword = new TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size SizePage = MediaQuery.of(context).size;
    return Stack(children: [
        Scaffold(backgroundColor: Grey,

            ///ШАПКА
            appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/5),
                child: AppBar(backgroundColor:Grey, elevation: 0.0,
                    leading: Container(),
                    flexibleSpace:Stack(alignment: Alignment.topLeft,
                        children: [
                          Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 70),
                              alignment: Alignment.center,
                              child: Text("Введите новый пароль",style: Montserrat(color:Blue,size: 35,style: Bold)),
                              padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                            ),
                          ]),
                          ButtonBack()
                        ])
                )
            ),

        body:ListView(shrinkWrap: true,
          children: [
            Container(
                height: SizePage.height/2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizePage.width/15),
                  child: Column(
                      children:[

                        ///PASSWORD
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleTextFormField(text: "Пароль:"),

                              TextFieldWithShadow(
                                  TextField(
                                      controller: controllerValidPassword,
                                      style: Montserrat(
                                          color: Blue, size: 15),
                                      obscureText: passwordVisible,
                                      onChanged: (String value) {
                                        setState(() {
                                          password = value;
                                          errorPassword = false;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        //ИКОНКА
                                          prefixIcon: PrefixIconTextField(color: Color(0xFF00f069),icon: iconPassword),

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

                                          hintStyle: Montserrat(color: Colors.black26, size: 15),
                                          hintText: "Придумайте пароль",

                                          //СТИЛЬ
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  500),
                                              borderSide: BorderSide(width: 0,
                                                  style: BorderStyle.none)
                                          ),
                                          fillColor: White,
                                          isDense: true,
                                          filled: true
                                      ),
                                  ),
                                error: [errorPassword],
                              )
                            ]),

                        ///PASSWORD
                        Container(margin: EdgeInsets.only(top: 30),
                            child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  TitleTextFormField(text: "Повторите пароль:"),

                                  TextFieldWithShadow(
                                      TextField(style: Montserrat(color:Blue,size: 15),
                                          obscureText: passwordVisibleTwo,
                                          onChanged: (String value)
                                          {setState(() {
                                            passwordTwo = value;
                                            errorPasswordTwo = false;
                                          });},
                                          decoration: InputDecoration(
                                            //ИКОНКА
                                              prefixIcon: PrefixIconTextField(color: Color(0xFF00f069), icon: iconPassword),

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

                                              hintStyle: Montserrat(color: Colors.black26, size: 15),
                                              hintText: "Повторите пароль",

                                              //СТИЛЬ
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                                                  borderSide: BorderSide(width: 0, style: BorderStyle.none)
                                              ),
                                              fillColor: White,
                                              isDense: true,
                                              filled: true
                                          )
                                      ),
                                    error: [errorPasswordTwo],
                                  )
                                ])
                        )

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
                            child: Center(child: Text("Далее", style: Montserrat(style: SemiBold,size: 19)),)
                        )
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
    if(password == ''){
      setState(()=>errorPassword = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Введите пароль',textStyle: Montserrat(size: 15)));
    }
    else if(password.length < 6) {
      setState(()=>errorPassword = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Слишком короткий пароль',textStyle: Montserrat(size: 15)));
    }
    else if(passwordTwo == ''){
      setState(()=>errorPasswordTwo = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Введите повторный пароль',textStyle: Montserrat(size: 15)));
    }
    else if(password != passwordTwo){
      setState(()=>errorPassword = true);
      setState(()=>errorPasswordTwo = true);
      showTopSnackBar(context, CustomSnackBar.error(message:'Пароли не совпадают',textStyle: Montserrat(size: 15)));
    }
    else{
      showTopSnackBar(context, CustomSnackBar.success(message:'Вы успешно сменили пароль',textStyle: Montserrat(size: 15)));
      await Future<void>.delayed(const Duration(seconds: 5));
      Navigator.pop(context);
    }
  }

}
