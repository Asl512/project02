import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'dart:math' as math;

import 'package:redux/redux.dart';

class TypeExcursionSelect extends StatefulWidget {
  final ControllerNewExcursion controller;

  const TypeExcursionSelect({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TypeExcursionSelect> createState() => _TypeExcursionSelectState();
}

class _TypeExcursionSelectState extends State<TypeExcursionSelect> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const TitleTextFormField(text: 'Выберите тип экскурсии', required: true),
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
                    padding: const EdgeInsets.all(10),
                    child: Transform.rotate(
                      angle: -90 * math.pi / 180,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Blue,
                        size: 20,
                      ),
                    ),
                  ),
                  hint: Row(
                    children: [
                      PrefixIconTextField(
                        color: const Color(0xFF42cec0),
                        icon: Center(child: iconTypeExcursion),
                      ),
                      Text(
                        nameType(widget.controller.type.name),
                        style: Montserrat(color: Blue, size: 15),
                      ),
                    ],
                  ),
                  items: dropdownItem(),
                  onChanged: (type) {
                    _store.dispatch(ChangeTypeInsetExcursionAction(type: type as TypeEntity));
                    widget.controller.type = type;
                    if (type.id == '3') {
                      widget.controller.moment = false;
                    }
                  },
                ),
              ),
            )
          ]),
        );
      },
    );
  }

  String nameType(String name) {
    late String result = name;
    if (name.length > 24) {
      result = name.split('').sublist(0, 24).join() + '...';
    }
    return result;
  }

  List<DropdownMenuItem<TypeEntity>> dropdownItem() {
    List<DropdownMenuItem<TypeEntity>> list = [];
    final List<TypeEntity> _types = _store.state.addExcursionState.types;
    for (int i = 0; i < _types.length; i++) {
      list.add(
        DropdownMenuItem<TypeEntity>(
          value: _types[i],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_types[i].name, style: Montserrat(color: Blue, size: 15, style: SemiBold)),
              Text(_types[i].description, style: Montserrat(color: Blue, size: 13)),
            ],
          ),
        ),
      );
    }
    return list;
  }
}

enum RadioButtonMoment { manually, moment }

class BookingConfirmationWidget extends StatefulWidget {
  final ControllerNewExcursion controller;

  const BookingConfirmationWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<BookingConfirmationWidget> createState() => _BookingConfirmationWidgetState();
}

class _BookingConfirmationWidgetState extends State<BookingConfirmationWidget> {
  RadioButtonMoment? radio = RadioButtonMoment.manually;

  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Подтверждение брони', required: true),
          StoreConnector<AppState, InsertExcursionState>(
            converter: (store) => store.state.insertExcursionState,
            builder: (context, storeInsert) {
              if (storeInsert.type!.id == '1' || storeInsert.type!.id == '2') {
                return Column(
                  children: [
                    _ManuallyListTile(
                      radio: radio,
                      func: (RadioButtonMoment? value) {
                        setState(() => radio = value);
                        widget.controller.moment = false;
                      },
                    ),
                    if (_store.state.authState.user!.countCompleted < 5)
                      _BlockedMomentListTile(
                        radio: radio,
                      )
                    else
                      _MomentListTile(
                        radio: radio,
                        func: (RadioButtonMoment? value) {
                          setState(() => radio = value);
                          widget.controller.moment = true;
                        },
                      ),
                    if (_store.state.authState.user!.countCompleted < 5)
                      _WarningMoment(count: _store.state.authState.user!.countCompleted)
                  ],
                );
              } else if (storeInsert.type!.id == '3') {
                radio = RadioButtonMoment.manually;
                return const _ManuallyListTile(radio: RadioButtonMoment.manually);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _MomentListTile extends StatelessWidget {
  final RadioButtonMoment? radio;
  final void Function(RadioButtonMoment?) func;

  const _MomentListTile({
    Key? key,
    required this.radio,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<RadioButtonMoment>(
      title: Text(
        "Моментальное бронирование.",
        style: Montserrat(color: Blue, size: 15, style: SemiBold),
      ),
      subtitle: Text(
        'Путешественники могут оплатить заказ только после вашего подтверждения.',
        style: Montserrat(color: Blue, size: 13),
      ),
      value: RadioButtonMoment.moment,
      groupValue: radio,
      onChanged: func,
      contentPadding: const EdgeInsets.symmetric(horizontal: -20),
      activeColor: Blue,
    );
  }
}

class _BlockedMomentListTile extends StatelessWidget {
  final RadioButtonMoment? radio;

  const _BlockedMomentListTile({
    Key? key,
    required this.radio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<RadioButtonMoment>(
      title: Text(
        "Моментальное бронирование.",
        style: Montserrat(color: Colors.grey, size: 15, style: SemiBold),
      ),
      subtitle: Text(
        'Путешественники могут оплатить заказ только после вашего подтверждения.',
        style: Montserrat(color: Colors.grey, size: 13),
      ),
      value: RadioButtonMoment.moment,
      groupValue: radio,
      onChanged: null,
      contentPadding: const EdgeInsets.symmetric(horizontal: -20),
      activeColor: Blue,
    );
  }
}

class _ManuallyListTile extends StatelessWidget {
  final RadioButtonMoment? radio;
  final void Function(RadioButtonMoment?)? func;

  const _ManuallyListTile({
    Key? key,
    required this.radio,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<RadioButtonMoment>(
      title: Text(
        "Подтверждение заказа вручную.",
        style: Montserrat(color: Blue, size: 15, style: SemiBold),
      ),
      subtitle: Text(
        'Путешественники могут оплатить заказ только после вашего подтверждения.',
        style: Montserrat(color: Blue, size: 13),
      ),
      value: RadioButtonMoment.manually,
      groupValue: radio,
      onChanged: func ?? (RadioButtonMoment? value) {},
      contentPadding: const EdgeInsets.symmetric(horizontal: -20),
      activeColor: Blue,
    );
  }
}

class _WarningMoment extends StatelessWidget {
  final int count;

  const _WarningMoment({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Чтобы использовать моментальное бронирование, проведите не менее 5 экскурсий. Пока вы провели $count",
        style: Montserrat(color: Red.withOpacity(0.5), size: 11, style: SemiBold),
      ),
    );
  }
}
