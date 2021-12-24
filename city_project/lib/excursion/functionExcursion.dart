import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../excursionsPeaple.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';


///ИНФОРМАЦИЯ
Widget Information(context,int index)
{
  List<String> titleInformation = ['Тип мероприятия: ','Дата мероприятия: ','Время начала: ','Время окончания: ','Место встречи: ',
    'Языки мероприятия: ','Количество мест: ','Оставшиеся места: ','Цена за человека: ','Тип передвижения: '];

  List user = [];
  int idUser = -1;
  for(int i = 0; i<dataUser.length; i++)
    {
      if(dataExcursion[index][10] == i)
        {
          user = dataUser[i];
          idUser = i;
        }
    }

  List lang = [];
  for(int i = 0; i<dataLangExcurs.length; i++)
    {
      if(dataLangExcurs[i][0] == index)
        {
          lang.add(dataLanguages[dataLangExcurs[i][1]]);
        }
    }

  List move = [];
  for(int i = 0; i<dataMoveExcurs.length; i++)
  {
    if(dataMoveExcurs[i][0] == index)
    {
      move.add(dataMovement[dataMoveExcurs[i][1]]);
    }
  }

  List data = [dataTypeExcurs[dataExcursion[index][11]], dataExcursion[index][2],dataExcursion[index][3],dataExcursion[index][4],dataExcursion[index][5],
    lang.join(', '), dataExcursion[index][6], dataExcursion[index][7], dataExcursion[index][8].toString() + ' рублей', move.join(', ')];

  List<Widget> texts = [];
  texts.add(Container(margin: EdgeInsets.only(bottom: 15),
      child:TextButton(onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ExcursionPeaple(IndexUser: idUser),));///передаем index юзера
      },
      child: Row(children: [
          Container(margin: EdgeInsets.only(right: 20),
            child: ClipRRect(borderRadius: BorderRadius.circular(500),
                child: Image.asset(user[3], fit: BoxFit.cover,
                  width: 60, height: 60,)
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user[0],style:Montserrat(color: Black,style: SemiBold)),
              Text('Экскурсовод',style:Montserrat(color: Black,size: 16))
            ],)
        ],),
      ))
  );
  for(int i = 0; i < titleInformation.length; i++)
    {
      texts.add(Container(margin: EdgeInsets.only(bottom:20),
          alignment: Alignment.topLeft,
          child: RichText(textAlign: TextAlign.start,
              text: TextSpan(children: [
                TextSpan(text:titleInformation[i],style: Montserrat(color: Colors.black,style: SemiBold)),
                TextSpan(text:data[i].toString(),style: Montserrat(color: Colors.black))
              ])
          )
      ));
    }

  return Container(padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: texts)
  );
}


///ОПИСАНИЕ
Widget Description(int index)
{
  String description = dataExcursion[index][12];
  if(description == '')
    {
      return Container(padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text('Автор не добавил описание, пока что',style: Montserrat(color: Black)),
      );
    }
  else
    {
      return Container(padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Что вас ожидает',style: Montserrat(color: Black,style: SemiBold)),
                Text(description,style: Montserrat(color: Black))
              ]
          )
      );
    }
}


///ФОТОГРАФИИ
Widget Images(int index)
{
  List data = [];
  for(int i = 0; i < dataImageExcurs.length; i++)
    {
      if(index == dataImageExcurs[i][0])
        {
          data.add([dataImageExcurs[i][1],dataImageExcurs[i][2]]);
        }
    }

  List<Widget> images = [];
  if(data.length > 0)
    {
      for(int i = 0; i < data.length; i++)
      {
        images.add(Container(margin: EdgeInsets.only(bottom: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(10),
                    child: Image.asset(data[i][0], fit: BoxFit.cover,
                    )
                ),
                Container(margin: EdgeInsets.only(top: 20),
                    child: Text(data[i][1],style: Montserrat(color: Black,style: SemiBold))
                )
              ],)
        ));
      }
    }
  else
    {
      images.add(Container(margin: EdgeInsets.only(bottom: 30),
          child: Text(textDontImages,style: Montserrat(color: Colors.black)))
      );
    }

  return Container(padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: images
      )
  );
}


///ОТЗЫВЫ
Widget Reviews(int index)
{
  List data = [];
  for(int i = 0; i < dataReviews.length; i++)
    {
      if(index == dataReviews[i][0])
        {
          data.add([dataUser[dataReviews[i][1]][0],dataUser[dataReviews[i][1]][3],dataReviews[i][2]]);
        }
    }


  List<Widget> reviews = [];
  if(data.length > 0)
    {
      for(int i = 0; i < data.length; i++)
      {
        reviews.add(Container(margin: EdgeInsets.only(bottom: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(margin: EdgeInsets.only(right: 20),
                    child: ClipRRect(borderRadius: BorderRadius.circular(500),
                        child: Image.asset(data[i][1], fit: BoxFit.cover,
                          width: 60, height: 60,)
                    ),
                  ),
                  Text(data[i][0],style:Montserrat(color: Black, style: SemiBold)),
                ]),
                Container(margin: EdgeInsets.only(top: 10),
                    child: Text(data[i][2],style:Montserrat(color: Black,size: 15))
                )
              ],)
        ));
      }
    }
  else
    {
      reviews.add(Container(margin: EdgeInsets.only(bottom: 30),
          child: Text(textDontReview,style: Montserrat(color: Colors.black)))
      );
    }


  return Container(padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: reviews
      )
  );
}

///ВОЗВРАЩАЕТ ТИПЫ
List<DropdownMenuItem<int>> LabelType()
{
  List<String> nameSelect = ['Информация','Описание','Фотографии','Отзывы'];
  List<DropdownMenuItem<int>> typesWidgets = [];
  for(int i = 0; i < nameSelect.length;i++)
  {
    typesWidgets.add(DropdownMenuItem(
        child: Text(nameSelect[i]),
        value: i+1
    ));
  }
  return typesWidgets;
}
