import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'dart:math' as math;

class PublishWidget extends StatefulWidget {
  const PublishWidget({Key? key}) : super(key: key);

  @override
  State<PublishWidget> createState() => _PublishWidgetState();
}

class _PublishWidgetState extends State<PublishWidget> {
  late String publish = '6 месяцев';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        if (storeInsert.type!.id == '1' || storeInsert.type!.id == '3') {
          return Container(
            margin: const EdgeInsets.only(top: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const TitleTextFormField(text: 'Публиковать на протяжении', required: true),
              TextFieldWithShadow(
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
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
                          color: const Color(0xFF409dcf),
                          icon: Center(child: iconPublication),
                        ),
                        Text(
                          publish,
                          style: Montserrat(color: Blue, size: 15),
                        ),
                      ],
                    ),
                    items: dropdownItem(),
                    onChanged: (value) {
                      setState(() => publish = (value as String));
                    },
                  ),
                ),
              )
            ]),
          );
        }
        return Container();
      },
    );
  }

  List<DropdownMenuItem<String>> dropdownItem() {
    List<DropdownMenuItem<String>> list = [];
    final List<String> listPublish = ['6 месяцев', '1 месяц'];
    for (int i = 0; i < listPublish.length; i++) {
      list.add(
        DropdownMenuItem<String>(
          value: listPublish[i],
          child: Text(listPublish[i], style: Montserrat(color: Blue, size: 15, style: SemiBold)),
        ),
      );
    }
    return list;
  }
}

class DurationWidget extends StatefulWidget {
  final ControllerNewExcursion controller;

  const DurationWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DurationWidget> createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<DurationWidget> {
  late int duration = widget.controller.duration;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithShadow(
      DropdownButtonHideUnderline(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: DropdownButton2(
            dropdownWidth: MediaQuery.of(context).size.width * 0.43,
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
                  color: const Color(0xFFffb05a),
                  icon: const Icon(
                    Icons.access_time_outlined,
                    color: White,
                  ),
                ),
                Text(
                  duration.toString(),
                  style: Montserrat(color: Blue, size: 15),
                ),
              ],
            ),
            items: dropdownItem(),
            onChanged: (value) {
              setState(() => duration = (value as int));
              widget.controller.duration = (value as int);
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> dropdownItem() {
    List<DropdownMenuItem<int>> list = [];
    final List<int> listDuration = [1, 2, 3, 4, 5, 6];
    for (int i = 0; i < listDuration.length; i++) {
      list.add(
        DropdownMenuItem<int>(
          value: listDuration[i],
          child: Text(
            listDuration[i].toString(),
            style: Montserrat(color: Blue, size: 15, style: SemiBold),
          ),
        ),
      );
    }
    return list;
  }
}

class TypeDurationWidget extends StatefulWidget {
  final ControllerNewExcursion controller;

  const TypeDurationWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TypeDurationWidget> createState() => _TypeDurationWidgetState();
}

class _TypeDurationWidgetState extends State<TypeDurationWidget> {
  late String durationType = widget.controller.durationType;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithShadow(
      DropdownButtonHideUnderline(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: DropdownButton2(
            dropdownWidth: MediaQuery.of(context).size.width * 0.43,
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
                  color: const Color(0xFFffb05a),
                  icon: Center(child: iconChoice)
                ),
                Text(
                  durationType,
                  style: Montserrat(color: Blue, size: 15),
                ),
              ],
            ),
            items: dropdownItem(),
            onChanged: (value) {
              setState(() => durationType = (value as String));
              widget.controller.durationType = (value as String);
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropdownItem() {
    List<DropdownMenuItem<String>> list = [];
    final List<String> listDuration = ['час', 'дней'];
    for (int i = 0; i < listDuration.length; i++) {
      list.add(
        DropdownMenuItem<String>(
          value: listDuration[i],
          child: Text(
            listDuration[i],
            style: Montserrat(color: Blue, size: 15, style: SemiBold),
          ),
        ),
      );
    }
    return list;
  }
}
