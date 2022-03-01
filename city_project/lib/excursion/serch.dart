import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../navigation.dart';


class Serch extends StatefulWidget
{
  const Serch({Key? key}) : super(key: key);

  @override
  State<Serch> createState() => _SerchState();
}

class _SerchState extends State<Serch> {

  String serchCity = '';

  @override
  Widget build(BuildContext context)
  {
    Size SizePage = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Grey,

      ///ШАПКА
      appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/5),
          child: AppBar(backgroundColor:Grey,
              leading: Container(),
              flexibleSpace:Stack(alignment: Alignment.topLeft,
                  children: [
                Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    child: Text("search".tr(),style: Montserrat(color:Blue,size: 40,style: Bold)),
                    padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                  ),

                  Container(padding: EdgeInsets.symmetric(horizontal: SizePage.width/20),
                      margin: EdgeInsets.only(top: 30),
                      child: Stack(children: [
                        Shadow(38,15), // ТЕНЬ
                        ///Поисковая строка
                        Container(height: 40,
                            child:  TextField(style: Montserrat(color:Blue,size: 15),
                              decoration: InputDecoration(hintText: "hintSearch".tr(),

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
                                setState((){this.serchCity = value;});
                              },
                            )
                        )
                      ])
                  ),
                ]),
                    Container(
                        height: 70,width: 50,
                        decoration: BoxDecoration(color: Blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))),
                        child: IconButton(icon: Icon(Icons.arrow_back_ios,size: 20,color: White,),
                            onPressed: (){
                              Navigator.pop(context);
                            })
                    ),

              ])
          )
      ),


        ///ТЕЛО
        body: CityPagination(this.serchCity)
    );
  }
}

class CityPagination extends StatelessWidget {

  String request = '';
  List data = [];
  CityPagination(this.request);


  @override
  Widget build(BuildContext context) {
    return InfiniteList<Widget>(
        padding: const EdgeInsets.all(0),
        itemLoader: itemLoader,
        builder: InfiniteListBuilder<Widget>(
          empty: (context) => WaitDialog(iLoading,"dontMero".tr()),
          loading: (context) => Center(child: CircularProgressIndicator(color: Blue,)),
          success: (context, item) => item,
          error: (context, retry, error) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(error.toString(),style: Montserrat(color: Blue,size: 15,style: SemiBold),),
                TextButton(onPressed: retry,
                    child: Text('repeat'.tr(),style: Montserrat(color: Red,size: 17,style: SemiBold),))
              ],
            ));
          },
        ),
        errorLoader: (context, retry, error) => TextButton(onPressed: retry,
            child: Text('repeat'.tr(),style: Montserrat(color: Red,size: 17,style: SemiBold),)),

        bottomLoader: (context) => Center(child: Container(padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(color: Blue))
        )
      //errorLoader: (context, retry, error) => _ErrorLoader(retry: retry),
    );
  }


  Future<List<Widget>?> itemLoader(int limit, {int start = 0}) async {
    await FirebaseFirestore.instance.collection('city').get().then((snapshot) => {
      this.data = snapshot.docs
    });

    List<Widget> city = [];
    for (int i = 0; i < this.data.length; i++) {
      city.add(CardCity(this.data[i].id, this.data[i]['name'],this.data[i]['photo']));
    }
    limit = 5;
    if (start >= city.length) return null;
    if (false) throw Exception();
    if (false) throw InfiniteListException();
    if (city.length - start > 0 && city.length - start  < limit){
      int count = city.length - start;
      return List.generate(count, (index) {
        return city[index+start];
      });
    }

    return List.generate(limit, (index) {
      return city[index+start];
    });
  }
}


class CardCity extends StatelessWidget{
  String name = '';
  String id = '';
  String photo = '';

  CardCity(this.id , this.name, this.photo);

  @override
  Widget build(BuildContext context) {

    return Container(margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/20-5, 0, MediaQuery.of(context).size.width/20-5, 10),
      child: TextButton(onPressed:() async {
        /// ЗАПИСАТЬ ID ГОРОДА
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('city', this.id);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LocaleNavigation()), (route) => false);
      },
        child: Stack(alignment: AlignmentDirectional.bottomStart,
            children: [
              //КАРТИНКА
              ClipRRect(borderRadius: BorderRadius.circular(30),
                child: Image.network(this.photo,fit: BoxFit.cover,
                  width: double.infinity, height: MediaQuery.of(context).size.height/7,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Placholder(double.infinity, MediaQuery.of(context).size.height/7);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(excursionDef,
                        fit: BoxFit.cover,
                        width: double.infinity, height: MediaQuery.of(context).size.height/10+20
                    );
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
                  ]),
            ]
        ),),
    );
  }
}


class Movie {
  Movie({
    required this.genre,
    required this.likes,
    required this.poster,
    required this.rated,
    required this.runtime,
    required this.title,
    required this.year,
  });

  Movie.fromJson(Map<String, Object?> json)
      : this(
    genre: (json['genre']! as List).cast<String>(),
    likes: json['likes']! as int,
    poster: json['poster']! as String,
    rated: json['rated']! as String,
    runtime: json['runtime']! as String,
    title: json['title']! as String,
    year: json['year']! as int,
  );

  final String poster;
  final int likes;
  final String title;
  final int year;
  final String runtime;
  final String rated;
  final List<String> genre;

  Map<String, Object?> toJson() {
    return {
      'genre': genre,
      'likes': likes,
      'poster': poster,
      'rated': rated,
      'runtime': runtime,
      'title': title,
      'year': year,
    };
  }
}