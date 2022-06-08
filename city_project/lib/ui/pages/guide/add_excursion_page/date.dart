import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DateWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const DateWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Дата и время (AM)', required: true),
          StoreConnector<AppState, InsertExcursionState>(
            converter: (store) => store.state.insertExcursionState,
            builder: (context, storeInsert) {
              if (storeInsert.type!.id == '1' || storeInsert.type!.id == '2') {
                return _DateAndTime(controller: controller);
              } else if (storeInsert.type!.id == '3') {
                return const _DateIndividual();
              } else {
                return const _ErrorDate();
              }
            },
          )
        ],
      ),
    );
  }
}

class _DateAndTime extends StatefulWidget {
  final ControllerNewExcursion controller;

  const _DateAndTime({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<_DateAndTime> createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<_DateAndTime> {
  late List<String> dates = [];
  late TextEditingController dateController;
  late TextEditingController timeController;

  late MaskTextInputFormatter maskDate;
  late MaskTextInputFormatter maskTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dateController = TextEditingController();
    timeController = TextEditingController();
    dateController.text = '';
    timeController.text = '';
    maskDate = MaskTextInputFormatter(
      mask: '##.##.####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    maskTime = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextFieldWithShadow(
                TextFormField(
                  controller: dateController,
                  keyboardType: TextInputType.number,
                  style: Montserrat(color: Blue, size: 15),
                  inputFormatters: [maskDate],
                  decoration: TextFieldDecoration(
                    hintText: "19.05.2022",
                    prefixIcon: PrefixIconTextField(
                      color: const Color(0xFFc25cf2),
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        color: White,
                        size: 25,
                      ),
                    ),
                  ).inputDecoration,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextFieldWithShadow(
                TextFormField(
                  controller: timeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [maskTime],
                  style: Montserrat(color: Blue, size: 15),
                  decoration: TextFieldDecoration(
                    hintText: "13:00",
                  ).inputDecoration,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerRight,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Blue,
            ),
            child: TextButton(
              onPressed: valid,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Добавить', style: Montserrat(color: White)),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dates.map((date) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Blue,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      date,
                      style: Montserrat(size: 15, color: White),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        dates.removeWhere((element) => element == date);
                        widget.controller.dates = dates;
                      });
                    },
                    icon: const Icon(Icons.clear, color: White),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void valid() {
    String errorText = '';
    if (dateController.text == '' ||
        timeController.text == '' ||
        dateController.text.length != 10 ||
        timeController.text.length != 5) {
      errorText = 'Заполните поля';
    } else {
      int hours = 0;
      int minutes = 0;
      try {
        List time = timeController.text.split(':');
        hours = int.parse(time.first);
        minutes = int.parse(time.last);
        if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
          errorText = 'Не коректное время';
        }
      } catch (e) {
        errorText = e.toString();
      }
      if (errorText == '') {
        try {
          List data = dateController.text.split('.');
          DateTime date = DateTime(
            int.parse(data.last),
            int.parse(data[1]),
            int.parse(data.first),
            hours,
            minutes,
          );
          DateTime now = DateTime.now();
          DateTime lastDate = DateTime(2023, 12, 30);
          if (date.millisecondsSinceEpoch > lastDate.millisecondsSinceEpoch) {
            errorText = 'Не коректная дата';
          } else if (date.millisecondsSinceEpoch + 10 <= now.millisecondsSinceEpoch) {
            errorText = 'Дата уже не действительна';
          }
        } catch (e) {
          errorText = e.toString();
        }
      }
    }
    if (errorText == '') {
      List have = dates
          .where((element) => element == dateController.text + ' - ' + timeController.text)
          .toList();
      if (have.isNotEmpty) {
        errorText = 'Дата уже существует';
      }
    }

    if (errorText == '') {
      setState(() {
        dates.add(dateController.text + ' - ' + timeController.text);
        widget.controller.dates = dates;
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: errorText,
          textStyle: Montserrat(size: 15, color: White),
        ),
      );
    }
  }
}

class _DateIndividual extends StatelessWidget {
  const _DateIndividual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Blue,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      height: 50,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          'Дату и время устанавливает клиент',
          style: Montserrat(size: 15, color: White),
        ),
      ),
    );
  }
}

class _ErrorDate extends StatelessWidget {
  const _ErrorDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Red,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      height: 50,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          'Ошибка вывода даты и времени',
          style: Montserrat(size: 15, color: White),
        ),
      ),
    );
  }
}
