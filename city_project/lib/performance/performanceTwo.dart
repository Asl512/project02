import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../assets/style.dart';
import '../../assets/finally.dart';
import '../../assets/text.dart';



class PerfomanceTwo extends StatefulWidget
{
  const PerfomanceTwo({Key? key}) : super(key: key);

  @override
  State<PerfomanceTwo> createState() => _PerfomanceTwoState();
}

class _PerfomanceTwoState extends State<PerfomanceTwo>
{

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
        body:Stack(children:[
            ///ФОН
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover,
                  image: AssetImage(imgPerformanceTwo),
                )),
              ),
              Container(height: double.infinity,width: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5))
                ),
            ],
          ),

          ///BODY
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: EdgeInsets.fromLTRB(30, 90, 30, 0),

                child: Text(textPerfomanceTwo,style: Montserrat(style: SemiBold, size: 24,heigth: 1.7),
                    textAlign: TextAlign.center,),
              ),

              Container(height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(color: Green.withOpacity(0.6)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:[

                        ///ПРОПУСТИТЬ
                        TextButton(onPressed:()
                        {
                          Navigator.pushNamedAndRemoveUntil(context, '/authorization', (route) => false);
                        },
                            child: Text(textSkip, style: Montserrat(size: 15,style: SemiBold))
                        ),

                        ///СОСТОЯНИЕ
                        Container(
                            child: Row(children: [
                              Circle(White,4),
                              Circle(Green,4),
                              Circle(White,4),
                              Circle(White,4)
                            ])
                        ),

                        ///СЛЕДУЮЩАЯ
                        Container(margin: EdgeInsets.only(left: 40),
                            child: IconButton(onPressed:()
                            {
                              Navigator.pushNamed(context, '/perfomanceThree');
                            },
                              icon: iconArrow, iconSize: 50,
                            )
                        )
                      ]
                  )
              )
            ],
          )
        ])
    );
  }
}
