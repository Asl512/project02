import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'functionsAddExcursion.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../assets/style.dart';
import '../../assets/finally.dart';
import '../../assets/text.dart';
import '../../assets/data.dart';

class AddExcursion extends StatefulWidget
{
  const AddExcursion({Key? key}) : super(key: key);


  @override
  State<AddExcursion> createState() => _AddExcursionState();
}

class _AddExcursionState extends State<AddExcursion> {

  String name = '';
  List errorName = [false,'errorName'];
  String pay = '';
  List errorPay = [false,'errorPay'];
  String start = '';
  List errorStart = [false,'errorStart'];
  int _selectType = -1;
  List errorMove = [false,'errorMove'];
  int _selectMove = -1;
  List errorType = [false,'errorType'];
  int _selectCity = -1;
  List errorCity = [false,'errorCity'];
  int _selectLang = -1;
  List errorLang = [false,'errorLang'];
  int countPeaple = 0;
  List errorcountPeaple = [false,'errorcountPeaple'];
  String dateFormat = textInputDate;
  DateTime date = DateTime.now();
  List errorDate = [false,'errorDate'];
  String timeStartFormate = textInputTime;
  DateTime timeStart = DateTime.now();
  List errortimeStart = [false,'errortimeStart'];
  String timeEndFormate = textInputTime;
  DateTime timeEnd = DateTime.now();
  List errortimeEnd = [false,'errortimeEnd'];
  String description = '';

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


        appBar: PreferredSize(preferredSize: Size.fromHeight(heigthBar),
            child: AppBar(flexibleSpace: Image(image: AssetImage(imgBackCity),
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
                    alignment: Alignment.center,
                    child: Text(textAddExcursion.toUpperCase(),style: Montserrat(style:SemiBold,size: 18)),
                  )
                ]),
                  preferredSize: Size.fromHeight(50),)
            )
        ),

        ///ТЕЛО
        body: ListView(padding: EdgeInsets.zero,
                children: [

                  ///НАЗВАНИЕ
                  Container(height: 120,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TitleText(textSelectName),
                            Stack(children: [
                              Shadow(50,500), // ТЕНЬ
                              TextField(style: Montserrat(color:White,size: 15),
                                  onChanged: (String value)
                                  {setState(() {
                                    name = value;
                                    errorName[0] = false;
                                  });},
                                  decoration: StyleTextField(textInputName,errorName)
                              )
                            ])
                      ])
                  ),

                  ///ТИП
                  Selectd(errorType,
                      textSelectType,
                      DropdownButton(
                        underline: Container(),
                        icon: Container(margin: EdgeInsets.only(right: 10),
                            child: iconArrowBottomWhite
                        ),
                        dropdownColor: Green,
                        isExpanded: true,
                        hint: Text(textInputType,style: Montserrat(size: 15)),
                        value: _selectType == -1?null:_selectType,
                        items: Select(dataTypeExcurs,errorType),
                        onChanged: (int? value) {
                          setState(() {
                            _selectType = value!;
                          });},
                        style: Montserrat(size: 15),
                      )
                  ),

                  ///ГОРОД
                  Selectd(errorCity,
                      textSelectCity,
                      DropdownButton(
                        underline: Container(),
                        icon: Container(margin: EdgeInsets.only(right: 10),
                            child: iconArrowBottomWhite
                        ),
                        dropdownColor: Green,
                        isExpanded: true,
                        hint: Text(textInputCity,style: Montserrat(size: 15)),
                        value: _selectCity == -1?null:_selectCity,
                        items: Select(selectDataCity(),errorCity),
                        onChanged: (int? value) {
                          setState(() {
                            _selectCity = value!;
                          });},
                        style: Montserrat(size: 15),
                      )
                  ),

                  ///КОЛИЧЕСТВО ЧЕЛОВЕК
                  Container(height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TitleText(textSelectCountPeaple),
                            Stack(children: [
                              Shadow(50,500), // ТЕНЬ
                              Container(width: double.infinity,height: 50,
                                decoration: BoxDecoration(color: Green,
                                    border: Border.all(color: errorcountPeaple[0]?Red:Green),
                                borderRadius: BorderRadius.circular(500)),
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(margin: EdgeInsets.only(left: 10),
                                    child: IconButton(
                                      icon: Transform.rotate(
                                          angle: 3.14,
                                          child:iconArrowBottomWhite),
                                      onPressed: ()
                                      {
                                        setState(()
                                        {countPeaple++;
                                        errorcountPeaple[0] = false;});
                                      },
                                    )
                                ),
                                Text(countPeaple.toString(),style: Montserrat(color:White,size: 15),),
                                Container(margin: EdgeInsets.only(right: 10),
                                    child: IconButton(
                                      icon: iconArrowBottomWhite,
                                      onPressed: ()
                                      {
                                        if(countPeaple != 0)
                                        {
                                          setState(()
                                          {countPeaple--;
                                          errorcountPeaple[0] = false;});
                                        }
                                      },
                                    )
                                ),
                              ])
                            ]),
                            Container(margin: EdgeInsets.only(top: 10,left: 15),
                                child: Text(errorcountPeaple[0]?errorcountPeaple[1]:'',style: Montserrat(size: 15,color:Red))
                            )
                          ])
                  ),

                  ///МЕСТО ВСТРЕЧИ
                  Container(height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TitleText(textSelectStart),
                            Stack(children: [
                              Shadow(50,500), // ТЕНЬ
                              TextField(style: Montserrat(color:White,size: 15),
                                  onChanged: (String value)
                                  {setState(() {
                                    start = value;
                                    errorStart[0] = false;
                                  });},
                                  decoration: StyleTextField(textInputStart,errorStart)
                              )
                            ])
                          ])
                  ),

                  ///ДАТА
                  Container(height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TitleText(textSelectDate),
                            Stack(children: [
                              Shadow(50,500), // ТЕНЬ
                              TextButton(onPressed:(){SelectDate();},
                                  style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                  child: Container(height: 50,width: double.infinity,
                                    decoration: BoxDecoration(color: Green,
                                    borderRadius: BorderRadius.circular(500),
                                        border: Border.all(color: errorDate[0]?Red:Green)),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(margin: EdgeInsets.only(left: 15),
                                        child: Text(dateFormat,style: Montserrat(color:White,size: 15))
                                      ),
                                      Container(margin: EdgeInsets.only(right: 25),
                                          child: iconDateWhite
                                      )
                                    ]),
                              ))
                            ]),
                            Container(margin: EdgeInsets.only(top: 10,left: 15),
                                child: Text(errorDate[0]?errorDate[1]:'',style: Montserrat(size: 15,color:Red))
                            )
                          ])
                  ),

                  ///ВРЕМЯ НАЧАЛА
                  Container(height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TitleText(textSelectTimeStart),
                            Stack(children: [
                              Shadow(50,500), // ТЕНЬ
                              TextButton(onPressed:(){SelectTime(0);},
                                  style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                  child: Container(height: 50,width: double.infinity,
                                    decoration: BoxDecoration(color: Green,
                                        borderRadius: BorderRadius.circular(500),
                                        border: Border.all(color: errortimeStart[0]?Red:Green)),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(margin: EdgeInsets.only(left: 15),
                                              child: Text(timeStartFormate,style: Montserrat(color:White,size: 15))
                                          ),
                                          Container(margin: EdgeInsets.only(right: 25),
                                              child: iconTime
                                          )
                                        ]),
                                  ))
                            ]),
                            Container(margin: EdgeInsets.only(top: 10,left: 15),
                                child: Text(errortimeStart[0]?errortimeStart[1]:'',style: Montserrat(size: 15,color:Red))
                            )
                          ])
                  ),

                  ///ВРЕМЯ ОКОНЧАНИЯ
                  Container(height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TitleText(textSelectTimeEnd),
                            Stack(children: [
                              Shadow(50,500), // ТЕНЬ
                              TextButton(onPressed:(){SelectTime(1);},
                                  style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                  child: Container(height: 50,width: double.infinity,
                                    decoration: BoxDecoration(color: Green,
                                        borderRadius: BorderRadius.circular(500),
                                        border: Border.all(color: errortimeEnd[0]?Red:Green)),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(margin: EdgeInsets.only(left: 15),
                                              child: Text(timeEndFormate,style: Montserrat(color:White,size: 15))
                                          ),
                                          Container(margin: EdgeInsets.only(right: 25),
                                              child: iconTime
                                          )
                                        ]),
                                  ))
                            ]),
                            Container(margin: EdgeInsets.only(top: 10,left: 15),
                                child: Text(errortimeEnd[0]?errortimeEnd[1]:'',style: Montserrat(size: 15,color:Red))
                            )
                          ])
                  ),

                  ///ЯЗЫК
                  Selectd(errorLang,
                      textSelectLang,
                      DropdownButton(
                        underline: Container(),
                        icon: Container(margin: EdgeInsets.only(right: 10),
                            child: iconArrowBottomWhite
                        ),
                        dropdownColor: Green,
                        isExpanded: true,
                        hint: Text(textInputLang,style: Montserrat(size: 15)),
                        value: _selectLang == -1?null:_selectLang,
                        items: Select(dataLanguages,errorLang),
                        onChanged: (int? value) {
                          setState(() {
                            _selectLang = value!;
                          });},
                        style: Montserrat(size: 15),
                      ),
                      Container(width:30,height: 30,
                        margin: EdgeInsets.only(bottom: 10,right: 20),
                        decoration: BoxDecoration(color: Red,
                            borderRadius: BorderRadius.circular(500)),
                        child: IconButton(onPressed: (){},
                            icon: iconAdd
                        ),
                      )
                  ),

                  ///ПЕРЕДВИЖЕНИЯ
                  Selectd(errorMove,
                      textSelectMove,
                      DropdownButton(
                        underline: Container(),
                        icon: Container(margin: EdgeInsets.only(right: 10),
                            child: iconArrowBottomWhite
                        ),
                        dropdownColor: Green,
                        isExpanded: true,
                        hint: Text(textInputMove,style: Montserrat(size: 15)),
                        value: _selectMove == -1?null:_selectMove,
                        items: Select(dataMovement,errorMove),
                        onChanged: (int? value) {
                          setState(() {
                            _selectMove = value!;
                          });},
                        style: Montserrat(size: 15),
                      ),
                      Container(width:30,height: 30,
                        margin: EdgeInsets.only(bottom: 10,right: 20),
                        decoration: BoxDecoration(color: Red,
                            borderRadius: BorderRadius.circular(500)),
                        child: IconButton(onPressed: (){},
                            icon: iconAdd
                        ),
                      )
                  ),

                  ///ОПИСАНИЕ
                  Container(height: 160,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                          Container(margin: EdgeInsets.only(bottom: 15),
                            child: Text(textDescription,style: Montserrat(color: Black,style:SemiBold))
                          ),
                            Stack(children: [
                              Shadow(100,10), // ТЕНЬ
                              TextField(style: Montserrat(color:White,size: 15),
                                  maxLines:4,
                                  onChanged: (String value)
                                  {setState(() {
                                    description = value;
                                  });},
                                  decoration: InputDecoration(
                                    //ПОДСКАЗКА
                                      hintText: textDescriptionPlac,
                                      hintStyle: Montserrat(color:LigthGrey,size: 15),

                                      //СТИЛЬ
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(width: 0, style: BorderStyle.none)
                                      ),
                                      fillColor: Green,
                                      isDense: true,
                                      filled: true
                                  )
                              )
                            ])
                          ])
                  ),

                  ///СТОИМОСТЬ
                  Container(height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TitleText(textSelectPay),
                            Stack(children: [
                              Shadow(50,500), // ТЕНЬ
                              TextField(style: Montserrat(color:White,size: 15),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly],
                                  onChanged: (String value)
                                  {setState(() {
                                    pay = value;
                                    errorPay[0] = false;
                                  });},
                                  decoration: StyleTextField(textInputPay,errorPay)
                              )
                            ])
                          ])
                  ),

                  ///КНОПКА ПОДТВЕРДИТь
                  Container(padding: EdgeInsets.symmetric(horizontal: 106),
                      margin: EdgeInsets.only(bottom: 30),
                      child:TextButton(
                        style: TextButton.styleFrom(minimumSize: Size.fromHeight(50),
                            primary: Green,
                            backgroundColor: Green
                        ),
                        onPressed: () {
                          Validation();
                        },
                        child: Text(textConfirm.toUpperCase(), style: Montserrat(style:Bold)),
                      )
                  ),
                ])
    );
  }

  Future<dynamic> SelectDate()
  {
    return showDialog(
      context: context,
      builder: (context) {
        DateTime dateS = DateTime.now();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Container(alignment: Alignment.center,
                  child: Text(textSelectDate,style: Montserrat(color:Black, style: SemiBold,size: 22)),),
                content: Container(height: 280,
                  width: MediaQuery.of(context).size.width-60,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                    Container(height: 200,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: date,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState((){
                            dateS = newDateTime;
                          });
                        },
                      ),
                  ),

                      Container(width: MediaQuery.of(context).size.width/2, height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(color:Green, borderRadius: BorderRadius.circular(20)),
                          child:TextButton(
                            onPressed: () {
                              SelectedDate(dateS);
                              Navigator.pop(context);
                            },
                            child: Text(textReady, style: Montserrat(style:SemiBold)),
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

  void SelectedDate(DateTime newDate)
  {
    setState((){
      dateFormat = newDate.toString().split(' ')[0];
      date = newDate;
      errorDate[0] = false;
    });
  }

  Future<dynamic> SelectTime(int status)
  {
    return showDialog(
      context: context,
      builder: (context) {
        DateTime time = DateTime.now();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Container(alignment: Alignment.center,
                  child: Text(textInputTime,style: Montserrat(color:Black, style: SemiBold,size: 22)),),
                content: Container(height: 280,
                  width: MediaQuery.of(context).size.width-60,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(height: 200,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: time,
                          onDateTimeChanged: (DateTime newTime) {
                            setState((){
                              time = newTime;
                            });
                          },
                        ),
                      ),

                      Container(width: MediaQuery.of(context).size.width/2, height: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(color:Green, borderRadius: BorderRadius.circular(20)),
                          child:TextButton(
                            onPressed: () {
                              SelectedTime(time,status);
                              Navigator.pop(context);
                            },
                            child: Text(textReady, style: Montserrat(style:SemiBold)),
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

  void SelectedTime(DateTime time, int status)
  {
    List formate = time.toString().split(' ')[1].split(':');
    setState((){
      if(status == 0)
        {
          timeStartFormate = formate[0] + ':' + formate[1];
          timeStart = time;
          errortimeStart[0] = false;
        }
      else
        {
          timeEndFormate = formate[0] + ':' + formate[1];
          timeEnd= time;
          errortimeEnd[0] = false;
        }
    });
  }

  List<DropdownMenuItem<int>> Select(List select,List error)
  {
    List<DropdownMenuItem<int>> Widgets = [];
    for(int i = 0; i < select.length;i++)
    {
      Widgets.add(DropdownMenuItem(
        onTap: (){
          setState(() {
            error[0] = false;
          });
        },
          child: Text(select[i].toString()),
          value: i
      ));
    }
    return Widgets;
  }

  void Validation()
  {
    setState(() {
      bool check = false;
      if(name == '')
        {
          check = true;
          errorName = [true,'Введите название'];
        }

      if(_selectType == -1)
      {
        check = true;
        errorType= [true,'Выбирите тип'];
      }

      if(_selectCity == -1)
      {
        check = true;
        errorCity= [true,'Выбирите город'];
      }
      if(_selectLang == -1)
      {
        check = true;
        errorLang= [true,'Выбирите язык'];
      }
      if(_selectMove == -1)
      {
        check = true;
        errorMove= [true,'Выбирите способ передвижения'];
      }
      if(countPeaple < 10)
        {
          check = true;
          errorcountPeaple = [true,'Должно привышать 10'];
        }
      if(start == '')
        {
          check = true;
          errorStart = [true,'Введите место встечи'];
        }
      if(pay == '')
      {
        check = true;
        errorPay= [true,'Укажите стоимость'];
      }
      if(dateFormat == '')
        {
          check = true;
          errorDate= [true,'Выберите дату'];
        }
      else if(date.isBefore(DateTime.now()))
        {
          check = true;
          errorDate= [true,'Этот день уже прошел'];
        }

      bool checkTime = false;
      if(timeStartFormate == textInputTime)
      {
        check = true;
        checkTime = true;
        errortimeStart= [true,'Вы не выбрали время'];
      }

      if(timeEndFormate == textInputTime)
        {
          check = true;
          checkTime = true;
          errortimeEnd= [true,'Вы не выбрали время'];
        }

      if(timeStart.isAfter(timeEnd) && checkTime == false)
      {
        check = true;
        checkTime = true;
        errortimeEnd= [true,'Неправильное время окончания'];
      }

      if(check == false)
        {
          dataLangExcurs.add([dataExcursion.length,_selectLang]);
          dataMoveExcurs.add([dataExcursion.length,_selectMove]);
          dataExcursion.add([name,imgDefoultExcursion,dateFormat,timeStartFormate,timeEndFormate,
          start,countPeaple,countPeaple,pay,_selectCity,auth,_selectType,description]);
          Navigator.pushNamedAndRemoveUntil(context, '/excursionMy', (route) => false);
        }
    });
  }

}