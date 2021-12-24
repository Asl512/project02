import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';

dynamic StyleTextField(String hint, List error,[Widget? suffixIcon])
{
  return InputDecoration(
    //ПОДСКАЗКА
      hintText: hint,
      hintStyle: Montserrat(color:LigthGrey,size: 15),
      suffixIcon: suffixIcon,

      //ВЫВОД ОШИБКИ
      errorText: error[0] == true ? error[1] : null,
      errorStyle: Montserrat(style:Medium,color: Red,size: 15),

      //СТИЛЬ
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(500),
          borderSide: BorderSide(width: 0, style: error[0] == true ? BorderStyle.solid : BorderStyle.none)
      ),
      fillColor: Green,
      isDense: true,
      filled: true
  );
}


Widget TitleText(String text)
{
  return Container(margin: EdgeInsets.only(bottom: 15),
      child: RichText(textAlign: TextAlign.start,
          text: TextSpan(children: [
            TextSpan(text:text,style: Montserrat(color: Black,style:SemiBold)),
            TextSpan(text:' *',style: Montserrat(style:SemiBold,color: Red))
          ])
      )
  );
}

Widget Selectd(List error, String textSelect,Widget widget,[Widget? icon])
{
  if(icon == null)
    {
      icon = Container();
    }
  return Container(height: 120,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(textSelect),
                  icon
                ]
            ),
            Stack(children: [
              Shadow(50,500),
              Container (height: 50,
                  decoration: BoxDecoration(color:Green,
                      border: Border.all(color: error[0]?Red:Green),
                      borderRadius: BorderRadius.circular(500)),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: widget
              ),
            ]),
            Container(margin: EdgeInsets.only(top: 10,left: 15),
                child: Text(error[0]?error[1]:'',style: Montserrat(size: 15,color:Red))
            )
          ])
  );
}
List selectDataCity()
{
  List city = [];
  for(int i = 0; i < dataCity.length; i++)
  {
    city.add(dataCity[i].first);
  }
  return city;
}


