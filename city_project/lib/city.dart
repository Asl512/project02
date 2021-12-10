import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'functionCity.dart';

import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';

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

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: LigthGreen,
        ///МЕНЮ
        drawer: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.black.withOpacity(0.9),),
            child:Menu(context)
        ),

        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(70),
          child: AppBar(flexibleSpace: Image(image: AssetImage(dataCity[widget.IndexCity ?? 0][0]),
              fit: BoxFit.cover),
              centerTitle: false,
              titleSpacing: 0.0,
            title: Stack(children: [
              Container(width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.7))
              ),

              Container(height: 70,
                  padding: EdgeInsets.only(left: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(dataCity[widget.IndexCity ?? 0][1],style: Montserrat(style:SemiBold, size: 20)),
                        Text('+22',style: Montserrat(style:SemiBold, size: 20)),
                        IconButton(onPressed:(){},
                            icon: iconHandbook
                        )
                      ]
                  )
              )
            ])
          ),
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
                          Shadow(45,10,300),
                          Center(
                              child: Container (width: 300, height: 45,
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
                                Center(child:Shadow(45,10,160)),
                                Center(
                                    child: Container (width: 160,height: 45,
                                      decoration: BoxDecoration(color:LigthGrey,
                                          borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: DropdownButton(
                                        underline: Container(),
                                        dropdownColor: White,
                                        icon: iconArrowBottom,
                                        isExpanded: true,
                                        hint: Text(textShow,style: Montserrat(color: Colors.black,size: 15)),
                                        items: Filter(),
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
                            Shadow(45,10,160),
                            Center(
                                child: Container (width: 160,height: 45,
                                  decoration: BoxDecoration(color:LigthGrey,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: DropdownButton(
                                    underline: Container(),
                                    dropdownColor: White,
                                    icon: iconArrowBottom,
                                    isExpanded: true,
                                    hint: Text(textSorting,style: Montserrat(color: Colors.black,size: 15)),
                                    items: LabelSort(),
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

  ///ВОЗВРАЩАЕТ ТИПЫ
  List<DropdownMenuItem<int>> LabelType()
  {
    List<String> typesName= ['Развлечения','Афиша','Новости'];
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
  List<DropdownMenuItem<int>> LabelSort()
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
  List<DropdownMenuItem<int>> Filter()
  {
    List<String> entertainment = ['Все','Экскурсии','Джипинг','Туры'];
    List<String> affiche = ['Все','Кино','Театры', 'Мероприятия'];
    List<String> news = ['Все','Важные','Сегодня'];

    List filters = [entertainment, affiche, news];

    List<DropdownMenuItem<int>> filtersWidgets = [];
    for(int i = 0; i < filters.length;i++)
    {
      if(_selectType == i+1)
        {
          for(int j = 0; j < filters[i].length;j++)
          {
            filtersWidgets.add(DropdownMenuItem(
                child: Text(filters[i][j]),
                value: j+1
            ));
          }
        }
    }
    return filtersWidgets;
  }


}