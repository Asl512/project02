import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';

class City extends StatefulWidget
{
  const City({Key? key}) : super(key: key);

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  int indexCity = -1;
  static int? idCity;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idCity = prefs.getInt('city') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;
    getStringValuesSF();

    return Scaffold(backgroundColor: Grey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/5),
          ///ШАПКА
          child: AppBar(flexibleSpace: Stack(children: [
            Image.network('https://upload.wikimedia.org/wikipedia/commons/2/20/Tokyo_Tower_and_Tokyo_Sky_Tree_2011_January.jpg',
                fit: BoxFit.cover,
                width: double.infinity
            ),
            Container(width: double.infinity, height: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5))
            ),
            Container(alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(idCity.toString().toUpperCase(),style: Montserrat(color:White,size: 35,style: SemiBold)),),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, '/serch');
                    },
                        child:Container(
                          padding: EdgeInsets.all(12),
                          width: 50, height: 50,
                          decoration: BoxDecoration(color: Blue,borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: iconMagnifier,
                        ))
                  ],
                )
            )
          ]),
            centerTitle: false,
            titleSpacing: 0.0,
            bottom: TabBar(
              controller: _tabController,
              tabs:[
                Tab(
                    child: Text('Все',style: Montserrat(color:White,size: 15))
                ),
                Tab(
                    child: Text('Групповые',style: Montserrat(color:White,size: 15))
                ),
                Tab(
                    child: Text('Индивидуальные',style: Montserrat(color:White,size: 15))
                ),
                Tab(
                    child: Text('Индивидуальные',style: Montserrat(color:White,size: 15))
                ),
              ],isScrollable: true,
              indicatorColor: White,
            ),
          )
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[

          ListView(padding: EdgeInsets.zero,
              children: [
                Container(margin: EdgeInsets.symmetric(vertical: 20),
                    child: Entertainment()
                )
              ]),


          ListView(padding: EdgeInsets.zero,
              children: [
                Container(margin: EdgeInsets.symmetric(vertical: 20),
                    child: Entertainment()
                )
              ]),


          ListView(padding: EdgeInsets.zero,
              children: [
                Container(margin: EdgeInsets.symmetric(vertical: 20),
                    child: Entertainment()
                )
              ]),


          ListView(padding: EdgeInsets.zero,
              children: [
                Container(margin: EdgeInsets.symmetric(vertical: 20),
                    child: Entertainment()
                )
              ]),


        ],
      ),
    );
  }

  ///ЭКСКУРСИИ
  Widget Entertainment()
  {
    List data = [];
    List ids = [];
    for(int i = 0; i < dataExcursion.length; i++)
    {
      if(dataExcursion[i][9] == 0)
      {
        data.add(dataExcursion[i]);
        ids.add(i);
      }
    }

    if(data.length > 0)
    {
      List entertainmentInfo = data;
      List id = ids;

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

        entertainmentWidgets.add(Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/60),
          child: TextButton(onPressed:()
          {
            ///Navigator.push(context, MaterialPageRoute(builder: (context) => Excursion(IndexExcursion: id[i]),));///передаем index экскурсии
          },
            child: Column(
                children: [
                  Stack(alignment: Alignment.topRight,
                    children: [
                      Stack(alignment: AlignmentDirectional.bottomStart,
                        children: [
                          //КАРТИНКА
                          ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              child: Image.network('https://firebasestorage.googleapis.com/v0/b/dbapp-28831.appspot.com/o/city%2Fмосква.jpg?alt=media&token=2e8ebb29-1528-41ac-a38f-1cc0664daf72',
                                fit: BoxFit.cover,
                                width: double.infinity, height: 120,
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Image.asset(excursionDef,
                                      fit: BoxFit.cover,
                                      width: double.infinity, height: 120);
                                },
                              ),
                          ),

                          Container(height: 50,
                              width: entertainmentInfo[i][0].toString().length.toDouble()*14 +50 >= MediaQuery.of(context).size.width/1.4 ? MediaQuery.of(context).size.width/1.4 : entertainmentInfo[i][0].toString().length.toDouble()*14 + 50,
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30)))
                          ),
                          Container(width: MediaQuery.of(context).size.width/1.4,
                              height: 50,
                              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //АВАТАР
                                  Container(padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Stack(children: [
                                        ClipRRect(borderRadius: BorderRadius.all(Radius.circular(500)),
                                          child: Image.network('https://klike.net/uploads/posts/2019-05/1556708032_1.jpg',
                                            fit: BoxFit.cover,
                                            width: 40, height: 40,
                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Image.asset(avatarDef,
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context).size.width/10, height: MediaQuery.of(context).size.width/10
                                              );
                                            },
                                          ),
                                        ),

                                        ///ДОБАВИТЬ ПРОВЕРКУ ПОЛЬЗОВАТЕЛЯ
                                        Container(width: 40,height: 40,
                                          alignment: Alignment.bottomRight,
                                          child: Container(width: 15,height: 15,
                                              child: iconConfirmation))
                                      ])),

                                  Flexible(child: Text(entertainmentInfo[i][0],style: Montserrat(size: 15,style: SemiBold)))
                                ],
                              )
                          )

                        ],
                      ),

                      ///ДОБАВЛЕНИЕ В ИЗБРАННОЕ
                      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/50,right: MediaQuery.of(context).size.width/50),
                        child: IconButton(icon: iconFavoriteWhite,
                            onPressed:(){}
                        ),
                      )
                    ],
                  ),

                  //ОПИСАНИЕ
                  Stack(alignment:Alignment.center,
                      children: [
                        Stack(children: [
                          Shadow(68,20),
                          Container(height: 68,width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: White,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
                              )
                          )
                        ]),

                        Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          height: 68,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                width: MediaQuery.of(context).size.width/1.5,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                          Text('Индивидуальная',style: Montserrat(size: 17,style: SemiBold, color: Color(0xFF55596A))),
                                          ///МОЛНИЯ, СДЕЛАТЬ ПРОВРКУ
                                          Container(width: 17,height: 17,
                                            margin: EdgeInsets.only(left: 5),
                                            child: iconLightning,)
                                      ]),
                                      Flexible(child: Text('Описание путешествия по Золотому Рогу и Босфору Описание путешествия по Золотому Рогу и Босфору',style: Montserrat(size: 14, color: Blue)),)
                                    ]
                                ),
                              ),

                              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('2 ' + 'часа',style: Montserrat(size: 13, style: Regular,color: Blue)),
                                    Text('₽ '+'99000',style: Montserrat(size: 16, style: Bold,color: Blue)),
                                  ]
                              )
                            ],
                          ),
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