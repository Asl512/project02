import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'dart:math' as math;

import 'package:redux/redux.dart';

class StandardPriceWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const StandardPriceWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Стандартный билет', required: true),
          StoreConnector<AppState, InsertExcursionState>(
            converter: (store) => store.state.insertExcursionState,
            builder: (context, storeInsert) {
              return TextFieldWithShadow(
                TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    style: Montserrat(color: Blue, size: 15),
                    onChanged: (String value) {
                      controller.standardPrice.text = value.trim();
                    },
                    decoration: TextFieldDecoration(
                      hintText: "Введите стоимость билета",
                      prefixIcon: PrefixIconTextField(
                        color: const Color(0xFFf3cb3b),
                        icon: Center(
                          child: Text(
                            (_store.state.insertExcursionState.currency?.sign)??'0',
                            style: Montserrat(style: Bold, color: White, size: 22),
                          ),
                        ),
                      ),
                    ).inputDecoration),
                error: storeInsert.errorStandardPrice,
                errorText: true,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CurrencySelect extends StatefulWidget {
  final ControllerNewExcursion controller;

  const CurrencySelect({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CurrencySelect> createState() => _CurrencySelectState();
}

class _CurrencySelectState extends State<CurrencySelect> {
  late CurrencyEntity currency = widget.controller.currency;
  late Store<AppState> _store;
  late List<CurrencyEntity> listCurrency;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextFormField(text: 'Валюта'),
        TextFieldWithShadow(
          DropdownButtonHideUnderline(
            child: SizedBox(
              child: DropdownButton2(
                style: Montserrat(color: Blue, size: 15),
                isExpanded: true,
                buttonWidth: double.infinity,
                itemHeight: 50,
                buttonHeight: 50,
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: White,
                ),
                icon: Container(
                  padding: const EdgeInsets.all(10),
                  child: Transform.rotate(
                    angle: -90 * math.pi / 180,
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Blue,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                hint: Row(
                  children: [
                    PrefixIconTextField(
                      color: const Color(0xFFf3cb3b),
                      icon: const Icon(
                        Icons.currency_exchange,
                        color: White,
                      ),
                    ),
                    Text(
                      currency.name,
                      style: Montserrat(color: Blue, size: 15),
                    ),
                  ],
                ),
                items: dropdownItem(),
                onChanged: (value) {
                  _store.dispatch(
                    ChangeCurrencyInsetExcursionAction(currency: value as CurrencyEntity),
                  );
                  setState(() => currency = value);
                  widget.controller.currency = value;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<CurrencyEntity>> dropdownItem() {
    List<DropdownMenuItem<CurrencyEntity>> list = [];
    listCurrency = _store.state.addExcursionState.currencies;
    for (int i = 0; i < listCurrency.length; i++) {
      list.add(
        DropdownMenuItem<CurrencyEntity>(
          value: listCurrency[i],
          child: Text(
            listCurrency[i].name,
            style: Montserrat(color: Blue, size: 15, style: SemiBold),
          ),
        ),
      );
    }
    return list;
  }
}
