import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/widgets/libary/dropdown.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'dart:math' as math;

import 'package:redux/redux.dart';

class TagsWidget extends StatefulWidget {
  final ControllerNewExcursion controller;

  const TagsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TagsWidget> createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {
  late Store<AppState> _store;
  late List<TagEntity> tagsActive = [];
  late List<TagEntity> tagsList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    tagsList = _store.state.addExcursionState.tags;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Выберите теги'),
          TextFieldWithShadow(
            MyDropdownFormField<TagEntity>(
              emptyText: 'Данного тега нет',
              decoration: TextFieldDecoration(
                prefixIcon: PrefixIconTextField(
                  color: const Color(0xFFc25cf2),
                  icon: Center(
                    child: Text("#", style: Montserrat(style: Bold, color: White, size: 22)),
                  ),
                ),
                suffixIcon: Transform.rotate(
                  angle: -90 * math.pi / 180,
                  child: const Icon(Icons.arrow_back_ios, color: Blue),
                ),
              ).inputDecoration,
              onChanged: (dynamic tag) {
                setState(() {
                  tagsActive.add(tag);
                  tagsList.removeWhere((element) => element.id == tag.id);
                });
                widget.controller.tags = tagsActive;
              },
              displayItemFn: (dynamic item) => Text(
                "Начните вводить тег",
                style: Montserrat(color: Colors.black26, size: 15),
              ),
              findFn: (dynamic str) async => tagsList,
              filterFn: (dynamic tag, String str) =>
                  tag.name.toLowerCase().indexOf(str.toLowerCase()) >= 0,
              dropdownItemFn: (
                dynamic tag,
                int position,
                bool focused,
                bool selected,
                Function() onTap,
              ) {
                return ListTile(
                  title: Text(
                    tag.name,
                    style: Montserrat(color: Blue, size: 15),
                  ),
                  onTap: onTap,
                );
              },
            ),
          ),
          Wrap(
            spacing: 10,
            children: tagsActive
                .map(
                  (tag) => InputChip(
                    labelStyle: Montserrat(size: 14),
                    backgroundColor: Blue,
                    onDeleted: () {
                      setState(() {
                        tagsList.add(tag);
                        tagsActive.removeWhere((element) => element.id == tag.id);
                      });
                      widget.controller.tags = tagsActive;
                    },
                    deleteIconColor: White,
                    label: Text(tag.name, style: Montserrat(color: White)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const DescriptionWidget({
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
              const TitleTextFormField(text: 'Краткое описание', required: true),
              TextFieldWithShadow(
                TextFormField(
                  maxLines: null,
                  minLines: 3,
                  maxLength: 500,
                  keyboardType: TextInputType.multiline,
                  style: Montserrat(color: Blue, size: 15),
                  onChanged: (String value) {
                    controller.description.text = value;
                  },
                  decoration: TextFieldDecoration(
                    hintText:
                        "Расскажите что ожидает путешественника на Вашей экскурсии?\nКакие места отдыха вы посетите?",
                  ).inputDecoration,
                ),
                error: storeInsert.errorDescription,
                errorText: true,
              )
            ],
          ),
        );
      },
    );
  }
}

class IncludeWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const IncludeWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Что включено'),
          TextFieldWithShadow(
            TextFormField(
              maxLines: null,
              maxLength: 1000,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              style: Montserrat(color: Blue, size: 15),
              onChanged: (String value) {
                controller.included.text = value;
              },
              decoration: TextFieldDecoration(
                hintText:
                    "Опишите подробнее.\nНапример: места посещения, трансфер, услуги, фотограф, обед.",
              ).inputDecoration,
            ),
          )
        ],
      ),
    );
  }
}

class OrganizationalDetailsWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const OrganizationalDetailsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Организационные детали'),
          TextFieldWithShadow(
            TextFormField(
              maxLines: null,
              maxLength: 1000,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              style: Montserrat(color: Blue, size: 15),
              onChanged: (String value) {
                controller.organizationalDetails.text = value;
              },
              decoration: TextFieldDecoration(
                hintText:
                    "Напишите, о чем стоит знать путешествинникам перед экскурсией.\nНапример, что стоит взять с собой.",
              ).inputDecoration,
            ),
          )
        ],
      ),
    );
  }
}

class AddServiceWidget extends StatelessWidget {
  final ControllerNewExcursion controller;

  const AddServiceWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Дополнительные услуги'),
          TextFieldWithShadow(
            TextFormField(
              maxLines: null,
              maxLength: 1000,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              style: Montserrat(color: Blue, size: 15),
              onChanged: (String value) {
                controller.addServices.text = value;
              },
              decoration: TextFieldDecoration(
                hintText:
                    "Напишите о дополнительных расходах, которые не входят в стоимость стандартного билета.",
              ).inputDecoration,
            ),
          ),
        ],
      ),
    );
  }
}
