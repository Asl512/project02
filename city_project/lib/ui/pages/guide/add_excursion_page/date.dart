import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Дата и время', required: true),
          StoreConnector<AppState, InsertExcursionState>(
            converter: (store) => store.state.insertExcursionState,
            builder: (context, storeInsert) {
              if (storeInsert.type!.id == '1' || storeInsert.type!.id == '2') {
                return const _DateAndTime();
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

class _DateAndTime extends StatelessWidget {
  const _DateAndTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _Date(),
            _Time()
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
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('Добавить', style: Montserrat(color: White)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Time extends StatefulWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  State<_Time> createState() => _TimeState();
}

class _TimeState extends State<_Time> {
  late MaskTextInputFormatter maskTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maskTime = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFieldWithShadow(
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [maskTime],
          style: Montserrat(color: Blue, size: 15),
          decoration: TextFieldDecoration(
            hintText: "13:00",
          ).inputDecoration,
        ),
      ),
    );
  }
}


class _Date extends StatefulWidget {
  const _Date({Key? key}) : super(key: key);

  @override
  State<_Date> createState() => _DateState();
}

class _DateState extends State<_Date> {
  late MaskTextInputFormatter maskDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maskDate = MaskTextInputFormatter(
      mask: '##.##.####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFieldWithShadow(
        TextFormField(
          keyboardType: TextInputType.number,
          style: Montserrat(color: Blue, size: 15),
          inputFormatters: [maskDate],
          decoration: TextFieldDecoration(
            hintText: "19.05.2022",
            prefixIcon: PrefixIconTextField(
              color: const Color(0xffff54c5),
              icon: iconLocation,
            ),
          ).inputDecoration,
        ),
      ),
    );
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
