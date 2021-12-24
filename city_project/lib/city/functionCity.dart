import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';

///ВОЗВРАЩАЕТ ТИПЫ
List<DropdownMenuItem<int>> LabelType()
{
  List<DropdownMenuItem<int>> typesWidgets = [];
  for(int i = 0; i < typesName.length;i++)
  {
    typesWidgets.add(DropdownMenuItem(
        child: Text(typesName[i]),
        value: i+1
    ));
  }
  return typesWidgets;
}

///ВОЗВРАЩАЕТ СОРТИРОВКИ
List<DropdownMenuItem<int>> LabelSort(int _selectType)
{
  List<String> entertainment = ['По цене','По дате','По названию'];
  List<String> affiche = ['По цене','По дате','По названию'];
  List<String> news = ['По дате','По заголовку'];

  List sort = [entertainment, affiche, news];

  List<DropdownMenuItem<int>> sortWidgets = [];
  for(int i = 0; i < sort.length;i++)
  {
    if(_selectType == i+1)
    {
      for(int j = 0; j < sort[i].length;j++)
      {
        sortWidgets.add(DropdownMenuItem(
            child: Text(sort[i][j]),
            value: j+1
        ));
      }
    }
  }
  return sortWidgets;
}

///ВОЗВРАЩАЕТ ФИЛЬТР
List<DropdownMenuItem<int>> Filter(int _selectType)
{
  var entertainment = dataTypeExcurs;
  List<String> affiche = ['Кино','Театры', 'Мероприятия'];
  List<String> news = ['Важные','Сегодня'];

  List filters = [entertainment, affiche, news];

  List<DropdownMenuItem<int>> filtersWidgets = [];
  filtersWidgets.add(DropdownMenuItem(
      child: Text('Все'),
      value: 1
  ));

  for(int i = 0; i < filters.length;i++)
  {
    if(_selectType == i+1)
    {
      for(int j = 0; j < filters[i].length;j++)
      {
        filtersWidgets.add(DropdownMenuItem(
            child: Text(filters[i][j].toString()),
            value: j+2
        ));
      }
    }
  }
  return filtersWidgets;
}

///Афиша
Widget Affiche(context,[bool reverse = false])
{
  List data = [['image/1city.png','RockCellos: Мировые рок-хиты на','06 НОЯБ','СБ 19:00','ДК "Железнодорожное"','1 600 — 3 000','https://www.google.com'],
                      ['image/2city.png','RockCellos: Мировые рок-хиты на','06 НОЯБ','СБ 19:00','ДК "Нефтяник"','1 600 — 3 000','https://www.google.com'],
                      ['image/3city.png','RockCellos: Мировые рок-хиты на','06 НОЯБ','СБ 19:00','ДК "Нефтяник"','1 600 — 3 000','https://www.google.com'],
                      ['image/1city.png','RockCellos: Мировые рок-хиты на','06 НОЯБ','СБ 19:00','ДК "Нефтяник"','1 600 — 3 000','https://www.google.com'],
                      ['image/2city.png','RockCellos: Мировые рок-хиты на','06 НОЯБ','СБ 19:00','ДК "Нефтяник"','1 600 — 3 000','https://www.google.com'],
  ];

  List afficheInfo = [];
  if(reverse == true)
    {
      afficheInfo = new List.from(data.reversed);
    }
  else
    {
      afficheInfo = data;
    }


  List<Widget> entertainmentWidgets = [];
  for(int i = 0; i<afficheInfo.length; i++)
  {
    entertainmentWidgets.add(TextButton(onPressed:() {launch(afficheInfo[i][6]);},
        child: Column(
            children: [

              //КАРТИНКА
              ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(afficheInfo[i][0], fit: BoxFit.cover,width: 170,
                    height: 150,)
              ),

              //ОПИСАНИЕ
              Stack(children: [
                Shadow(110,15,170),
                Container(height: 110,width: 170,
                    padding: EdgeInsets.only(left: 5,right: 10,top: 5),
                    decoration: BoxDecoration(color: LigthGrey,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))
                    ),
                  child: Column(
                    children: [
                      Text(afficheInfo[i][1],style: Montserrat(size: 12,color: Colors.black)),
                      Container(margin: EdgeInsets.only(top: 5),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(afficheInfo[i][2],style: Montserrat(size: 12, style: SemiBold, color: Colors.black)),
                              Text(afficheInfo[i][3],style: Montserrat(size: 12,style: SemiBold, color: Grey)),
                            ]
                        )
                      ),
                      Container(margin: EdgeInsets.only(top: 5),
                          child: Row(children: [
                                Container(child: iconLocation,margin: EdgeInsets.only(right: 10)),
                                Flexible(child: Container(
                                    child: Text(afficheInfo[i][4], overflow: TextOverflow.ellipsis,
                                        style: Montserrat(size: 12, color: Colors.black)),
                                ))
                              ])
                      ),
                      Container(margin: EdgeInsets.only(top: 5),
                          child: Row(children: [
                                Container(child: iconRuble,margin: EdgeInsets.only(right: 10)),
                                Text(afficheInfo[i][5],style: Montserrat(size: 12, style: SemiBold, color: Colors.black)),
                          ])
                      )
                    ],
                  ),
                )
              ])
            ]
        ),
    ));
  }

  ///для разделение на 2 колонки
  List<Widget> result = [];
  bool even = false;
  for(int i = 0; i < entertainmentWidgets.length; i++)
    {
      if(even == false)
        {
          if(i+1 == entertainmentWidgets.length)
            {
              result.add(Container(margin: EdgeInsets.only(top: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [entertainmentWidgets[i]]
                )
              ));
            }
          else
            {
              result.add(Container(margin: EdgeInsets.only(top: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [entertainmentWidgets[i],entertainmentWidgets[i+1]]
                  )
              ));
            }
        }
      even = !even;
    }


  return Column(children: result);
}

///Новости
Widget News([bool reverse = false])
{
  List<List<String>> data = [['image/2city.png','Директора шахматного клуба, подозреваемого в изнасиловании ученицы в Тюмени, оставили под стражей','https://www.google.com'],
    ['image/1city.png','Свежесть местного производства: как производят колбасные изделия и полуфабрикаты, которые ест вся Тюмень','https://www.google.com'],
    ['image/3city.png','Отец жестоко убитой в Тюмени Насти Муравьевой борется за право воспитывать ее брата и сестру','https://www.google.com'],
  ];

  List newsInfo = [];
  if(reverse == true)
  {
    newsInfo = new List.from(data.reversed);
  }
  else
  {
    newsInfo = data;
  }

  List<Widget> newsWidgets = [];
  for(int i = 0; i<newsInfo.length; i++)
  {
    newsWidgets.add(Container(margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: TextButton(onPressed:(){launch(newsInfo[i][2]);},
        child: Column(
            children: [
              //КАРТИНКА
              ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(newsInfo[i][0], fit: BoxFit.cover,width: double.infinity,
                    height: 100,)
              ),

              //ОПИСАНИЕ
              Stack(alignment:Alignment.center,
                  children: [
                    Stack(children: [
                      Shadow(70,20),
                      Container(height: 70,width: double.infinity,
                          decoration: BoxDecoration(color: LigthGrey,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                          )
                      )
                    ]),

                    Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),height: 70,
                      child:Text(newsInfo[i][1],style: Montserrat(size: 15,color: Colors.black)),
                    )

                  ])
            ]
        ),),
    ));
  }
  return Column(children: newsWidgets,);
}
