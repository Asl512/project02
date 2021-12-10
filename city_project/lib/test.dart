import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';

class Test extends StatefulWidget
{
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  String _serch = '';

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(top: 200),
          child:
          Stack(children: [
            ///Поисковая строка
            TextField(style: Montserrat(color:Blue),
                decoration: InputDecoration(

                  //СТИЛЬ
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none)
                  ),
                  fillColor: White,
                  isDense: true,
                  filled: true,

                  suffixIcon: Container(decoration: BoxDecoration(color: Green,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(500),bottomRight: Radius.circular(500))),
                      height: 50,
                      child: IconButton(
                        icon: iconMagnifier,
                        onPressed: () {},
                      )
                  ),
                )
            ),

          ])
      ),
    );
  }

  Widget City()
  {
    if(_serch != '')
      {
        return Text('ddd');
      }
    else
      {
        return Container();
      }
  }

}
