import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:math' as math;


import '../assets/style.dart';
import '../assets/finally.dart';
import '../libary/customSnackBar.dart';
import '../libary/dropdown.dart';
import '../libary/topSnackBart.dart';
import '../navigation.dart';
import '../service.dart';

class AddExcursion extends StatefulWidget
{
  const AddExcursion({Key? key}) : super(key: key);

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
List<PickerDateRange> dates = [];
List tags = [];

List dataCityDB = [];
List dataTypeDB = [];
List dataTagsDB = [];

List<XFile>? imageList = [];
int indexBack = 0;

bool cityError = false;
List nameError = [false,"nameError"];
bool typeError= false;
List descriptionError = [false,"descriptionError"];
List includeError = [false,"includeError"];
List startPlaceError = [false,"startPlaceError"];
List groupSizeError = [false,"groupSizeError"];
List priceError = [false,"priceError"];
List datesError = [false,"datesError"];

bool isLoading = false;

List<Map<String, dynamic>> rolesCity = [];
List<Map<String, dynamic>> rolesType = [];
List<Map<String, dynamic>> rolesTags = [];
List<Map<String, dynamic>> viewTags = [];

List user = [];

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

     await FirebaseFirestore.instance.collection('city').orderBy('name').get().then((snapshot) => {
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

     await FirebaseFirestore.instance.collection('typeExcursion').orderBy('name').where('name',isNotEqualTo:'Все').get().then((snapshot) => {
       dataTypeDB = snapshot.docs
     });

     if(rolesType.isEmpty){
       dataTypeDB.forEach((typeExcursion){
         rolesType.add({'name':typeExcursion['name'],'id':typeExcursion.id});
       });
     }
     setState(()=>isLoading = false);
   }
}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final UserMeth? user = Provider.of<UserMeth?>(context);
    firebaseConnection(user?.id?.trim());

    return Scaffold(
      backgroundColor: Grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight:MediaQuery.of(context).size.height / 8,
            leading: Container(),
            backgroundColor: Grey,
            flexibleSpace: Stack(alignment: Alignment.topLeft,
                children: [
                  Container(margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/30,
                      left: MediaQuery.of(context).size.width/6
                  ),
                      child: Text("Добавить экскурсию",style: Montserrat(color: Blue, size: 35, style: SemiBold))
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
                  RichTextMethod('Выберите город', true),

                  TextFieldWithShadow(
                    DropdownFormField<Map<String, dynamic>>(
                        emptyText: 'Данного города нет',

                        decoration: TextFieldDecoration(
                          prefixIcon: PrefixIconTextField(
                              color: Color(0xFF546eff),
                              icon: iconEmail
                          ),

                          suffixIcon: Transform.rotate(
                            angle: -90 * math.pi / 180,
                            child: Icon(
                                Icons.arrow_back_ios, color: Blue),
                          ),
                        ).InputDecor(),

                        onChanged: (dynamic str) {
                          setState(() {
                            city = str;
                            cityError = false;
                          });
                        },

                        displayItemFn: (dynamic item) =>
                        city.isEmpty ?
                        Text('Тюмень', style: Montserrat(
                            color: Colors.black26, size: 15),) :
                        Text(this.city["name"].toString(),
                            style: Montserrat(color: Blue, size: 15)),

                        findFn: (dynamic str) async => rolesCity,
                        filterFn: (dynamic item, str) =>
                        item['name']
                            .toLowerCase()
                            .indexOf(str.toLowerCase()) >= 0,
                        dropdownItemFn: (dynamic item, int position,
                            bool focused,
                            bool selected, Function() onTap) =>
                            ListTile(
                              title: Text(item['name'], style: Montserrat(
                                  color: Blue, size: 15)),
                              onTap: onTap,
                            )
                    ), error: [cityError, "Выберите город"],
                    errorText: true,
                  ),
                ],
              ),
            ),

            ///EXC NAME
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextMethod('Название экскурсии', true),

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
                                  icon: iconEmail),
                            ).InputDecor()
                        ),
                        error: nameError,
                        errorText: true,
                      )
                    ])
            ),

            /// TYPE SELECT
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichTextMethod('Выберите тип экскурсии', true),

                    TextFieldWithShadow(
                      DropdownFormField<Map<String, dynamic>>(
                          emptyText: 'Данный тип не найден',

                          decoration: TextFieldDecoration(
                            prefixIcon: PrefixIconTextField(
                                color: Color(0xFF42cec0),
                                icon: iconEmail),

                            suffixIcon: Transform.rotate(
                              angle: -90 * math.pi / 180,
                              child: Icon(
                                  Icons.arrow_back_ios, color: Blue),
                            ),
                          ).InputDecor(),

                          onChanged: (dynamic str) {
                            setState(() {
                              type = str;
                              typeError = false;
                            });
                          },

                          displayItemFn: (dynamic item) =>
                          type.isEmpty ?
                          Text(rolesType[0]["name"], style: Montserrat(
                              color: Blue, size: 15),) :
                          Text(type["name"].toString(), style: Montserrat(
                              color: Blue, size: 15)),

                          findFn: (dynamic str) async => rolesType,
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
                      error: [typeError, "Выберите тип экскурсии"],
                      errorText: true,
                    )
                  ]),
            ),

            ///DISCRIPTION
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextMethod('Краткое описание', true),
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
                            ).InputDecor()
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
                      RichTextMethod('Что включено', true),
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
                            ).InputDecor()
                        ),
                        error: includeError,
                        errorText: true,
                      )
                    ])
            ),

            /// PLACE
            Container(margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichTextMethod('Место сбора', true),
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
                              color: Color(0xFFffaf5a), icon: iconEmail),
                        ).InputDecor()
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
                  RichTextMethod('Размер группы', true),
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
                              color: Color(0xFFff645a), icon: iconEmail),
                        ).InputDecor()
                    ),
                    error: groupSizeError,
                    errorText: true,
                  )
                ],
              ),
            ),

            ///PRICE
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextMethod('Стандартный билет', true),
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
                                  color: Color(0xFF47b577),
                                  icon: iconEmail),
                            ).InputDecor()
                        ),
                        error: priceError,
                        errorText: true,
                      )
                    ]
                )
            ),

            ///(селектор(школьники, студенты)) (цена)
            ///SPECIAL PRICE
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextMethod('Специальная стоймость'),

                      TextFieldWithShadow(
                          TextFormField(
                              initialValue: specialPrice != null
                                  ? specialPrice.toString()
                                  : "",
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              style: Montserrat(color: Blue, size: 15),
                              onChanged: (String value) {
                                setState(() =>
                                specialPrice = int.parse(value));
                              },
                              decoration: TextFieldDecoration(
                                hintText: "Стоимость для детей и тд.",
                                prefixIcon: PrefixIconTextField(
                                    color: Color(0xFF47b577),
                                    icon: iconEmail),
                              ).InputDecor()
                          )
                      )
                    ])
            ),

            ///TAGS
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextMethod('Выберите категории'),
                      TextFieldWithShadow(
                        DropdownFormField<Map<String, dynamic>>(
                            emptyText: 'Данного тега нет',

                            decoration: TextFieldDecoration(
                              prefixIcon: PrefixIconTextField(
                                  color: Color(0xFF546eff),
                                  icon: iconEmail),

                              suffixIcon: Transform.rotate(
                                angle: -90 * math.pi / 180,
                                child: Icon(
                                    Icons.arrow_back_ios, color: Blue),
                              ),
                            ).InputDecor(),

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

            /// DETAILS
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextMethod('Организационные детали'),

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
                              ).InputDecor()
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
                      RichTextMethod('Дополнительные услуги'),

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
                              ).InputDecor()
                          )
                      )
                    ]
                )
            ),

            ///DATES
            Container(margin: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichTextMethod("Даты",true),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              20)),
                          color: White,
                          boxShadow: [ShadowForContainer()],
                          border: datesError[0] ? Border.all(color: Red) : Border.all(color: White)
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 0),
                      child: SfDateRangePicker(
                        initialSelectedRanges: this.dates,
                        showActionButtons: true,
                        enablePastDates : false,
                        cancelText: "Отчистить",
                        confirmText: "Ок",
                        monthViewSettings: DateRangePickerMonthViewSettings(
                            firstDayOfWeek: 1,
                            dayFormat: 'EEE'
                        ),
                        selectionMode: DateRangePickerSelectionMode.multiRange,
                        onSelectionChanged: (
                            DateRangePickerSelectionChangedArgs args) {
                          setState(() {
                            List<PickerDateRange> dates = [];
                            args.value.forEach((date) {
                              dates.add(PickerDateRange(
                                  date.startDate, date.endDate));
                            });
                            this.datesError[0] = false;
                            this.dates = dates;
                          });
                        },
                        onCancel: () => setState(() => this.dates.clear()),
                        todayHighlightColor: Blue,
                        startRangeSelectionColor: Blue,
                        toggleDaySelection: true,
                        selectionColor:Blue,
                        endRangeSelectionColor: Blue,
                        rangeSelectionColor: Color(0xFFc0ceff),
                      ),
                    ),
                    datesError[0] ?
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 15),
                        child: RichText(text: TextSpan(text: datesError[1]
                            .toString(), style: Montserrat(
                            size: 13, color: Red)),)
                    ) : Container()
                  ],
                )
            ),

            ///PHOTOS
            Container(margin: EdgeInsets.only(top: 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichTextMethod("Фотографии"),
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
                                        return ShowDialog();
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

    //время только пустое

    print(dates);
    if(dates.isEmpty){
      setState(()=>datesError = [true,"Выберите дату"]);
      errorText += "Выберите дату\n";
      lines++;
    }

    if(errorText == "") showTopSnackBar(context, CustomSnackBar.success(message:"Ваша экскурсия была добавлена в модерацию",textStyle: Montserrat(size: 15)));
    else showTopSnackBar(context, CustomSnackBar.error(message:errorText,textStyle: Montserrat(size: 15),lines: lines));
  }

List<Widget> PhotosList(){
  ///КНОПКА ДОБАВИТЬ ФОТО
  List<Widget> photos = [
    TextButton(onPressed:()async{
      final List<XFile>? selectedImages = await _picker.pickMultiImage();
      if (selectedImages!.isNotEmpty) setState(()=>imageList!.addAll(selectedImages));;
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
}