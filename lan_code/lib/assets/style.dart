import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'finally.dart';


///Функция для строк
TextStyle Montserrat({FontWeight style = Medium, Color color = White, double size = 18})
{
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: 'Montserrat',
    fontWeight: style,
  );
}

///Виджет тени на текстовые блоки
Widget Shadow(double height)
{
  return Container(height: height,
      decoration: BoxDecoration(color:LigthGreen,
        borderRadius: BorderRadius.circular(500),
        boxShadow:const [BoxShadow(color: Colors.grey,
          blurRadius: 5,
          spreadRadius: 0.5,
          offset: Offset(0, 3)
        )],
      )
  );
}

///Класс рисующий треугольники (НА ВХОДЕ И РЕГИСТРАЦИИ)
class Triangle extends CustomClipper<Path>
{
  int numb = 1;
  var points = [Offset(0, 0)];
  Triangle(int numb)
  {
    this.numb = numb;
  }

  @override
  Path getClip(Size size)
  {
    if(numb == 2)
    {
      points = [
        Offset(1, 60), // точка p1
        Offset(1, size.height-60), // точка p2
        Offset(size.width/1.3, size.height / 2)];// точка p3
    }
    else if(numb ==1)
    {
      points = [
        Offset(1, 0), // точка p1
        Offset(1, size.height), // точка p2
        Offset(size.width, size.height / 2)];// точка p3
    }

    Path path = Path()
      ..addPolygon(points, false)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

///Виджет ВОЙТИ ЧЕРЕЗ
Widget LoginHrough(text)
{
  return Container(
    child: Column(children:[
      Container(width: double.infinity,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
        child: Text(text, style: Montserrat(color:Blue)),
      ),

      Row(mainAxisAlignment:MainAxisAlignment.spaceAround ,
        children:[
          IconButton(icon: iconGoogle, iconSize: 50,
            onPressed: (){},
          ),
          IconButton(icon: iconVK,iconSize: 50,
            onPressed: (){},
          ),
          IconButton(icon: iconOkRu,iconSize: 50,
            onPressed: (){},
          ),
          IconButton(icon: iconFacebook,iconSize: 50,
            onPressed: (){},
          ),
          IconButton(icon: iconTwitter,iconSize: 50,
            onPressed: (){},
          )
        ]
      )
    ])
  );
}
