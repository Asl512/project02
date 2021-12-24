import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../city/functionCity.dart';
import '../../excursion/excursion.dart';

import '../../assets/style.dart';
import '../../assets/finally.dart';
import '../../assets/text.dart';
import '../../assets/data.dart';

class ExcursionMy extends StatefulWidget
{
  const ExcursionMy({Key? key}) : super(key: key);


  @override
  State<ExcursionMy> createState() => _ExcursionMyState();
}

class _ExcursionMyState extends State<ExcursionMy> {
  int _selectSort = 1;
  int _filter = 1;

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


        appBar: PreferredSize(preferredSize: Size.fromHeight(heigthBar),
            child: AppBar(flexibleSpace: Image(image: AssetImage(imgBackCity),
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
                    alignment: Alignment.center,
                    child: Text(textMyExcursion.toUpperCase(),style: Montserrat(style:SemiBold,size: 18)),
                  )
                ]),
                  preferredSize: Size.fromHeight(50),)
            )
        ),

        ///ТЕЛО
        body: ListView(padding: EdgeInsets.zero,
                children: [

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
                                        items: Filter(1),
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
                                    items: LabelSort(1),
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
                    child: Entertainment(),
                  )

                ])
    );
  }

  ///ЭКСКУРСИИ
  Widget Entertainment()
  {
    List entertainmentInfo = [];
    List id = [];
    for(int i = 0; i < dataExcursion.length; i++)
    {
      if(dataExcursion[i][10] == auth)
      {
        entertainmentInfo.add(dataExcursion[i]);
        id.add(i);
      }
    }

    if(entertainmentInfo.length > 0)
    {

      List<Widget> entertainmentWidgets = [];
      for(int i = 0; i<entertainmentInfo.length; i++)
      {

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
                      IconButton(icon: iconFavoriteWhite,
                          onPressed:(){}
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
          child:Text(textDontMyMero,style: Montserrat(color: Colors.black)))]
      );
    }
  }

}