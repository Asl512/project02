import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/dropdown.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;

class MeetPointWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const MeetPointWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextFormField(text: 'Место сбора', required: true),
              if (storeInsert.type!.id != '3')
                TextFieldWithShadow(
                  TextFormField(
                      style: Montserrat(color: Blue, size: 15),
                      maxLines: null,
                      maxLength: 100,
                      keyboardType: TextInputType.multiline,
                      onChanged: (String value) {
                        controller.meetPoint.text = value.trim();
                      },
                      decoration: TextFieldDecoration(
                        hintText: "ул. Республики 195",
                        prefixIcon:
                            PrefixIconTextField(color: const Color(0xFFff5454), icon: iconLocation),
                      ).inputDecoration),
                  error: storeInsert.errorMeetPoint,
                  errorText: true,
                )
              else
                Container(
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
                      'Место сбора указывает клиент',
                      style: Montserrat(size: 15, color: White),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class SizeGroupWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const SizeGroupWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextFormField(text: 'Размер группы', required: true),
              TextFieldWithShadow(
                TextFormField(
                    style: Montserrat(color: Blue, size: 15),
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      controller.sizeGroup.text = value.trim();
                    },
                    decoration: TextFieldDecoration(
                      hintText: "Максимальное кол-во людей",
                      prefixIcon: PrefixIconTextField(
                        color: const Color(0xFF4485e6),
                        icon: iconTypeExcursion,
                      ),
                    ).inputDecoration),
                error: storeInsert.errorGroupSize,
                errorText: true,
              )
            ],
          ),
        );
      },
    );
  }
}

class TypesMoveWidget extends StatefulWidget {
  final ControllerNewExcursion controller;

  const TypesMoveWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TypesMoveWidget> createState() => _TypesMoveWidgetState();
}

class _TypesMoveWidgetState extends State<TypesMoveWidget> {
  late Store<AppState> _store;
  late List<TypeMoveEntity> typesMoveActive = [];
  late List<TypeMoveEntity> typesMoveList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    typesMoveList = _store.state.addExcursionState.typesMove;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextFormField(text: 'Выберите тип передвижения', required: true),
              TextFieldWithShadow(
                MyDropdownFormField<TypeMoveEntity>(
                  emptyText: 'Данного типа передвижения нет',
                  decoration: TextFieldDecoration(
                    prefixIcon: PrefixIconTextField(color: const Color(0xFF45b678), icon: iconMove),
                    suffixIcon: Transform.rotate(
                      angle: -90 * math.pi / 180,
                      child: const Icon(Icons.arrow_back_ios, color: Blue),
                    ),
                  ).inputDecoration,
                  onChanged: (dynamic typeMove) {
                    if (typesMoveActive.length == 3) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          message: 'Можно выбрать только до 3х типов передвижения',
                          textStyle: Montserrat(size: 15, color: White),
                        ),
                      );
                    } else {
                      setState(() {
                        typesMoveActive.add(typeMove);
                        typesMoveList.removeWhere((element) => element.id == typeMove.id);
                      });
                      widget.controller.typesMove = typesMoveActive;
                    }
                  },
                  displayItemFn: (dynamic item) => Text(
                    "Автобус",
                    style: Montserrat(color: Colors.black26, size: 15),
                  ),
                  findFn: (dynamic str) async => typesMoveList,
                  filterFn: (dynamic typeMove, String str) =>
                      typeMove.name.toLowerCase().indexOf(str.toLowerCase()) >= 0,
                  dropdownItemFn: (
                    dynamic typeMove,
                    int position,
                    bool focused,
                    bool selected,
                    Function() onTap,
                  ) {
                    return ListTile(
                      title: Text(
                        typeMove.name,
                        style: Montserrat(size: 15),
                      ),
                      onTap: onTap,
                    );
                  },
                ),
                error: storeInsert.errorTypesMove,
                errorText: true,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: typesMoveActive.map((typeMove) {
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
                          child: Text(typeMove.name, style: Montserrat(size: 15, color: White)),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              typesMoveList.add(typeMove);
                              typesMoveActive.removeWhere((element) => element.id == typeMove.id);
                            });
                            widget.controller.typesMove = typesMoveActive;
                          },
                          icon: const Icon(Icons.clear, color: White),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
