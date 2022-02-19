import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'finally.dart';
import 'text.dart';


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


///ОШИБКА СЕТИ
Widget ErrorNet(context,Size SizePage) {
  return Column(children: [
    Image.asset(iErrorNet, width: SizePage.width/1.3, height: SizePage.width/1.3, fit:BoxFit.fill),
    Container( padding: EdgeInsets.symmetric(horizontal: SizePage.width/12),
      child:Text(textErrorNet, style: Montserrat(style: SemiBold,size: 16,color:Blue)),
    ),
    TextButton(onPressed: (){},
      child: Text(textRepeat.toUpperCase(), style: Montserrat(style: Bold,size: 16,color:Red)),)
  ]);
}

///ЗАГРУЗКА
Widget Loading(Size SizePage) {
  return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(iLoading, width: SizePage.width/1.3, height: SizePage.width/1.3, fit:BoxFit.fill),
        Container( padding: EdgeInsets.symmetric(horizontal: SizePage.width/6),
          child:Text(textLoading, style: Montserrat(style: SemiBold,size: 18,color:Blue)),
        )
      ]);
}
