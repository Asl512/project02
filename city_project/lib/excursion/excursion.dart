import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'functionExcursion.dart';

import '../assets/style.dart';
import '../assets/finally.dart';
import '../assets/text.dart';
import '../assets/data.dart';

class Excursion extends StatefulWidget
{
  final int? IndexExcursion;
  const Excursion({Key? key, @required this.IndexExcursion}) : super(key: key);


  @override
  State<Excursion> createState() => _ExcursionState();
}

class _ExcursionState extends State<Excursion> {
  int _select = 1;

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
          child: AppBar(flexibleSpace: Image(image: AssetImage(dataExcursion[widget.IndexExcursion ?? 0][1]),
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
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [RichText(textAlign: TextAlign.start,
                          text: TextSpan(style: Montserrat(style:SemiBold, size: 20), text: dataExcursion[widget.IndexExcursion ?? 0][0])
                      )]
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
                              Shadow(45,10,MediaQuery.of(context).size.width/2-30),
                              Center(
                                  child: Container (width: MediaQuery.of(context).size.width/2-30, height: 45,
                                    decoration: BoxDecoration(color:White,
                                        borderRadius: BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: DropdownButton(
                                      underline: Container(),
                                      icon: iconArrowBottom,
                                      dropdownColor: White,
                                      isExpanded: true,
                                      value: _select,
                                      items: LabelType(),
                                      onChanged: (int? value) {
                                        setState(() {
                                          _select = value!;
                                        });
                                      },
                                      style: Montserrat(color: Colors.black,size: 17),
                                    ),
                                  )
                              ),
                            ],),

                            Check()
                          ]
                      )
                  ),

                  ///КОНТЕНТ
                  Container(margin: EdgeInsets.symmetric(vertical: 30),
                    child: Content()
                  )

                ])
    );
  }

  ///ВОЗВРАЩАЕТ КОНТЕНТ
  Widget Content()
  {
    int index = widget.IndexExcursion ?? 0;
    List function = [Information(context,index),Description(index),Images(index),Reviews(index)];
    for(int i = 0; i < function.length;i++)
    {
      if(_select == i+1)
      {
        return function[i];
      }
    }
    return Container();
  }

  Future<dynamic> ShowDialog()
  {
    return showDialog(
      context: context,
      builder: (context) {
        int numbPersons = 1;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Container(alignment: Alignment.center,
                  child: Text('Оплата',style: Montserrat(color:Black, style: SemiBold,size: 22)),),
                content: Container(height: 200,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(margin: EdgeInsets.only(bottom: 15),
                      child: Text(textCounPeaple, style: Montserrat(color:Black)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                              angle: 148/3.14,
                              child:IconButton(icon: iconArrowBottom,
                                  onPressed: (){
                                    if(numbPersons != dataExcursion[widget.IndexExcursion ?? 0][7])
                                    {
                                      setState(() {
                                        numbPersons++;
                                      });
                                    }
                              })),
                          Stack(children: [
                            Shadow(50,500,50), // ТЕНЬ
                            Container(width: 50,height: 50,
                              decoration: BoxDecoration(color: White, borderRadius: BorderRadius.circular(500)),
                              alignment: Alignment.center,
                              child:  Text(numbPersons.toString(),style: Montserrat(color: Black)),
                            )
                          ]),
                          IconButton(icon: iconArrowBottom,
                              onPressed: (){
                                if(numbPersons != 1)
                                {
                                  setState(() {
                                    numbPersons--;
                                  });
                                }
                              })
                        ]
                    ),

                    Container(margin: EdgeInsets.only(top: 15),
                      child: RichText(textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(text:'К оплате: ',style: Montserrat(color: Colors.black)),
                            TextSpan(text:(numbPersons*dataExcursion[widget.IndexExcursion ?? 0][8]).toString() + ' руб.',style: Montserrat(color: Colors.black,style: SemiBold))
                          ])
                    )),

                    ///ПЕРЕЙТИ К ОПЛАТЕ
                    Container(width: MediaQuery.of(context).size.width/2, height: 50,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color:Green, borderRadius: BorderRadius.circular(20)),
                        child:TextButton(
                          onPressed: () {
                            dataExcursion[widget.IndexExcursion ?? 0][7] -= numbPersons;
                            bool check = false;
                            for(int i = 0; i < dataRecords.length; i++)
                              {
                                if(dataRecords[i][0] == auth && dataRecords[i][1] == widget.IndexExcursion)
                                  {
                                    check = true;
                                    dataRecords[i][2] = dataRecords[i][2] + numbPersons;
                                  }
                              }

                            if(check == false)
                              {
                                dataRecords.add([auth,widget.IndexExcursion,numbPersons]);
                              }
                            Navigator.pop(context);
                          },
                          child: Text(textProceedPay, style: Montserrat(style:SemiBold)),
                        )
                    ),
                  ],
                ),)
            );
          },
        );
      },
    );
  }

  Widget Check()
  {
    if(auth == dataExcursion[widget.IndexExcursion??0][10])
      {
        return Container();
      }
    else
      {
        ///КНОПКА ОПЛАТИТЬ
        return Container(width: MediaQuery.of(context).size.width/2-50, height: 50,
            decoration: BoxDecoration(color:Green, borderRadius: BorderRadius.circular(20)),
            child:TextButton(
              onPressed: () {
                ShowDialog();
              },
              child: Text(textPay, style: Montserrat(style:SemiBold)),
            )
        );
      }
  }

}