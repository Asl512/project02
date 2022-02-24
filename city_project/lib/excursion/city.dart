import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';
import 'package:postgres/postgres.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import 'serch.dart';
import 'excursionClass.dart';


class City extends StatefulWidget
{
  City({Key? key}) : super(key: key);
  int idCity = 0;

  void getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idCity = prefs.getInt('city') ?? 1;
    print(this.idCity);
  }

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> with TickerProviderStateMixin {
  late TabController _tabController;
  int idCity = 1;
  List data = [0,'Null'];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.idCity = prefs.getInt('city') ?? 1;
    });
    print(this.idCity);
  }

  void includeBD() async{
    var connection = PostgreSQLConnection("rc1b-zkri5cth30iw9y0q.mdb.yandexcloud.net", 6432, "tripteam_db", username: "TripTeamAdmin2", password: "NCR2I4%Te44A", useSSL:true);
    try {
      await connection.open();

      List<dynamic> results = await connection.query("SELECT * FROM public.city WHERE id = " + this.idCity.toString());
      this.data = results[0];

      print('D'+results[0].toString());

    }catch(e){
      print('ERROR CONNECT================');
      print(e.toString());
    }
    }

  @override
  Widget build(BuildContext context) {
    Size SizePage = MediaQuery.of(context).size;
    //getStringValuesSF();
    //includeBD();


    return Scaffold(backgroundColor: Grey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(SizePage.height/5),
          ///ШАПКА
          child: AppBar(flexibleSpace: Stack(children: [
            Image.network('https://upload.wikimedia.org/wikipedia/commons/2/20/Tokyo_Tower_and_Tokyo_Sky_Tree_2011_January.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
            ),
            Container(width: double.infinity, height: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5))
            ),
            Container(alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(this.data[1].toString().toUpperCase(),style: Montserrat(color:White,size: 35,style: SemiBold)),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> Serch()));
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
              tabs: Tabs(),
              isScrollable: true,
              indicatorColor: White,
            ),
          )
      ),

      body: TabBarView(
        controller: _tabController,
        children: RequestExcursion(),
      ),
    );
  }

  List<Widget> RequestExcursion(){
    List<Widget> widgets = [];
    for(int i = 0; i < names.length; i++){
      widgets.add(ExcursionPagination(names[i],idCity));
    }
    return widgets;
  }

  List<String> names = ['Все','Групповые','Индивидуальные','Индивидуальные'];
  List<Widget> Tabs()
  {
    List<Widget> tabs = [];

    for(int i = 0; i < names.length; i++)
      {
        tabs.add(
          Tab(
              child: Text(names[i],style: Montserrat(color:White,size: 15))
          ),
        );
      }
    return tabs;
  }
}

class ExcursionPagination extends StatelessWidget {

  int idCity = 1;
  String request = '';
  List data = [];
  ExcursionPagination(this.request, this.idCity);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfiniteList<Widget>(
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
      ),
    );
  }



  Future<List<Widget>?> itemLoader(int limit, {int start = 0}) async {
    var connection = PostgreSQLConnection("rc1b-zkri5cth30iw9y0q.mdb.yandexcloud.net", 6432, "tripteam_db", username: "TripTeamAdmin2", password: "NCR2I4%Te44A", useSSL:true);
    try{

      await connection.open();
      List<dynamic> results = await connection.query("SELECT * FROM public.city WHERE id = "+ this.idCity.toString());

      for(int i = 0; i < results.length; i++)
      {
        //print(results[i]);
        this.data.add(results[i]);
      }

      await Future<void>.delayed(const Duration(seconds: 1));
      List<Widget> entertainmentWidgets = [];
      for (int i = 0; i < this.data.length; i++) {
        entertainmentWidgets.add(
            Excursion(
              id: 0,
              name: data[i][1],
              photo: 'https://firebasestorage.googleapis.com/v0/b/dbapp-28831.appspot.com/o/city%2Fмосква.jpg?alt=media&token=2e8ebb29-1528-41ac-a38f-1cc0664daf72',
              author: 'https://firebasestorage.googleapis.com/v0/b/dbapp-28831.appspot.com/o/city%2Fмосква.jpg?alt=media&token=2e8ebb29-1528-41ac-a38f-1cc0664daf72',
              description: 'Описание путешествия по Золотому Рогу и Босфору Описание путешествия по Золотому Рогу и Босфору',
              type: 'Индивидуальная',
              price: 99999,
              time: 1.5,
              authorCheck: true,
              moment: true,
            )
        );
      }
      limit = 5;
      if (start >= entertainmentWidgets.length) return null;
      if (false) throw Exception();
      if (false) throw InfiniteListException();
      if (entertainmentWidgets.length - start > 0 && entertainmentWidgets.length - start  < limit){
        int count = entertainmentWidgets.length - start;
        return List.generate(count, (index) {
          return entertainmentWidgets[index+start];
        });
      }

      return List.generate(limit, (index) {
        return entertainmentWidgets[index+start];
      });

    }catch(e){
      print('ERROR CONNECT===============');
      print(e.toString());
      throw Exception(e);
    }
  }
}