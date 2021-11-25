import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'finally.dart';

TextStyle Montserrat({FontWeight? style, Color? color, double? size})
{
  color ??= White;
  style ??= Medium;
  size ??= 18;

  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: 'Montserrat',
    fontWeight: style,
  );
}

Widget IconShowHide(bool passwordVisible)
{
  if(passwordVisible == true)
  {
    return iconShow;
  }
  else
    {
      return iconHide;
    }
}

///ТРЕУГОЛЬНИК (НА ВХОДЕ И РЕГИСТРАЦИИ)
class Triangle extends CustomClipper<Path>{
  int numb = 1;

  Triangle(int numb)
  {
    this.numb = numb;
  }

  @override
  Path getClip(Size size) {
    var points = [
      Offset(1, 0), // точка p1
      Offset(1, size.height), // точка p3
      Offset(size.width, size.height / 2) // точка p4
    ];

    if(numb == 2)
    {
      points = [
        Offset(1, 60), // точка p1
        Offset(1, size.height-60), // точка p3
        Offset(size.width/1.3, size.height / 2) // точка p4
      ];
    }

    Path path = Path()
      ..addPolygon(points, false)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

///ВОЙТИ ЧЕРЕЗ
Widget LoginHrough(text)
{
  return
    Container(
      child: Column(children: [
        Container(width: double.infinity,
          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Text(text, style: Montserrat(color:Blue)),
        ),

        Row(children: [
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
          ),
        ],mainAxisAlignment:MainAxisAlignment.spaceAround ,
        )
      ],),
    );
}
