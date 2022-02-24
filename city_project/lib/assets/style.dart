import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shimmer/shimmer.dart';

import 'finally.dart';


///Функция для строк
TextStyle Montserrat({FontWeight style = Medium, Color color = White, double size = 18, double? heigth})
{
  return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: 'Montserrat',
      fontWeight: style,
      height: heigth
  );
}

///Тень для текстовых полей
class Shadow extends StatelessWidget {
  double? height;
  double? width;
  double radius = 0;

  Shadow(double height, double radius,[double? width]) {
    this.height = height;
    this.radius = radius;
    if(width != null) this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: height,width: width,
        decoration: BoxDecoration(color:Grey,
          borderRadius: BorderRadius.circular(radius),
          boxShadow:const [BoxShadow(color: Colors.black38,
              blurRadius: 5,
              spreadRadius: 0.5,
              offset: Offset(0, 7)
          )],
        )
    );
  }
}

///Пункты в диалоговом окне
class TextDialogWindows extends StatelessWidget {
  String title = '';
  String text = '';

  TextDialogWindows(String title, String text){
    this.title = title;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin:EdgeInsets.only(bottom:5),
          child: Text(title, style: Montserrat(color:White,size: 13,style: SemiBold),),
        ),
        Container(margin:EdgeInsets.only(bottom:10),
            child: Text(text, style: Montserrat(color:White,size: 13),)
        ),
      ],
    );
  }
}

///Кнопка выбора языка
class SelectLanguage extends StatelessWidget {
  String flag = '';
  String name = '';
  String codeLang = '';

  SelectLanguage(String name,String flag,String codeLang){
    this.name = name;
    this.flag = flag;
    this.codeLang = codeLang;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      translator.setNewLanguage(
        context,
        newLanguage: codeLang,
      );
      Navigator.pop(context);
    },
        child: Container(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/5),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.all(Radius.circular(500)),
                  child: Image.asset(flag,
                    fit: BoxFit.cover,
                    width: 50, height: 50,
                  ),
                ),
                Container(margin: EdgeInsets.only(left: 20),
                  child: Text(name,style: Montserrat(size: 16),),
                )
              ],
            ))
    );
  }
}

class ErrorNet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(iErrorNet,
          width: MediaQuery.of(context).size.width/1.3,
          height: MediaQuery.of(context).size.width/1.3, fit:BoxFit.fill
      ),
      Container( padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/12),
        child:Text("errorNet".tr(), style: Montserrat(style: SemiBold,size: 16,color:Blue)),
      ),
      TextButton(onPressed: (){},
        child: Text("repeat".tr().toUpperCase(), style: Montserrat(style: Bold,size: 16,color:Red)),)
    ]);
  }

}

class WaitDialog extends StatelessWidget {
  String illiustration = '';
  String text = '';

  WaitDialog(String illiustration,String text){
    this.illiustration = illiustration;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(illiustration,
              width: MediaQuery.of(context).size.width/1.3,
              height: MediaQuery.of(context).size.width/1.3, fit:BoxFit.fill),
          Container( padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/6),
            child:Text(text, style: Montserrat(style: SemiBold,size: 18,color:Blue)),
          )
        ]);
  }
}

class Placholder extends StatelessWidget {

  double? width;
  double? heigth;

  Placholder(double width,double heigth){
    this.width = width;
    this.heigth = heigth;
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.transparent.withOpacity(0.1),
        highlightColor: White,
        child: Container(width: double.infinity,height: this.heigth,
            color: White, alignment: Alignment.center,
            child: Container(width: this.width,height: this.heigth)
        )
    );
  }
}