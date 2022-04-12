import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/backButtons.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


class Booking extends StatefulWidget
{

  const Booking(this.id, this.data, this.gid, this.type,{Key? key,}) : super(key: key);

  final String? id;
  final DocumentSnapshot? data;
  final DocumentSnapshot? gid;
  final DocumentSnapshot? type;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? date;
  int? countTickets;
  int? countSpecialTickets;

  List countTicketsError = [false,"countTicketsError"];
  List dateError = [false,"datesError"];


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    int justTicket = countTickets??0;
    double specialTicket = (countSpecialTickets??0)/2;
    double tikets = justTicket + specialTicket;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight:MediaQuery.of(context).size.height / 5,
            flexibleSpace: Stack(alignment: AlignmentDirectional.topStart,
              children: [
                Stack(alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Stack(children: [
                      Image.network(widget.data!['photo'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Placholder(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(excursionDef,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height
                          );
                        },
                      ),
                      Container(width: double.infinity, height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5))
                      ),
                      Container(alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text(widget.data!['name'].toString().toUpperCase(),
                                  style: Montserrat(color: White, size: 25, style: Bold))),
                            ],
                          )
                      )
                    ]),

                    ///АВТОР
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                        children:[
                          Container(height: 50,
                              padding: EdgeInsets.symmetric(horizontal:20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Text("Бронирование",style: Montserrat(size: 15,style: SemiBold))
                          )
                        ])
                  ],
                ),
                ButtonBack(color: Colors.black.withOpacity(0.5))
              ],),
            centerTitle: false,
            titleSpacing: 0.0,
            leading: Container(),
          ),
          SliverList(delegate:SliverChildListDelegate([
            Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///ТЕКСТ О БРОНИ
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Оплата происходит только за бронь, 20% от полной стоимости билета. ",
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

                  /// COUNT TICKETS
                  Container(margin: EdgeInsets.only(top: 30),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                        TitleTextFormField(text: 'Количество билетов', required: true),

                        TextFieldWithShadow(
                            TextFormField(
                              initialValue: countTickets != null ? countTickets.toString() : "",
                                maxLength: 2,
                                keyboardType: TextInputType.number,
                                style: Montserrat(color: Blue, size: 15),
                                onChanged: (String value) {
                                  setState(() {
                                    countTicketsError[0] = false;
                                    if(value == '')this.countTickets = 0;
                                    else this.countTickets = int.parse(value);
                                  });
                                },
                                decoration: TextFieldDecoration(
                                  hintText: "Сколько вас будет",
                                  prefixIcon: PrefixIconTextField(color: Color(0xFFff645a), icon: iconEmail),
                                ).inputDecoration
                            ),
                          errorText: true,
                          error: countTicketsError
                        ),
                      ])
                  ),

                  //переделать в зависимости от добавлений (как в добавлении)
                  ///COUNT SPECIAL TICKETS
                  Container(margin: EdgeInsets.only(top: 30),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                        TitleTextFormField(text:'Количество специальных билетов'),

                        TextFieldWithShadow(
                            TextFormField(
                              initialValue: countSpecialTickets != null ? countSpecialTickets.toString() : "",
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                                style: Montserrat(color: Blue, size: 15),
                                onChanged: (String value) {
                                  setState((){
                                    if(value == '')this.countSpecialTickets = 0;
                                    else this.countSpecialTickets = int.parse(value);
                                  });
                                },
                                decoration: TextFieldDecoration(
                                  hintText: "Сколько вас будет",
                                  prefixIcon: PrefixIconTextField(color: Color(0xFFffaf5a), icon: iconEmail),
                                ).inputDecoration
                            )
                        ),
                      ])
                  ),

                  ///ВРЕМЯ


                  ///ТЕЛЕФОН


                  //вывод оставшихся мест
                  ///DATES
                  Container(margin: EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleTextFormField(text: "Даты",required: true),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    20)),
                                color: White,
                                boxShadow: [ShadowForContainer()],
                                border: dateError[0] ? Border.all(color: Red) : Border.all(color: White)
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            child: SfDateRangePicker(
                              view: DateRangePickerView.month,
                              monthViewSettings: DateRangePickerMonthViewSettings(
                                  firstDayOfWeek: 1,
                                  dayFormat: 'EEE'
                              ),
                              selectableDayPredicate: (DateTime dateTime) {
                                DateTime start = DateTime(2022, 03, 03);
                                DateTime end = DateTime(2022, 03, 25);
                                if (dateTime.isAfter(start) && dateTime.isBefore(end)) return true;
                                return false;
                              },
                              enablePastDates : false,
                              initialSelectedDate: this.date,
                              selectionMode: DateRangePickerSelectionMode.single,
                              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                setState(() {
                                  this.dateError[0] = false;
                                  this.date = args.value;
                                });
                              },
                              selectionColor:Blue,
                              todayHighlightColor: Blue,
                            ),
                          ),
                          dateError[0] ?
                          Container(
                              margin: EdgeInsets.only(top: 10, left: 15),
                              child: RichText(text: TextSpan(text: dateError[1].toString(), style: Montserrat(size: 13, color: Red)),)
                          ) : Container()
                        ],
                      )
                  ),

                  tikets > 0?
                      Column(
                        children: [
                          Container(height: 0.3,
                              margin: EdgeInsets.only(top: 40),
                              width: double.infinity,
                              color: Blue
                          ),
                          Container(margin: EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  ///бронь, сколько должен гиду, итого
                                  ReturnInfoPrice(title: 'Итого:',ticket: tikets,factor: widget.data!["price"]),
                                  ReturnInfoPrice(title: 'Бронь:',ticket: tikets,factor: (widget.data!["price"]/100*20).round(),),
                                ],
                              )
                          )
                        ],
                      ) :Container(),


                  ///КНОПКА КУПИТЬ
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
                                      borderRadius: BorderRadius.all(Radius.circular(500))),
                                  child: Center(child: Text("Купить",
                                      style: Montserrat(style: SemiBold, size: 19)),)
                              )
                          ),

                          ///ТЕКСТ О ПЛАТЕЖЕ
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Оплатить бронь вы сможете только после разрешения гида. ",
                                    style: Montserrat(size: 12, color: Blue),
                                  ),
                                  TextSpan(text: "Подробнее.", style: Montserrat(style: SemiBold, size: 13, color: Red),
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
            )
          ]))
        ],
      ),
    );
  }
  void Validation(){
    String errorText = "";
    int lines = 0;
    if(this.countTickets == null){
      setState(()=>this.countTicketsError = [true,"Введите количество билетов"]);
      errorText += "Введите количество билетов\n";
      lines++;
    }
    else if(this.countTickets! < 0){
      setState(()=>this.countTicketsError = [true,"Количество билетов должно быть больше 1-го"]);
      errorText += "Количество билетов должно быть больше 1-го\n";
      lines++;
    }
    else if(this.countTickets! > 10){
      setState(()=>this.countTicketsError = [true,"Вы можете забронировать не больше 10 билетов"]);
      errorText += "Вы можете забронировать не больше 10 билетов\n";
      lines++;
    }
    //проверка на оставщиеся места

    if(this.date == null){
      setState(()=>this.dateError = [true,"Выберите дату"]);
      errorText += "Выберите дату\n";
      lines++;
    }

    if(errorText == "") showTopSnackBar(context, CustomSnackBar.success(message:"Вы купили экскурсию",textStyle: Montserrat(size: 15)));
    else showTopSnackBar(context, CustomSnackBar.error(message:errorText,textStyle: Montserrat(size: 15),lines: lines));
  }
}

class ReturnInfoPrice extends StatelessWidget {
  final String title;
  double price = 0;
  ReturnInfoPrice({required this.title,required double ticket,int factor = 1}){
    this.price = ticket*factor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.title, style: Montserrat(color: Blue,size: 20)),
          Text("₽ "+ this.price.toStringAsFixed(1), style: Montserrat(color: Blue,size: 20,style: Bold)),
        ]
    );
  }
}

class TagsList {
  final String name;
  final String id;

  const TagsList(this.name, this.id,);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TagsList &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return id;
  }
}
