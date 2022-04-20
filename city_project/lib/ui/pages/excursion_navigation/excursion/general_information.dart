import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking_page.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';

class GeneralInformationExcursion extends StatelessWidget {
  const GeneralInformationExcursion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [ShadowForContainer()],
              color: White,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        store.state.excursionInfoState.type!.name.split(' ').first + " экскурсия",
                        style: Montserrat(size: 16, style: Bold),
                      ),
                      Text(
                        store.state.excursionInfoState.excursion!.duration,
                        style: Montserrat(size: 16),
                      )
                    ],
                  ),
                ),
                const _BlockInformation(),
                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Blue.withOpacity(0.5),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "₽ " + 1200.toString(),
                          style: Montserrat(style: Bold, size: 17, color: Blue)),
                      TextSpan(
                        text: " за человека",
                        style: Montserrat(size: 16, color: Blue),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ButtonWidget(
                    text: "Бронировать",
                    buttonColor: Red,
                    padding: 0,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookingPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [ShadowForContainer()],
                color: Blue,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10))),
            child: Column(
              children: [
                if (store.state.excursionInfoState.excursion!.moment)
                  _Status(
                    icon: iconLightning,
                    title: "Мгновенное бронирование",
                    description: "Без ожидания ответа от гида",
                  )
                else
                  const _Status(
                    icon: Icon(Icons.access_time_rounded, color: Red),
                    title: "Ожидание",
                    description: "Вы должны будете ожидать ответа гида",
                  ),
                const SizedBox(height: 10),
                const _Status(
                  icon: Icon(
                    Icons.check,
                    color: Red,
                  ),
                  title: "Экскурсия подтверждена",
                  description: "Эта экскурсия проходила успешно более 5 раз",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BlockInformation extends StatelessWidget {
  const _BlockInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Тип передвижения:',
              style: Montserrat(size: 14, style: SemiBold),
            ),
            SizedBox(
              child: StoreConnector<AppState, ExcursionInfoState>(
                converter: (store) => store.state.excursionInfoState,
                builder: (context, store) {
                  if (store.typesMove.isNotEmpty) {
                    return Text(
                      store.typesMove.map((typeMove) => typeMove.name).toList().join(', '),
                      style: Montserrat(size: 14),
                    );
                  } else {
                    return Text(
                      '---',
                      style: Montserrat(size: 14),
                    );
                  }
                },
              ),
              width: MediaQuery.of(context).size.width / 2 - 40,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Размер группы:',
              style: Montserrat(size: 14, style: SemiBold),
            ),
            SizedBox(
              child: Text(
                'до ' + store.state.excursionInfoState.excursion!.groupSize.toString() + " человек",
                style: Montserrat(size: 14),
              ),
              width: MediaQuery.of(context).size.width / 2 - 40,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            'Точное место встречи и контакты гида вы узнаете сразу после бронирования.',
            style: Montserrat(size: 14, style: Regular),
          ),
        ),
      ],
    );
  }
}

class _Status extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;

  const _Status({
    Key? key,
    required this.description,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: icon,
        ),
        Column(
          children: [
            Text(
              title,
              style: Montserrat(style: Bold, size: 14, color: White),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                description,
                style: Montserrat(size: 13, color: White),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
      ],
    );
  }
}
