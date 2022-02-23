import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import 'serch.dart';
import 'excursionClass.dart';

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
                width: double.infinity,
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
      widgets.add(ExcursionPagination(names[i]));
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

  String request = '';
  List data = [];
  ExcursionPagination(this.request);


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

  void getData()
  {
    ///Запросы в бд на получение данных об экскурсиях
    this.data = [1,2,3,4,5,6,7,8,9,10,11,12,13,14];
  }


  Future<List<Widget>?> itemLoader(int limit, {int start = 0}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    getData();
    List<Widget> entertainmentWidgets = [];
    for (int i = 0; i < this.data.length; i++) {
      entertainmentWidgets.add(
          Excursion(
            id: 0,
            name: 'Test'+i.toString(),
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
  }
}