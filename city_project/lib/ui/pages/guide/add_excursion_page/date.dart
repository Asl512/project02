import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';

class DateOnWeek extends StatelessWidget {
  const DateOnWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        TextFormField(),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100, 1, 1),
                );

                if (date != null) {}
              },
              splashColor: Blue,
            ),
          ),
        ),
      ],
    );
  }
}

class DateFixed extends StatelessWidget {
  const DateFixed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('fixed date');
  }
}

class DateIndividual extends StatelessWidget {
  const DateIndividual({Key? key}) : super(key: key);

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

class ErrorDate extends StatelessWidget {
  const ErrorDate({Key? key}) : super(key: key);

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
