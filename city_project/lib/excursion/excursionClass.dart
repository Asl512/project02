import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/style.dart';
import '../assets/finally.dart';


class Excursion extends StatefulWidget
{
  const Excursion({
    Key? key,
    this.id = '//',
    this.name = 'null',
    this.photo = '////',
    this.author = '////',
    this.type = 'nullType',
    this.time = 0,
    this.moment = false,
    this.authorCheck = false,
    this.description = 'null',
    this.price = 0,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? photo;
  final String? author;
  final String? type;
  final dynamic? time;
  final bool? moment;
  final bool? authorCheck;
  final String? description;
  final int? price;

  @override
  State<Excursion> createState() => _ExcursionState();
}

class _ExcursionState extends State<Excursion>{

  Widget getPhotoExcursion(){
    if(widget.photo == 'null'){
      return Image.asset(excursionDef,
          fit: BoxFit.cover,
          width: double.infinity, height: MediaQuery.of(context).size.height/10+20
      );
    }else{
      return Image.network(widget.photo.toString(),
        fit: BoxFit.cover,
        width: double.infinity, height: MediaQuery.of(context).size.height/10+20,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Placholder(double.infinity,MediaQuery.of(context).size.height/10+20);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(excursionDef,
              fit: BoxFit.cover,
              width: double.infinity, height: MediaQuery.of(context).size.height/10+20
          );
        },
      );
    }
  }

  Widget getPhotoAuthor(){
    if(widget.author == 'null'){
      return Image.asset(avatarDef,
        fit: BoxFit.cover,
        width: 40, height: 40,
      );
    }else{
      return Image.network(widget.author.toString(),
        fit: BoxFit.cover,
        width: 40, height: 40,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(avatarDef,
            fit: BoxFit.cover,
            width: 40, height: 40,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/60),
      child: TextButton(onPressed:()
      {
        ///Navigator.push(context, MaterialPageRoute(builder: (context) => Excursion(IndexExcursion: widget.id??-1),));///передаем index экскурсии
      },
        child: Column(
            children: [
              Stack(alignment: Alignment.topRight,
                children: [
                  Stack(alignment: AlignmentDirectional.bottomStart,
                    children: [
                      //КАРТИНКА
                      ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        child: getPhotoExcursion()
                      ),

                      Container(height: 50,
                          width: widget.name.toString().length.toDouble()*14 +50 >= MediaQuery.of(context).size.width/1.4 ? MediaQuery.of(context).size.width/1.4 : widget.name.toString().length.toDouble()*14 + 50,
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
                                      child: getPhotoAuthor()
                                    ),

                                    GuideCheck(widget.authorCheck??false)

                                  ])),

                              Flexible(child: Text(widget.name.toString(),style: Montserrat(size: 15,style: SemiBold)))
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
                                        Text(widget.type.toString(),style: Montserrat(size: 17,style: SemiBold, color: Color(0xFF55596A))),
                                        ///МОЛНИЯ, СДЕЛАТЬ ПРОВРКУ
                                        Container(width: 17,height: 17,
                                          margin: EdgeInsets.only(left: 5),
                                          child: iconLightning,)
                                      ]),
                                  Flexible(child: Text(widget.description.toString(),style: Montserrat(size: 14, color: Blue)),)
                                ]
                            ),
                          ),

                          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.time.toString() + ' часа',style: Montserrat(size: 13, style: Regular,color: Blue)),
                                Text('₽ '+ widget.price.toString(),style: Montserrat(size: 16, style: Bold,color: Blue)),
                              ]
                          )
                        ],
                      ),
                    )

                  ])
            ]
        ),),
    );
  }

  Widget GuideCheck(bool check){
    if(check)
    {
      return Container(width: 40,height: 40,
          alignment: Alignment.bottomRight,
          child: Container(width: 15,height: 15,
              child: iconConfirmation)
      );
    }
    else
    {
      return Container();
    }
  }
}