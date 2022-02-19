import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';

import 'package:postgres/postgres.dart';


class Serch extends StatefulWidget
{
  const Serch({Key? key}) : super(key: key);

  @override
  State<Serch> createState() => _SerchState();
}

class _SerchState extends State<Serch> {

  String _serchCity = '';
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    Size SizePage = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Grey,

        ///ШАПКА
        appBar: PreferredSize(preferredSize: Size.fromHeight(0),
            child: AppBar(backgroundColor:Grey, elevation: 0.0,)
        ),


        ///ТЕЛО
        body: ListView(padding: EdgeInsets.zero,
                children: [

                  Container(
                    child: Text('Поиск',style: Montserrat(color:Blue,size: 40,style: Bold)),
                    padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                  ),

                  Container(padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                      margin: EdgeInsets.only(top: 30),
                      child: Stack(children: [
                        Shadow(38,15), // ТЕНЬ
                        ///Поисковая строка
                        Container(height: 40,
                            child:  TextField(style: Montserrat(color:Blue,size: 15),
                              decoration: InputDecoration(hintText: textLabelSerch,

                                prefixIcon: Container(margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                    color: Blue,),
                                    child: iconMagnifier
                                ),

                                  //СТИЛЬ
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(width: 0, style: BorderStyle.none)
                                  ),
                                  fillColor: White,
                                  isDense: true,
                                  filled: true,
                              ),
                              onChanged: (String value)
                              {
                                setState((){_serchCity = value;});
                              },
                            )
                        )
                    ])
                  ),

                  ///ГОРОДА
                  Container(margin: EdgeInsets.symmetric(vertical: 30),
                    child: Column(children: City(_serchCity))
                    )
                ]),
    );
  }

  ///ВОЗВРАЩАЕТ ГОРОДА
  List<Widget> City(String serch)
  {
    List<Widget> city= [];
    void include() async
    {
      var connection = PostgreSQLConnection("127.0.0.1", 5433, "postgres", username: "postgres", password: "123456");
      try{

        await connection.open();
        print('CONNECT===============');

      }catch(e){

        print('ERROR CONNECT===============');
        print(e.toString());

      }
      /*List<List<dynamic>> results = await connection.query("SELECT name FROM public.city");

      for(int i = 0; i < results[0].length; i++)
      {
        city.add(CardCity(i, results[0][i].toString()));
      }*/
    }

    include();
    city.add(CardCity(11, 'Москва'));
    city.add(CardCity(12, 'Сочи'));
    return city;
  }

}


class CardCity extends StatelessWidget{
  String name = '';
  int id = 0;

  CardCity(int id, String name){
    this.name = name;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {

    return Container(margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/20-5, 0, MediaQuery.of(context).size.width/20-5, 0),
      child: TextButton(onPressed:() async
      {
        /// ЗАПИСАТЬ ID ГОРОДА
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('city', this.id);
        Navigator.pushNamedAndRemoveUntil(context, '/navigation', (route) => false);
      },
        child: Stack(alignment: AlignmentDirectional.bottomStart,
            children: [
              //КАРТИНКА
              ClipRRect(borderRadius: BorderRadius.circular(30),
                child: Image.network('https://upload.wikimedia.org/wikipedia/commons/2/20/Tokyo_Tower_and_Tokyo_Sky_Tree_2011_January.jpg',fit: BoxFit.cover,
                  width: double.infinity, height: 120,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(width: double.infinity,height: 120,
                        color: Black.withOpacity(0.7), alignment: Alignment.center,
                        child: Container(width: 50,height: 50,
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            )));
                  },
                ),
              ),
              //НАЗВАНИЕ
              Stack(alignment: Alignment.center,
                  children: [
                    Container(height: 40,width: MediaQuery.of(context).size.width/3 + this.name.length.toDouble()*11,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),topRight: Radius.circular(30)))
                    ),
                    Container(
                      child: Text(this.name.toUpperCase(),style: Montserrat(size: 25,style: Bold)),
                    )
                  ])
            ]
        ),),
    );
  }
}