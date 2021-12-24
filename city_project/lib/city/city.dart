import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'functionCity.dart';
import '../excursion/excursion.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';

class City extends StatefulWidget
{
  final int? IndexCity;
  const City({Key? key, @required this.IndexCity}) : super(key: key);


  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  int _selectType = 1;
  int _selectSort = 1;
  int _filter = 1;
  bool _statusReverse = false;
  List<bool> iconFav = [];

  @override
  Widget build(BuildContext context)
  {
    double heigthBar = MediaQuery.of(context).size.height/6;
    return Scaffold(backgroundColor: LigthGreen,
        ///МЕНЮ
        drawer: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black.withOpacity(0.9),),
            child:Menu(context)
        ),


        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(heigthBar),
            child: AppBar(flexibleSpace: Image(image: AssetImage(dataCity[widget.IndexCity ?? 0][1]),
                fit: BoxFit.cover),
                centerTitle: false,
                titleSpacing: 0.0,
                bottom: PreferredSize(child:Stack(children: [
                  Container(width: double.infinity,
                      height: heigthBar/2,
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.7))
                  ),

                  Container(height: heigthBar/2,
                      padding: EdgeInsets.only(left: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(dataCity[widget.IndexCity ?? 0][0].toString().toUpperCase(),style: Montserrat(style:SemiBold, size: 25)),
                            Text('+22',style: Montserrat(style:SemiBold, size: 25)),
                            IconButton(onPressed:(){},
                                icon: iconHandbook
                            )
                          ]
                      )
                  )
                ]),
                  preferredSize: Size.fromHeight(50),)
            )
        ),

        ///ТЕЛО
        body: ListView(padding: EdgeInsets.zero,
                children: [

                  Container(margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///ТИПЫ
                        Stack(children: [
                          Shadow(45,10,MediaQuery.of(context).size.width/2+80),
                          Center(
                              child: Container (width: MediaQuery.of(context).size.width/2+80, height: 45,
                                decoration: BoxDecoration(color:Green,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownButton(
                                  underline: Container(),
                                  icon: iconArrowBottom,
                                  dropdownColor: Green,
                                  isExpanded: true,
                                  value: _selectType,
                                  items: LabelType(),
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectType = value!;
                                      _statusReverse = false;
                                    });
                                  },
                                  style: Montserrat(color: White,size: 17,style: SemiBold),
                                ),
                              )
                          ),
                        ],),

                        ///КНОПКА РЕВЕРС
                        Container(
                            child: IconButton(onPressed:(){
                              setState(() {
                                _statusReverse = !_statusReverse;
                              });
                            },
                                icon: iconReverse
                            )
                        )
                      ]
                    )
                  ),
                  Container(margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///ФИЛЬТР
                          Container(
                              child: Stack(children: [
                                Center(child:Shadow(45,10,MediaQuery.of(context).size.width/2-40)),
                                Center(
                                    child: Container (width: MediaQuery.of(context).size.width/2-40,height: 45,
                                      decoration: BoxDecoration(color:LigthGrey,
                                          borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: DropdownButton(
                                        underline: Container(),
                                        dropdownColor: White,
                                        icon: iconArrowBottom,
                                        isExpanded: true,
                                        hint: Text(textShow,style: Montserrat(color: Colors.black,size: 15)),
                                        items: Filter(_selectType),
                                        onChanged: (int? value) {
                                          setState(() {
                                            _filter = value!;
                                          });
                                        },
                                        style: Montserrat(color: Colors.black,size: 15),
                                      ),
                                    )
                                ),
                              ],)
                          ),

                          ///СОРТИРОВКА
                          Stack(children: [
                            Shadow(45,10,MediaQuery.of(context).size.width/2-40),
                            Center(
                                child: Container (width: MediaQuery.of(context).size.width/2-40,height: 45,
                                  decoration: BoxDecoration(color:LigthGrey,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: DropdownButton(
                                    underline: Container(),
                                    dropdownColor: White,
                                    icon: iconArrowBottom,
                                    isExpanded: true,
                                    hint: Text(textSorting,style: Montserrat(color: Colors.black,size: 15)),
                                    items: LabelSort(_selectType),
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectSort = value!;
                                      });
                                    },
                                    style: Montserrat(color: Colors.black,size: 15),
                                  ),
                                )
                            ),
                          ],),
                        ]
                    )
                  ),

                  ///КОНТЕНТ
                  Container(margin: EdgeInsets.only(bottom: 30),
                    child: Content(_statusReverse),
                  )

                ])
    );
  }

  ///ВОЗВРАЩАЕТ КОНТЕНТ
  Widget Content(bool reverse)
  {
    List function = [Entertainment(reverse),Affiche(reverse), News(reverse)];
    for(int i = 0; i < function.length;i++)
      {
        if(_selectType == i+1)
          {
            return function[i];
          }
      }
    return Container();
  }

  ///ЭКСКУРСИИ
  Widget Entertainment([bool reverse = false])
  {
    List data = [];
    List ids = [];
    for(int i = 0; i < dataExcursion.length; i++)
    {
      if(dataExcursion[i][9] == widget.IndexCity)
      {
        data.add(dataExcursion[i]);
        ids.add(i);
      }
    }

    if(data.length > 0)
    {
      List entertainmentInfo = [];
      List id =[];
      if(reverse == true)
      {
        entertainmentInfo = new List.from(data.reversed);
        id = new List.from(ids.reversed);
        setState(() {
          iconFav = new List.from(iconFav.reversed);;
        });
      }
      else
      {
        entertainmentInfo = data;
        id = ids;
      }

      List<Widget> entertainmentWidgets = [];
      for(int i = 0; i<data.length; i++)
      {
        bool fav = false;
        for(int j = 0; j < dataFavorite.length; j++)
        {
          if(auth == dataFavorite[j][0])
            {
              if(id[i] == dataFavorite[j][1])
                {
                  fav = true;
                }
            }
        }

        setState(() {
          iconFav.add(fav);
        });

        entertainmentWidgets.add(Container(margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: TextButton(onPressed:()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Excursion(IndexExcursion: id[i]),));///передаем index экскурсии
          },
            child: Column(
                children: [
                  Stack(alignment: Alignment.topRight,
                    children: [
                      Stack(alignment: AlignmentDirectional.bottomStart,
                        children: [
                          //КАРТИНКА
                          ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              child: Image.asset(entertainmentInfo[i][1], fit: BoxFit.cover,width: double.infinity,
                                height: 150,)
                          ),
                          Container(width: 300,
                              margin: EdgeInsets.only(left: 10,bottom: 10),
                              child: Text(entertainmentInfo[i][0],style: Montserrat(size: 20, style: SemiBold,color: White))
                          ),
                        ],
                      ),

                      ///ДОБАВЛЕНИЕ В ИЗБРАННОЕ
                      IconButton(icon: iconFav[i] == true ?  iconFavoriteRed:iconFavoriteWhite,
                          onPressed:(){
                            if(iconFav[i] == true)
                            {
                              int ind = -1;
                              for(int j = 0; j < dataFavorite.length; j++)
                                {
                                  if(auth == dataFavorite[j][0])
                                    {
                                      if(dataFavorite[j][1] == i)
                                        {
                                          ind = j;
                                        }
                                    }
                                }
                              if(ind != -1)
                                {
                                  dataFavorite.removeAt(ind);
                                }
                            }
                            else
                              {
                                dataFavorite.add([auth,i]);
                              }
                            setState(() {
                              iconFav[i] = !iconFav[i];
                            });
                          }
                      ),
                    ],
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

                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(textPlacesLeft(entertainmentInfo[i][7].toString()),style: Montserrat(size: 15,style: SemiBold, color: Colors.black)),
                                  Text(textPerPerson(entertainmentInfo[i][8].toString()),style: Montserrat(size: 13, color: Colors.black)),
                                ]
                            ),
                            Row(children: [
                              Container(margin: EdgeInsets.only(right: 10),
                                  child:iconDate
                              ),
                              Text(entertainmentInfo[i][2],style: Montserrat(size: 15, style: SemiBold,color: Colors.black)),
                            ])
                          ],
                        )

                      ])
                ]
            ),),
        ));
      }
      return Column(children: entertainmentWidgets,);
    }
    else
    {
      return Column(children: [Container(margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child:Text(textDontMero,style: Montserrat(color: Colors.black)))]
      );
    }
  }

}