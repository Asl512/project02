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

///МЕНЮ
Widget Menu(context)
{
  List<String> menuItems = [textWhere,textPersonalArea,textFavorites,textAbout,textEarn];
  List<String> urlItems = ['/selectCity','','','',''];
  List<Widget> widgetItems = [];

  for(int i = 0; i < menuItems.length; i++)
    {
      widgetItems.add(TextButton(onPressed: ()
      {
        Navigator.pushNamedAndRemoveUntil(context, urlItems[i], (route) => false);
      },
          child: Container(alignment: Alignment.centerLeft,
              width: double.infinity, height: 50,
              padding: EdgeInsets.only(left: 20),
              child:  Text(menuItems[i], style: Montserrat(size: 17,style: SemiBold))
          )
      ));
    }

  return Drawer(
    child: Container(margin: EdgeInsets.only(top: 70),
      child: Column(children: widgetItems)
    )
  );
}

///Виджет тени на текстовые блоки
Widget Shadow(double height, double radius,[double? width])
{
  return Container(height: height,width: width,
      decoration: BoxDecoration(color:LigthGreen,
        borderRadius: BorderRadius.circular(radius),
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
  return Container(margin: EdgeInsets.only(top: 15),
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

///нарисовать круг
Widget Circle(Color color, double radius)
{
  return Container(margin: EdgeInsets.symmetric(horizontal: 4),
    width: radius*2,
    height: radius*2,
    decoration: new BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}
