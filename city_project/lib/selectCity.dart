import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'city.dart';

import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';

class SelectCity extends StatefulWidget
{
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {

  String _serchCity = '';

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
          child: AppBar(flexibleSpace: Image(image: AssetImage(imgBackCity),
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
                  child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(textNameApp,style: Montserrat(style:SemiBold,size: 18)),
                        Row(children: [
                          Container(margin: EdgeInsets.only(right: 7),
                              child:Text(textMotto1,style: Montserrat(style:SemiBold, size: 18))
                          ),
                          Text(textMotto2,style: Montserrat(style:SemiBold,color: Colors.yellow, size: 18)),
                        ])
                      ]
                  )
              )
            ])
          ),
        ),
        ///ТЕЛО
        body: ListView(padding: EdgeInsets.zero,
                children: [

              Stack(children: [

                ///ГОРОДА
                Container(margin: EdgeInsets.symmetric(vertical: 70),
                    child: Column(children: BlocksCity())
                ),

                SelectNameCity(),

                ///ПОИСК
                Container(padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(top: 30),
                    child: Stack(children: [
                      Shadow(38,15), // ТЕНЬ
                      ///Поисковая строка
                      Container(height: 40,
                          child:  TextField(style: Montserrat(color:Colors.black,size: 15),
                            decoration: InputDecoration(
                                hintText: textLabelSerch,

                                //СТИЛЬ
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(width: 0, style: BorderStyle.none)
                                ),
                                fillColor: LigthGrey,
                                isDense: true,
                                filled: true,

                                ///Кнопка поиска
                                suffixIcon: Container(width: 70,
                                    decoration: BoxDecoration(color: Green,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15))
                                    ),
                                    height: double.infinity,
                                    child: IconButton(
                                      icon: iconMagnifier,
                                      onPressed: () {},
                                    )
                                )
                            ),
                            onChanged: (String value)
                            {
                              setState(()
                              {
                                _serchCity = value;
                              });
                            },
                          )
                      )

                    ])
                )
              ])

            ])
    );
  }

  ///ВОЗВРАЩАЕТ СЛЕКТ НАЗВАНИЙ ГОРОДОВ
  Widget SelectNameCity()
  {
    List<Widget> city = [];

    //Плашка
    city.add(Container(width: double.infinity,height: 40,
        decoration: const BoxDecoration(color: White,
            borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
        )
    ));

    for(int i = 0; i < dataCity.length; i++)
      {
        city.add(Container(width: double.infinity,height: 40,
            decoration: const BoxDecoration(color: White,
              border: Border.symmetric(horizontal: BorderSide(color: Grey,width: 0.5))
            ),
            child: TextButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => City(IndexCity: i),));///передаем index города
            },
                child: Container(padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(dataCity[i][1], style: Montserrat(color: Colors.black,size: 15),))
                )
        ));
      }

    Widget s = Container(width: double.infinity,height: 40,
      decoration: const BoxDecoration(color: White,
        border: Border.symmetric(horizontal: BorderSide(color: Grey,width: 0.5)),
      ),
    );

    if(_serchCity != '')
    {
      return Container(margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Column(children: city));
    }
    else
    {
      return Container();
    }
  }


  ///ВОЗВРАЩАЕТ ГОРОДА
  List<Widget> BlocksCity()
  {
    List<Widget> city= [];
    for(int i = 0; i < dataCity.length; i++)
      {
        city.add(Container(margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: TextButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => City(IndexCity: i),));///передаем index города
          },
          child: Stack(alignment: AlignmentDirectional.bottomCenter,
              children: [
                //КАРТИНКА
                ClipRRect(borderRadius: BorderRadius.circular(40),
                    child: Image.asset(dataCity[i][0], fit: BoxFit.cover,
                      width: double.infinity, height: 200)
                ),
                //НАЗВАНИЕ
                Stack(alignment:Alignment.center,
                    children: [
                      Container(height: 60,width: double.infinity,
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40))
                          )
                      ),
                      Text(dataCity[i][1],style: Montserrat(size: 25,style: SemiBold)),
                    ])
              ]
          ),),
        ));
      }

    return city;
  }

}