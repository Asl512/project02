import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/assets/finally.dart';

import 'assets/style.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}):super(key:key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageList = [];
  int indexBack = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
            color: White,
            boxShadow: [ShadowForContainer()],
            border: false ? Border.all(color: Red) : Border.all(color: White)
        ),
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
          child: Wrap(crossAxisAlignment: WrapCrossAlignment.center,
              children: PhotosList()
          )
      )
    );
  }

  List<Widget> PhotosList(){
    ///КНОПКА
    List<Widget> photos = [
      TextButton(onPressed:()async{
        final List<XFile>? selectedImages = await _picker.pickMultiImage();
        if (selectedImages!.isNotEmpty) imageList!.addAll(selectedImages);
      },
          child: Container(
            padding: EdgeInsets.only(top: 5),
            height: MediaQuery.of(context).size.width/5,
            width: MediaQuery.of(context).size.width/5*1.5-10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Blue,
            ),
            child: Column(
              children: [
                Icon(Icons.camera_alt_outlined,color: White,size: 40,),
                Text('Добавить фотографию',style: Montserrat(size: 13),textAlign: TextAlign.center,)
              ],
            ),
          )
      ),
    ];

    ///ФОТОГРАФИИ
    for(int i =0; i < imageList!.length; i++){
      photos.add(
          Stack(alignment: AlignmentDirectional.topEnd,
            children: [
              TextButton(onPressed: ()=>setState(()=>indexBack = i),
                  child: Container(
                    decoration: BoxDecoration(
                      border: i == indexBack?Border.all(color: Red,width: 2):Border.all(color: White,width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(imageList![i].path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width/5,
                        width: MediaQuery.of(context).size.width/5*1.5-14,
                      ),
                    ),
                  ),
              ),
              Container(
                height: 25,
                width: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: White,
                  border: Border.all(color: Blue,width: 2),
                  borderRadius: BorderRadius.circular(500)
                ),
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.zero,
                child: IconButton(onPressed:(){
                  setState((){
                    imageList!.removeAt(i);
                    if(indexBack == i) indexBack = 0;
                  });
                },
                    padding: EdgeInsets.zero,
                    iconSize: 30,
                    icon: Text('x',style: Montserrat(style: Bold,color: Blue),)
                ),
              )
            ],
          )
      );
    }
    return photos;
  }
}