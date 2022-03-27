import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lan_code/feature/presentation/libary/customSnackBar.dart';
import 'package:lan_code/feature/presentation/libary/dropdown.dart';
import 'package:lan_code/feature/presentation/libary/topSnackBart.dart';
import 'package:lan_code/feature/presentation/navigation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:math' as math;


import '../../../../common/colors.dart';
import '../../../../common/icons.dart';
import '../../../../common/textStyle.dart';
import '../../../../service.dart';
import '../../widgets/backButtons.dart';
import '../../widgets/style.dart';
import '../../widgets/text_field_style.dart';

enum RadioButtonMoment {expectation,moment }
class AddExcursion extends StatefulWidget
{
  final List typeExcursion;
  const AddExcursion({required this.typeExcursion, Key? key}) : super(key: key);

  @override
  State<AddExcursion> createState() => _AddExcursionState();
}

class _AddExcursionState extends State<AddExcursion> {
final ImagePicker _picker = ImagePicker();

Map<String, dynamic> city = {};
String name = '';
Map<String, dynamic> type = {};
String description = '';
String include = '';
String startPlace = '';
int? groupSize;
int? price;
int? specialPrice;
String details = '';
String options = '';
List photos = [];
List tags = [];
RadioButtonMoment? momentOne = RadioButtonMoment.expectation;
RadioButtonMoment? momentTwo = RadioButtonMoment.expectation;
RadioButtonMoment? momentThree = RadioButtonMoment.expectation;

List dataCityDB = [];
List dataTagsDB = [];

List<XFile>? imageList = [];
int indexBack = 0;

bool cityError = false;
List nameError = [false,"nameError"];
List descriptionError = [false,"descriptionError"];
List includeError = [false,"includeError"];
List startPlaceError = [false,"startPlaceError"];
List groupSizeError = [false,"groupSizeError"];
List priceError = [false,"priceError"];

bool isLoading = false;

List<Map<String, dynamic>> rolesCity = [];
List<Map<String, dynamic>> rolesType = [];
List<Map<String, dynamic>> rolesTags = [];
List<Map<String, dynamic>> viewTags = [];

List user = [];

List<String> dataDuration = ['1','2','3','4'];

void firebaseConnection(String? idUser) async {
 if(this.dataCityDB.isEmpty)
   {
     setState(()=>isLoading = true);

     await FirebaseFirestore.instance.collection('user').where('id',isEqualTo:idUser).get().then((snapshot){
       setState(() {this.user = snapshot.docs;});
     });

     if(!this.user.first["guidePermit"]){
       showTopSnackBar(context, CustomSnackBar.error(message:"Ошибка: Вы не являетесь гидом",textStyle: Montserrat(size: 15)));
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> Navigation(index: 3)), (route) => false);
     }

     await FirebaseFirestore.instance.collection('excursion_navigation').orderBy('name').get().then((snapshot) => {
       dataCityDB = snapshot.docs
     });

     if(rolesCity.isEmpty){
       dataCityDB.forEach((city){
         rolesCity.add({'name':city['name'],'id':city.id});
       });
     }

     await FirebaseFirestore.instance.collection('tags').orderBy('name').get().then((snapshot) => {
       dataTagsDB = snapshot.docs
     });

     if(rolesTags.isEmpty){
       dataTagsDB.forEach((tags){
         rolesTags.add({'name':tags['name'],'id':tags.id});
       });
     }
     setState(()=>isLoading = false);
   }
}

String? selectTypeExcursion;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final UserMeth? user = Provider.of<UserMeth?>(context);
    firebaseConnection(user?.id?.trim());

    if(type.isEmpty){
      String typeName;
      if(widget.typeExcursion[0]['name'].length > 24) typeName = widget.typeExcursion[0]['name'].split('').sublist(0,24).join() + '...';
      else typeName = widget.typeExcursion[0]['name'];

      type = {
        "name":typeName,
        "id":int.parse(widget.typeExcursion[0].id),
      };
    }

    return Scaffold(
      backgroundColor: Grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight:MediaQuery.of(context).size.height / 13,
            leading: Container(),
            backgroundColor: Grey,
            flexibleSpace: Stack(alignment: Alignment.topLeft,
                children: [
                  Container(margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/25,
                      left: MediaQuery.of(context).size.width/6
                  ),
                      child: Text("Добавить экскурсию",style: Montserrat(color: Blue, size: 28, style: SemiBold))
                  ),
                  ButtonBack()
                ]
            ),
            forceElevated:true,
            floating: true,
          ),
          SliverList(delegate:SliverChildListDelegate([
            CheckLoading()
          ]))
        ],
      ),
    );
  }

  Widget CheckLoading(){
    if(this.isLoading){
      return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
          child: Center(
              child: CircularProgressIndicator(color: Blue)
          )
      );
    }
    else{
      return  Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 25),
        child: Column(
          children: [
            /// CITY SELECT
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextFormField(text:'Выберите город',required: true),

                  TextFieldWithShadow(
                    MyDropdownFormField<Map<String, dynamic>>(
                        emptyText: 'Данного города нет',

                        decoration: TextFieldDecoration(
                          prefixIcon: PrefixIconTextField(
                              color: Color(0xFF546eff),
                              icon: iconCity
                          ),

                          suffixIcon: Transform.rotate(
                            angle: -90 * math.pi / 180,
                            child: Icon(
                                Icons.arrow_back_ios, color: Blue),
                          ),
                        ).inputDecoration,

                        onChanged: (dynamic str) {
                          setState(() {
                            city = str;
                            cityError = false;
                          });
                        },

                        displayItemFn: (dynamic item) =>
                        city.isEmpty ?
                        Text('Тюмень', style: Montserrat(color: Colors.black26, size: 15),) :
                        Text(this.city["name"].toString(), style: Montserrat(color: Blue, size: 15)),

                        findFn: (dynamic str) async => rolesCity,
                        filterFn: (dynamic item, str) =>
                        item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
                        dropdownItemFn: (dynamic item, int position,
                            bool focused,
                            bool selected, Function() onTap) =>
                            ListTile(
                              title: Text(item['name'], style: Montserrat(color: Blue, size: 15)),
                              onTap: onTap,
                            )
                    ), error: [cityError, "Выберите город"],
                    errorText: true,
                  ),
                ],
              ),
            ),

            ///EXC NAME
            Container(margin: EdgeInsets.only(top: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextFormField(text: 'Название экскурсии',required: true),

                      TextFieldWithShadow(
                        TextFormField(
                            initialValue: name,
                            maxLines: null,
                            maxLength: 50,
                            keyboardType: TextInputType.multiline,
                            style: Montserrat(color: Blue, size: 15),
                            onChanged: (String value) {
                              setState(() {
                                name = value;
                                nameError.first = false;
                              });
                            },
                            decoration: TextFieldDecoration(
                              hintText: "Ночная Тюмень",
                              prefixIcon: PrefixIconTextField(
                                  color: Color(0xffff54c5),
                                  icon: Center(child: Text("A+",style: Montserrat(style: Bold)),)),
                            ).inputDecoration
                        ),
                        error: nameError,
                        errorText: true,
                      )
                    ])
            ),

            TitleChapter(title: "Расписание"),

            /// TYPE SELECT
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextFormField(text: 'Выберите тип экскурсии', required: true),
                    TextFieldWithShadow(
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          buttonWidth: double.infinity,
                          itemHeight: 80,
                          buttonHeight: 50,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: White,
                          ),
                          icon: Container(
                              padding: EdgeInsets.all(10),
                              child: Transform.rotate(
                                angle: -90 * math.pi / 180,
                                child: Icon(Icons.arrow_back_ios, color: Blue,size:20,),
                              )
                          ),
                          hint: Row(
                            children: [
                              PrefixIconTextField(
                                  color: Color(0xFF42cec0),
                                  icon: Center(child: iconTypeExcursion)),
                              Text(type["name"], style: Montserrat(color: Blue, size: 15)),
                            ],
                          ),
                          items: DropdownItem(),
                          onChanged: (value) {
                            List type = value.toString().split('-');
                            setState((){
                              this.type = {
                                "name":type[0],
                                "id":int.parse(type[1])
                              };
                            });
                          },
                        ),
                      ),
                    )
                  ]),
            ),

            ///в зависимости от типа
            Container(margin: EdgeInsets.only(top: 30),
              child: type["id"] == 1?
              ScheduleTypeOne():
              type["id"] == 2?
              ScheduleTypeTwo():
              ScheduleTypeThree()
            ),


            TitleChapter(title: "Детали"),

            /// PLACE
            Container(margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextFormField(text:'Место сбора', required: true),
                  TextFieldWithShadow(
                    TextFormField(
                        initialValue: startPlace,
                        style: Montserrat(color: Blue, size: 15),
                        maxLines: null,
                        maxLength: 100,
                        keyboardType: TextInputType.multiline,
                        onChanged: (String value) {
                          setState(() {
                            startPlace = value;
                            startPlaceError.first = false;
                          });
                        },
                        decoration: TextFieldDecoration(
                          hintText: "ул. Республики 195",
                          prefixIcon: PrefixIconTextField(
                              color: Color(0xFFff5454), icon: iconLocation),
                        ).inputDecoration
                    ),
                    error: startPlaceError,
                    errorText: true,
                  )
                ],
              ),
            ),

            /// PEOPLE NUM
            Container(margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextFormField(text: 'Размер группы',required: true),
                  TextFieldWithShadow(
                    TextFormField(
                        initialValue: groupSize != null ? groupSize.toString() : "",
                        style: Montserrat(color: Blue, size: 15),
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          setState(() {
                            groupSize = int.parse(value);
                            groupSizeError.first = false;
                          });
                        },
                        decoration: TextFieldDecoration(
                          hintText: "Максимальное кол-во людей",
                          prefixIcon: PrefixIconTextField(
                              color: Color(0xFF4485e6), icon: iconSizer),
                        ).inputDecoration
                    ),
                    error: groupSizeError,
                    errorText: true,
                  )
                ],
              ),
            ),

            ///ТИП ПЕРЕДВИЖЕНИЯ

            TitleChapter(title: "Стоимость"),

            ///PRICE
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextFormField(text: 'Стандартный билет', required: true),
                      TextFieldWithShadow(
                        TextFormField(
                            initialValue: price != null
                                ? price.toString()
                                : "",
                            maxLength:5,
                            keyboardType: TextInputType.number,
                            style: Montserrat(color: Blue, size: 15),
                            onChanged: (String value) {
                              setState(() {
                                price = int.parse(value);
                                priceError.first = false;
                              });
                            },
                            decoration: TextFieldDecoration(
                              hintText: "Полная стоимость билета",
                              prefixIcon: PrefixIconTextField(
                                  color: Color(0xFFf3cb3b),
                                  icon: Center(child: Text("₽",style: Montserrat(style: Bold,size: 22)))),
                            ).inputDecoration
                        ),
                        error: priceError,
                        errorText: true,
                      )
                    ]
                )
            ),

            ///ДЛЯ ШКОЛЬНИКОВ

            TitleChapter(title: "Описание"),

            ///TAGS
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextFormField(text:'Выберите категории'),
                      TextFieldWithShadow(
                        MyDropdownFormField<Map<String, dynamic>>(
                            emptyText: 'Данного тега нет',

                            decoration: TextFieldDecoration(
                              prefixIcon: PrefixIconTextField(
                                  color: Color(0xFFc25cf2),
                                  icon: Center(child: Text("#",style: Montserrat(style: Bold,size: 22)),)),

                              suffixIcon: Transform.rotate(
                                angle: -90 * math.pi / 180,
                                child: Icon(
                                    Icons.arrow_back_ios, color: Blue),
                              ),
                            ).inputDecoration,

                            onChanged: (dynamic item) {
                              setState(() {
                                tags.add(item);
                                rolesTags.removeWhere((
                                    element) => element == item);
                              });
                            },
                            displayItemFn: (dynamic item) =>
                                Text("Начните вводить категорию",
                                    style: Montserrat(color: Colors.black26, size: 15)),

                            findFn: (dynamic str) async => rolesTags,
                            filterFn: (dynamic item, str) =>
                            item['name']
                                .toLowerCase()
                                .indexOf(str.toLowerCase()) >= 0,
                            dropdownItemFn: (dynamic item, int position,
                                bool focused,
                                bool selected, Function() onTap) =>
                                ListTile(
                                  title: Text(item['name'],
                                    style: Montserrat(
                                        color: Blue, size: 15),),
                                  onTap: onTap,
                                )
                        ),
                      ),
                      Container(margin: EdgeInsets.only(top: 10),
                        child: EnterTags(),
                      )
                    ])
            ),

            ///DISCRIPTION
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextFormField(text:'Краткое описание', required: true),
                      TextFieldWithShadow(
                        TextFormField(
                            initialValue: description,
                            maxLines: null,
                            minLines: 3,
                            maxLength: 500,
                            keyboardType: TextInputType.multiline,
                            style: Montserrat(color: Blue, size: 15),
                            onChanged: (String value) {
                              setState(() {
                                description = value;
                                descriptionError[0] = false;
                              });
                            },
                            decoration: TextFieldDecoration(
                                hintText: "Расскажите что ожидает путешественника на Вашей экскурсии?\nКакие места отдыха вы посетите?"
                            ).inputDecoration
                        ),
                        error: descriptionError,
                        errorText: true,
                      )
                    ]
                )
            ),

            /// WHAT'S INCLUDE
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextFormField(text:'Что включено', required: true),
                      TextFieldWithShadow(
                        TextFormField(
                            initialValue: include,
                            maxLines: null,
                            maxLength: 1000,
                            minLines: 3,
                            keyboardType: TextInputType.multiline,
                            style: Montserrat(color: Blue, size: 15),
                            onChanged: (String value) {
                              setState(() {
                                include = value;
                                includeError.first = false;
                              });
                            },
                            decoration: TextFieldDecoration(
                                hintText: "Опишите подробнее.\nНапример: места посещения, трансфер, услуги, фотограф, обед."
                            ).inputDecoration
                        ),
                        error: includeError,
                        errorText: true,
                      )
                    ])
            ),

            /// DETAILS
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextFormField(text:'Организационные детали'),

                      TextFieldWithShadow(
                          TextFormField(
                              initialValue: details,
                              maxLines: null,
                              maxLength: 1000,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Montserrat(color: Blue, size: 15),
                              onChanged: (String value) {
                                setState(() => details = value);
                              },
                              decoration: TextFieldDecoration(
                                  hintText: "Напишите, о чем стоит знать путешествинникам перед экскурсией.\nНапример, что стоит взять с собой."
                              ).inputDecoration
                          )
                      )
                    ]
                )
            ),

            /// OPTIONS
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextFormField(text:'Дополнительные услуги'),

                      TextFieldWithShadow(
                          TextFormField(
                              initialValue: options,
                              maxLines: null,
                              maxLength: 1000,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Montserrat(color: Blue, size: 15),
                              onChanged: (String value) {
                                setState(() => options = value);
                              },
                              decoration: TextFieldDecoration(
                                  hintText: "Напишите о дополнительных расходах, которые не входят в стоимость стандартного билета."
                              ).inputDecoration
                          )
                      )
                    ]
                )
            ),

            ///PHOTOS
            Container(margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTextFormField(text:"Фотографии"),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: White,
                          boxShadow: [ShadowForContainer()],
                          border: false ? Border.all(color: Red) : Border.all(color: White)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(crossAxisAlignment: WrapCrossAlignment.center,
                          children: PhotosList()
                      )
                  ),
                  ///добавить описание
                ],
              ),
            ),


            /// BUTTON
            Container(
                margin: EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height / 4.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    TextButton(onPressed: () {
                      Validation();
                    },
                        child: Container(width: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width / 15 * 2,
                            height: 50,
                            decoration: BoxDecoration(color: Blue,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(500))),
                            child: Center(child: Text("Добавить",
                                style: Montserrat(
                                    style: SemiBold, size: 19)),)
                        )
                    ),

                    ///ТЕКСТ
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 7),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Добавляя экскурсию, она сначала проходит модерацию. ",
                              style: Montserrat(size: 12, color: Blue),
                            ),
                            TextSpan(
                              text: "Подробнее.",
                              style: Montserrat(
                                  style: SemiBold, size: 13, color: Red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showModalBottomSheet(
                                      backgroundColor: White.withOpacity(
                                          0),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container();
                                      });
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      );
    }
  }

  Widget EnterTags(){
    List<Widget> data = [];
    for(int i = 0; i < this.tags.length; i++){
      data.add(InputChip(
        deleteIconColor: White,
        labelStyle: Montserrat(size: 14),
        backgroundColor: Blue,
        onDeleted: ()=>setState((){
          rolesTags.add(tags[i]);
          tags.removeWhere((element) => element == this.tags[i]);
        }),
        label: Text(this.tags[i]["name"]),
      ));
    }
    return Wrap(
        children: data,
        spacing:10,
    );
  }

  void Validation(){
    String errorText = "";
    int lines = 0;
    if(this.city.isEmpty){
      setState(()=>cityError = true);
      errorText += "Выберите город\n";
      lines++;
    }

    if(this.name == ""){
      setState(()=>nameError = [true,"Введите название экскурсии"]);
      errorText += "Введите название экскурсии\n";
      lines++;
    }
    else if(this.name.length < 5){
      setState(()=>nameError = [true,"Слишком короткое название экскурсии"]);
      errorText += "Слишком короткое название экскурсии\n";
      lines++;
    }

    if(this.description == ""){
      setState(()=>descriptionError = [true,"Опишите вашу экскурсию"]);
      errorText += "Опишите вашу экскурсию\n";
      lines++;
    }
    else if(this.description.length < 15){
      setState(()=>descriptionError = [true,"Слишком короткое описание экскурсии"]);
      errorText += "Слишком короткое описание экскурсии\n";
      lines++;
    }

    if(this.include == ""){
      setState(()=>includeError = [true,"Опишите что входит в экскурсию"]);
      errorText += "Опишите что входит в экскурсию\n";
      lines++;
    }
    else if(this.include.length < 15){
      setState(()=>includeError = [true,"Слишком короткое описание что входит"]);
      errorText += "Слишком короткое описание что входит\n";
      lines++;
    }

    if(this.startPlace == ""){
      setState(()=>startPlaceError = [true,"Введите место сбора"]);
      errorText += "Введите место сбора\n";
      lines++;
    }
    else if(this.startPlace.length < 5){
      setState(()=>startPlaceError = [true,"Слишком короткое описание места сбора"]);
      errorText += "Слишком короткое описание места сбора\n";
      lines++;
    }

    if(this.groupSize == null){
      setState(()=>groupSizeError = [true,"Введите максимальный размер группы"]);
      errorText += "Введите максимальный размер группы\n";
      lines++;
    }
    else if(this.groupSize! < 4){ //проверка на тип индивид. = 1, группавая = 4
      setState(()=>groupSizeError = [true,"Максимальный размер группы должен быть больше 5 человек"]);
      errorText += "Максимальный размер группы должен быть больше 5 человек\n";
      lines++;
    }

    if(this.price == null){
      setState(()=>priceError = [true,"Введите цену за билет"]);
      errorText += "Введите цену за билет\n";
      lines++;
    }
    else if(this.price! < 100){
      setState(()=>priceError = [true,"Цена за билет должна привышеть 100 руб."]);
      errorText += "Цена за билет должна привышеть 100 руб.\n";
      lines++;
    }

    //валидность время только пустое

    if(errorText == "") showTopSnackBar(context, CustomSnackBar.success(message:"Ваша экскурсия была добавлена в модерацию",textStyle: Montserrat(size: 15)));
    else showTopSnackBar(context, CustomSnackBar.error(message:errorText,textStyle: Montserrat(size: 15),lines: lines));
  }


List<DropdownMenuItem<Object>> DropdownItem(){
  List<DropdownMenuItem<Object>> list = [];
  List<ItemTypeExcursion> data = [];

  for(int i = 0; i < widget.typeExcursion.length; i++){
    data.add(ItemTypeExcursion(
        title:widget.typeExcursion[i]["name"],
        description: widget.typeExcursion[i]["description"],
        id: widget.typeExcursion[i].id),
    );
  }

  for(int i = 0; i < data.length; i++){
    list.add(
        DropdownMenuItem<ItemTypeExcursion>(
            value: data[i],
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data[i].title, style: Montserrat(color: Blue, size: 15,style: SemiBold)),
                Text(data[i].description,style: Montserrat(color: Blue, size: 13)),
              ],
            )
        )
    );
  }
  return list;
}

List<Widget> PhotosList(){
  ///КНОПКА ДОБАВИТЬ ФОТО
  List<Widget> photos = [
    TextButton(onPressed:()async{
      final List<XFile>? selectedImages = await _picker.pickMultiImage();
      if (selectedImages!.isNotEmpty) setState(()=>imageList!.addAll(selectedImages));
    },
        child: Container(
          padding: EdgeInsets.only(top: 5),
          height: MediaQuery.of(context).size.width/5,
          width: MediaQuery.of(context).size.width/5*1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Blue,
          ),
          child: Column(
            children: [
              Icon(Icons.camera_alt_outlined,color: White,size: 35,),
              Text('Добавить фотографию',style: Montserrat(size: 12),textAlign: TextAlign.center,)
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
                    width: MediaQuery.of(context).size.width/5*1.2,
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

void uploadImg() async {
  String fileName = imageList![0].name;
  var bytes = await imageList![0].readAsBytes();
  try {
    print("start, $fileName");
    firebase_storage.Reference _storage = firebase_storage.FirebaseStorage.instance.ref('photoExcursion/$fileName');
    await _storage.putData(bytes);
    print("++++");
    print("start URL");
    String url = await firebase_storage.FirebaseStorage.instance.ref('photoExcursion/$fileName').getDownloadURL();
    print(url);
  } catch (e) {
    print(e);
  }
}

//ПЕРВЫЙ ТИП
Widget ScheduleTypeOne(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextFormField(text:'Подтверждение брони',required: true),
        Column(
          children: [
            ListTile(
              title:Text("Подтверждение заказа вручную.", style: Montserrat(color: Blue, size: 15,style: SemiBold)),
              subtitle:Text('Путешественники могут оплатить заказ только после вашего подтверждения.',style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor:Blue,
                value: RadioButtonMoment.expectation,
                groupValue: momentOne,
                onChanged: (RadioButtonMoment? value) {},
              ),
              contentPadding: EdgeInsets.symmetric(horizontal:-20),
            ),
          ],
        )
      ],
    );
}


//ВТОРОЙ ТИП
  Widget ScheduleTypeTwo(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextFormField(text:'Подтверждение брони',required: true),
        Column(
          children: [
            ListTile(
              title:Text("Подтверждение заказа вручную.", style: Montserrat(color: Blue, size: 15,style: SemiBold)),
              subtitle:Text('Путешественники могут оплатить заказ только после вашего подтверждения.',style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor:Blue,
                value: RadioButtonMoment.expectation,
                groupValue: RadioButtonMoment.expectation,
                onChanged: (RadioButtonMoment? value) {},
              ),
              contentPadding: EdgeInsets.symmetric(horizontal:-20),
            ),
          ],
        )
      ],
    );
  }



//ТРЕТИЙ ТИП
  Widget ScheduleTypeThree(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextFormField(text: 'Подтверждение брони',required: true),
        Column(
          children: [
            ListTile(
              title:Text("Подтверждение заказа вручную.", style: Montserrat(color: Blue, size: 15,style: SemiBold)),
              subtitle:Text('Путешественники могут оплатить заказ только после вашего подтверждения.',style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor:Blue,
                value: RadioButtonMoment.expectation,
                groupValue: momentThree,
                onChanged: (RadioButtonMoment? value) {
                  setState(()=>momentThree = value);
                },
              ),
              contentPadding: EdgeInsets.symmetric(horizontal:-20),
            ),
            ListTile(
              title:Text("Моментальное бронирование." , style: Montserrat(color: Blue, size: 15,style: SemiBold)),
              subtitle:Text('Путешественники могут оплатить заказ только после вашего подтверждения.',style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor:Blue,
                value: RadioButtonMoment.moment,
                groupValue: momentThree,
                onChanged: (RadioButtonMoment? value) {
                  setState(()=>momentThree = value);
                },
              ),
              contentPadding: EdgeInsets.symmetric(horizontal:-20),
            ),
          ],
        )
      ],
    );
  }
}

class TitleChapter extends StatelessWidget {
  final String? title;

  TitleChapter({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(top: 50),
      alignment: Alignment.topLeft,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(margin:EdgeInsets.only(left: 10,bottom: 10),
            child:  Text(this.title.toString(),style: Montserrat(color: Blue,style: SemiBold,size: 30)),
          ),
          Container(height: 1,width: double.infinity,color: Blue)
        ],
      ),
    );
  }
}

class ItemTypeExcursion {
  final String title;
  final String description;
  final String id;

  const ItemTypeExcursion({
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  String toString() {
    String name;
    if(title.length > 24){
      name = title.split('').sublist(0,24).join() + '...';
    }else{
      name = title;
    }
    return "$name-$id";
  }
}