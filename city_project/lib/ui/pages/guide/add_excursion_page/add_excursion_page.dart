import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/date.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/description.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/details.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/photo.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/price/categories_price.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/price/standard_price.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/timetable/duration.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/timetable/type.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/libary/dropdown.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'dart:math' as math;
import 'package:redux/redux.dart';

class ControllerNewExcursion {
  late CityEntity? city;
  late TypeEntity type;
  late bool moment = false;
  late int duration = 1;
  late String durationType = 'час';
  late List<TagEntity> tags = [];
  late CurrencyEntity currency;
  late List<TypeMoveEntity> typesMove = [];
  late TextEditingController name = TextEditingController();
  late TextEditingController sizeGroup = TextEditingController();
  late TextEditingController standardPrice = TextEditingController();
  late List<List> categoriesPeoplePrice = [];
  late TextEditingController included = TextEditingController();
  late TextEditingController meetPoint = TextEditingController();
  late TextEditingController description = TextEditingController();
  late TextEditingController organizationalDetails = TextEditingController();
  late TextEditingController addServices = TextEditingController();
  late List<XFile> imageList = [];
  List<String> dates = [];
  late int indexBackImage = 0;

  ControllerNewExcursion(context) {
    city = null;
    Store<AppState> _store = StoreProvider.of<AppState>(context);
    type = _store.state.addExcursionState.types.first;
    _store.dispatch(ChangeTypeInsetExcursionAction(type: type));

    currency = _store.state.addExcursionState.currencies.first;
    _store.dispatch(ChangeCurrencyInsetExcursionAction(currency: currency));
  }
}

class AddExcursionPage extends StatefulWidget {
  const AddExcursionPage({Key? key}) : super(key: key);

  @override
  State<AddExcursionPage> createState() => _AddExcursionPageState();
}

class _AddExcursionPageState extends State<AddExcursionPage> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(AddExcursionThunkAction(context));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Grey,
              appBar: AppBar(
                backgroundColor: Grey,
                elevation: 0.0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20, color: Blue),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text("Добавить экскурсию", style: Montserrat(size: 25, style: Bold)),
              ),
              body: StoreConnector<AppState, AddExcursionState>(
                converter: (store) => store.state.addExcursionState,
                builder: (context, store) {
                  if (store.isLoading) {
                    return const LoadingWidget();
                  } else if (store.isError) {
                    return PageReloadWidget(
                      errorText: 'Ошибка загрузки страницы',
                      func: () => _store.dispatch(AddExcursionThunkAction(context)),
                    );
                  }
                  return const _Body();
                },
              ),
            ),
            if (storeInsert.isLoading)
              Positioned(
                child: Container(
                  child: const LoadingWidget(),
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late ControllerNewExcursion controller;
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    controller = ControllerNewExcursion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 25),
            child: Column(
              children: [
                _CitySelect(controller: controller),
                _Name(controller: controller),

                const TitleChapter(title: "Расписание"),

                TypeExcursionSelect(controller: controller),
                //BookingConfirmationWidget(controller: controller),
                DateWidget(controller: controller),
                //const PublishWidget(),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleTextFormField(text: 'Продолжительность', required: true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DurationWidget(controller: controller),
                          TypeDurationWidget(controller: controller),
                        ],
                      )
                    ],
                  ),
                ),

                /// DETAILS
                const TitleChapter(title: "Детали"),

                MeetPointWidget(controller: controller),
                SizeGroupWidget(controller: controller),
                TypesMoveWidget(controller: controller),

                /// PRICE
                const TitleChapter(title: "Стоимость"),
                StandardPriceWidget(controller: controller),
                NewCategoryPrice(controller: controller),
                CurrencySelect(controller: controller),

                /// DESCRIPTION
                const TitleChapter(title: "Описание"),

                TagsWidget(controller: controller),
                DescriptionWidget(controller: controller),
                IncludeWidget(controller: controller),
                OrganizationalDetailsWidget(controller: controller),
                AddServiceWidget(controller: controller),
                AddPhoto(controller: controller),

                /// BUTTON
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  height: MediaQuery.of(context).size.height / 4.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        text: 'Добавить',
                        func: () {
                          _store.dispatch(
                            InsertThunkAction(
                              context: context,
                              controller: controller,
                            ),
                          );
                        },
                      ),

                      ///ТЕКСТ
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        padding:
                            EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 7),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Добавляя экскурсию, она сначала проходит модерацию. ",
                                style: Montserrat(size: 12, color: Blue),
                              ),
                              TextSpan(
                                text: "Подробнее.",
                                style: Montserrat(style: SemiBold, size: 13, color: Red),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showModalBottomSheet(
                                      backgroundColor: White.withOpacity(0),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container();
                                      },
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Name extends StatelessWidget {
  final ControllerNewExcursion controller;

  const _Name({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextFormField(text: 'Название экскурсии', required: true),
              TextFieldWithShadow(
                TextFormField(
                  maxLines: null,
                  maxLength: 50,
                  keyboardType: TextInputType.multiline,
                  style: Montserrat(color: Blue, size: 15),
                  onChanged: (String value) => controller.name.text = value.trim(),
                  decoration: TextFieldDecoration(
                    hintText: "Ночная Тюмень",
                    prefixIcon: PrefixIconTextField(
                      color: const Color(0xffff54c5),
                      icon: Center(
                        child: Text(
                          "A+",
                          style: Montserrat(style: Black, color: White),
                        ),
                      ),
                    ),
                  ).inputDecoration,
                ),
                error: storeInsert.errorName,
                errorText: true,
              )
            ],
          ),
        );
      },
    );
  }
}

class _CitySelect extends StatelessWidget {
  final ControllerNewExcursion controller;

  const _CitySelect({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> _store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, InsertExcursionState>(
      converter: (store) => store.state.insertExcursionState,
      builder: (context, storeInsert) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextFormField(text: 'Выберите город', required: true),
              TextFieldWithShadow(
                MyDropdownFormField<CityEntity>(
                  emptyText: 'Данного города нет',
                  decoration: TextFieldDecoration(
                    prefixIcon: PrefixIconTextField(color: const Color(0xFF546eff), icon: iconCity),
                    suffixIcon: Transform.rotate(
                      angle: -90 * math.pi / 180,
                      child: const Icon(Icons.arrow_back_ios, color: Blue),
                    ),
                  ).inputDecoration,
                  onChanged: (dynamic activityCity) {
                    controller.city = activityCity;
                  },
                  displayItemFn: (dynamic item) {
                    if (controller.city == null) {
                      return Text('Тюмень', style: Montserrat(color: Colors.black26, size: 15));
                    } else {
                      return Text(controller.city!.name, style: Montserrat(color: Blue, size: 15));
                    }
                  },
                  findFn: (dynamic str) async => _store.state.addExcursionState.cities,
                  filterFn: (dynamic city, String str) {
                    return city.name.toLowerCase().indexOf(str.toLowerCase()) >= 0;
                  },
                  dropdownItemFn: (
                    dynamic city,
                    int position,
                    bool focused,
                    bool selected,
                    Function() onTap,
                  ) {
                    return ListTile(
                      title: Text(
                        city.name,
                        style: Montserrat(color: Blue, size: 15),
                      ),
                      onTap: onTap,
                    );
                  },
                ),
                error: storeInsert.errorCity,
                errorText: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TitleChapter extends StatelessWidget {
  final String? title;

  const TitleChapter({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child:
                Text(title.toString(), style: Montserrat(color: Blue, style: SemiBold, size: 30)),
          ),
          Container(height: 1, width: double.infinity, color: Blue),
        ],
      ),
    );
  }
}
