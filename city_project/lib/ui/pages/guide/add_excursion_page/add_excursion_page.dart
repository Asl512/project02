import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/service.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/libary/dropdown.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:math' as math;

import 'package:redux/redux.dart';

enum RadioButtonMoment { expectation, moment }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                func: () {
                  _store.dispatch(AddExcursionThunkAction());
                });
          }
          return const _Body();
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final ImagePicker _picker = ImagePicker();

  final ControllerRoles controllerRoles = ControllerRoles();
  final TextEditingController name = TextEditingController();

  late Store<AppState> _store;
  late UserMeth? _userMeth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _userMeth = Provider.of<UserMeth?>(context);
  }

  RadioButtonMoment? momentOne = RadioButtonMoment.expectation;
  RadioButtonMoment? momentTwo = RadioButtonMoment.expectation;
  RadioButtonMoment? momentThree = RadioButtonMoment.expectation;

  late List imageList = [];
  late int indexBack = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: StoreConnector<AppState, InsertExcursionState>(
        converter: (store) => store.state.insertExcursionState,
        builder: (context, store) {
          if (store.isLoading) {
            return const LoadingWidget();
          } else if (store.isError) {
            return PageReloadWidget(
              errorText: 'Ошибка загрузки страницы',
              func: _store.dispatch(AddExcursionThunkAction()),
            );
          }
          print(store.errorName);
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 25),
                child: Column(
                  children: [
                    _CitySelect(cityController: controllerRoles),

                    ///EXC NAME
                    Container(
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
                              onChanged: (String value) => name.text = value,
                              decoration: TextFieldDecoration(
                                hintText: "Ночная Тюмень",
                                prefixIcon: PrefixIconTextField(
                                  color: const Color(0xffff54c5),
                                  icon: Center(child: Text("A+", style: Montserrat(style: Bold))),
                                ),
                              ).inputDecoration,
                            ),
                            error: store.errorName,
                            errorText: true,
                          )
                        ],
                      ),
                    ),

                    TitleChapter(title: "Расписание"),

                    /// TYPE SELECT
                    Container(
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
                                  )),
                              hint: Row(
                                children: [
                                  PrefixIconTextField(
                                      color: const Color(0xFF42cec0),
                                      icon: Center(child: iconTypeExcursion)),
                                  Text("Выбранный тип", style: Montserrat(color: Blue, size: 15)),
                                ],
                              ),
                              items: DropdownItem(),
                              onChanged: (value) {},
                            ),
                          ),
                        )
                      ]),
                    ),

                    ///в зависимости от типа
                    /*Container(
                      margin: EdgeInsets.only(top: 30),
                      child: type["id"] == 1
                          ? ScheduleTypeOne()
                          : type["id"] == 2
                              ? ScheduleTypeTwo()
                              : ScheduleTypeThree()),*/

                    TitleChapter(title: "Детали"),

                    /// PLACE
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleTextFormField(text: 'Место сбора', required: true),
                          TextFieldWithShadow(
                            TextFormField(
                                style: Montserrat(color: Blue, size: 15),
                                maxLines: null,
                                maxLength: 100,
                                keyboardType: TextInputType.multiline,
                                onChanged: (String value) {},
                                decoration: TextFieldDecoration(
                                  hintText: "ул. Республики 195",
                                  prefixIcon: PrefixIconTextField(
                                      color: const Color(0xFFff5454), icon: iconLocation),
                                ).inputDecoration),
                            //error: startPlaceError,
                            errorText: true,
                          )
                        ],
                      ),
                    ),

                    /// PEOPLE NUM
                    Container(
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
                                onChanged: (String value) {},
                                decoration: TextFieldDecoration(
                                  hintText: "Максимальное кол-во людей",
                                  prefixIcon: PrefixIconTextField(
                                      color: const Color(0xFF4485e6), icon: iconSizer),
                                ).inputDecoration),
                            //error: groupSizeError,
                            errorText: true,
                          )
                        ],
                      ),
                    ),

                    ///ТИП ПЕРЕДВИЖЕНИЯ

                    TitleChapter(title: "Стоимость"),

                    ///PRICE
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const TitleTextFormField(text: 'Стандартный билет', required: true),
                          TextFieldWithShadow(
                            TextFormField(
                                maxLength: 5,
                                keyboardType: TextInputType.number,
                                style: Montserrat(color: Blue, size: 15),
                                onChanged: (String value) {},
                                decoration: TextFieldDecoration(
                                  hintText: "Полная стоимость билета",
                                  prefixIcon: PrefixIconTextField(
                                      color: const Color(0xFFf3cb3b),
                                      icon: Center(
                                          child:
                                          Text("₽", style: Montserrat(style: Bold, size: 22)))),
                                ).inputDecoration),
                            //error: priceError,
                            errorText: true,
                          )
                        ])),

                    ///ДЛЯ ШКОЛЬНИКОВ

                    TitleChapter(title: "Описание"),

                    ///TAGS
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const TitleTextFormField(text: 'Выберите категории'),
                          TextFieldWithShadow(
                            MyDropdownFormField<Map<String, dynamic>>(
                                emptyText: 'Данного тега нет',
                                decoration: TextFieldDecoration(
                                  prefixIcon: PrefixIconTextField(
                                      color: const Color(0xFFc25cf2),
                                      icon: Center(
                                        child: Text("#", style: Montserrat(style: Bold, size: 22)),
                                      )),
                                  suffixIcon: Transform.rotate(
                                    angle: -90 * math.pi / 180,
                                    child: const Icon(Icons.arrow_back_ios, color: Blue),
                                  ),
                                ).inputDecoration,
                                onChanged: (dynamic item) {},
                                displayItemFn: (dynamic item) => Text("Начните вводить категорию",
                                    style: Montserrat(color: Colors.black26, size: 15)),
                                findFn: (dynamic str) async => [
                                  /*roles Tags*/
                                ],
                                filterFn: (dynamic item, str) =>
                                item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
                                dropdownItemFn: (dynamic item, int position, bool focused,
                                    bool selected, Function() onTap) =>
                                    ListTile(
                                      title: Text(
                                        item['name'],
                                        style: Montserrat(color: Blue, size: 15),
                                      ),
                                      onTap: onTap,
                                    )),
                          ),

                          ///отрисока тегов
                          /*Container(
                          margin: EdgeInsets.only(top: 10),
                          child: EnterTags(),
                        )*/
                        ])),

                    ///DISCRIPTION
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const TitleTextFormField(text: 'Краткое описание', required: true),
                          TextFieldWithShadow(
                            TextFormField(
                                maxLines: null,
                                minLines: 3,
                                maxLength: 500,
                                keyboardType: TextInputType.multiline,
                                style: Montserrat(color: Blue, size: 15),
                                onChanged: (String value) {},
                                decoration: TextFieldDecoration(
                                    hintText:
                                    "Расскажите что ожидает путешественника на Вашей экскурсии?\nКакие места отдыха вы посетите?")
                                    .inputDecoration),
                            //error: descriptionError,
                            errorText: true,
                          )
                        ])),

                    /// WHAT'S INCLUDE
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const TitleTextFormField(text: 'Что включено', required: true),
                          TextFieldWithShadow(
                            TextFormField(
                                maxLines: null,
                                maxLength: 1000,
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: Montserrat(color: Blue, size: 15),
                                onChanged: (String value) {},
                                decoration: TextFieldDecoration(
                                    hintText:
                                    "Опишите подробнее.\nНапример: места посещения, трансфер, услуги, фотограф, обед.")
                                    .inputDecoration),
                            //error: includeError,
                            errorText: true,
                          )
                        ])),

                    /// DETAILS
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const TitleTextFormField(text: 'Организационные детали'),
                          TextFieldWithShadow(TextFormField(
                              maxLines: null,
                              maxLength: 1000,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Montserrat(color: Blue, size: 15),
                              onChanged: (String value) {},
                              decoration: TextFieldDecoration(
                                  hintText:
                                  "Напишите, о чем стоит знать путешествинникам перед экскурсией.\nНапример, что стоит взять с собой.")
                                  .inputDecoration))
                        ])),

                    /// OPTIONS
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const TitleTextFormField(text: 'Дополнительные услуги'),
                          TextFieldWithShadow(TextFormField(
                              maxLines: null,
                              maxLength: 1000,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Montserrat(color: Blue, size: 15),
                              onChanged: (String value) {},
                              decoration: TextFieldDecoration(
                                  hintText:
                                  "Напишите о дополнительных расходах, которые не входят в стоимость стандартного билета.")
                                  .inputDecoration))
                        ])),

                    ///PHOTOS
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleTextFormField(text: "Фотографии"),
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(const Radius.circular(20)),
                                  color: White,
                                  boxShadow: [ShadowForContainer()],
                                  border: false ? Border.all(color: Red) : Border.all(color: White)),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: PhotosList())),

                          ///добавить описание
                        ],
                      ),
                    ),

                    /// BUTTON
                    Container(
                        margin: const EdgeInsets.only(top: 50),
                        height: MediaQuery.of(context).size.height / 4.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonWidget(
                              text: 'Добавить',
                              func: () {
                                _store.dispatch(InsertThunkAction(
                                  name: name.text,
                                  city: controllerRoles.city,
                                  idGuide: _userMeth!.id!,
                                ));
                              },
                            ),

                            ///ТЕКСТ
                            Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width / 7),
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
                                              });
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  /*Widget EnterTags() {
    List<Widget> data = [];
    for (int i = 0; i < this.tags.length; i++) {
      data.add(InputChip(
        deleteIconColor: White,
        labelStyle: Montserrat(size: 14),
        backgroundColor: Blue,
        onDeleted: () => setState(() {
          rolesTags.add(tags[i]);
          tags.removeWhere((element) => element == this.tags[i]);
        }),
        label: Text(this.tags[i]["name"]),
      ));
    }
    return Wrap(
      children: data,
      spacing: 10,
    );
  }*/

  List<DropdownMenuItem<Object>> DropdownItem() {
    List<DropdownMenuItem<Object>> list = [];
    List<ItemTypeExcursion> data = [];

    /*for (int i = 0; i < widget.typeExcursion.length; i++) {
      data.add(
        ItemTypeExcursion(
            title: widget.typeExcursion[i]["name"],
            description: widget.typeExcursion[i]["description"],
            id: widget.typeExcursion[i].id),
      );
    }*/

    for (int i = 0; i < data.length; i++) {
      list.add(DropdownMenuItem<ItemTypeExcursion>(
          value: data[i],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data[i].title, style: Montserrat(color: Blue, size: 15, style: SemiBold)),
              Text(data[i].description, style: Montserrat(color: Blue, size: 13)),
            ],
          )));
    }
    return list;
  }

  List<Widget> PhotosList() {
    ///КНОПКА ДОБАВИТЬ ФОТО
    List<Widget> photos = [
      TextButton(
          onPressed: () async {
            final List<XFile>? selectedImages = await _picker.pickMultiImage();
            if (selectedImages!.isNotEmpty) setState(() => imageList!.addAll(selectedImages));
          },
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.width / 5 * 1.2,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Blue,
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.camera_alt_outlined,
                  color: White,
                  size: 35,
                ),
                Text(
                  'Добавить фотографию',
                  style: Montserrat(size: 12),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )),
    ];

    ///ФОТОГРАФИИ
    for (int i = 0; i < imageList!.length; i++) {
      photos.add(Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          TextButton(
            onPressed: () => setState(() => indexBack = i),
            child: Container(
              decoration: BoxDecoration(
                border: i == indexBack
                    ? Border.all(color: Red, width: 2)
                    : Border.all(color: White, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(imageList![i].path),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width / 5,
                  width: MediaQuery.of(context).size.width / 5 * 1.2,
                ),
              ),
            ),
          ),
          Container(
            height: 25,
            width: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: White,
                border: Border.all(color: Blue, width: 2),
                borderRadius: BorderRadius.circular(500)),
            margin: const EdgeInsets.only(right: 5),
            padding: EdgeInsets.zero,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    imageList!.removeAt(i);
                    if (indexBack == i) indexBack = 0;
                  });
                },
                padding: EdgeInsets.zero,
                iconSize: 30,
                icon: Text(
                  'x',
                  style: Montserrat(style: Bold, color: Blue),
                )),
          )
        ],
      ));
    }
    return photos;
  }

  void uploadImg() async {
    String fileName = imageList![0].name;
    var bytes = await imageList![0].readAsBytes();
    try {
      print("start, $fileName");
      firebase_storage.Reference _storage =
          firebase_storage.FirebaseStorage.instance.ref('photoExcursion/$fileName');
      await _storage.putData(bytes);
      print("++++");
      print("start URL");
      String url = await firebase_storage.FirebaseStorage.instance
          .ref('photoExcursion/$fileName')
          .getDownloadURL();
      print(url);
    } catch (e) {
      print(e);
    }
  }

//ПЕРВЫЙ ТИП
  Widget ScheduleTypeOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextFormField(text: 'Подтверждение брони', required: true),
        Column(
          children: [
            ListTile(
              title: Text("Подтверждение заказа вручную.",
                  style: Montserrat(color: Blue, size: 15, style: SemiBold)),
              subtitle: Text(
                  'Путешественники могут оплатить заказ только после вашего подтверждения.',
                  style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor: Blue,
                value: RadioButtonMoment.expectation,
                groupValue: momentOne,
                onChanged: (RadioButtonMoment? value) {},
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: -20),
            ),
          ],
        )
      ],
    );
  }

//ВТОРОЙ ТИП
  Widget ScheduleTypeTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextFormField(text: 'Подтверждение брони', required: true),
        Column(
          children: [
            ListTile(
              title: Text("Подтверждение заказа вручную.",
                  style: Montserrat(color: Blue, size: 15, style: SemiBold)),
              subtitle: Text(
                  'Путешественники могут оплатить заказ только после вашего подтверждения.',
                  style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor: Blue,
                value: RadioButtonMoment.expectation,
                groupValue: RadioButtonMoment.expectation,
                onChanged: (RadioButtonMoment? value) {},
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: -20),
            ),
          ],
        )
      ],
    );
  }

//ТРЕТИЙ ТИП
  Widget ScheduleTypeThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextFormField(text: 'Подтверждение брони', required: true),
        Column(
          children: [
            ListTile(
              title: Text("Подтверждение заказа вручную.",
                  style: Montserrat(color: Blue, size: 15, style: SemiBold)),
              subtitle: Text(
                  'Путешественники могут оплатить заказ только после вашего подтверждения.',
                  style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor: Blue,
                value: RadioButtonMoment.expectation,
                groupValue: momentThree,
                onChanged: (RadioButtonMoment? value) {
                  setState(() => momentThree = value);
                },
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: -20),
            ),
            ListTile(
              title: Text("Моментальное бронирование.",
                  style: Montserrat(color: Blue, size: 15, style: SemiBold)),
              subtitle: Text(
                  'Путешественники могут оплатить заказ только после вашего подтверждения.',
                  style: Montserrat(color: Blue, size: 13)),
              leading: Radio<RadioButtonMoment>(
                activeColor: Blue,
                value: RadioButtonMoment.moment,
                groupValue: momentThree,
                onChanged: (RadioButtonMoment? value) {
                  setState(() => momentThree = value);
                },
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: -20),
            ),
          ],
        )
      ],
    );
  }
}

class _CitySelect extends StatelessWidget {
  final ControllerRoles cityController;

  const _CitySelect({required this.cityController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> _store = StoreProvider.of<AppState>(context);
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
                  cityController.city = activityCity;
                },
                displayItemFn: (dynamic item) {
                  if (cityController.city == null) {
                    return Text('Тюмень', style: Montserrat(color: Colors.black26, size: 15));
                  } else {
                    return Text(cityController.city!.name,
                        style: Montserrat(color: Blue, size: 15));
                  }
                },
                findFn: (dynamic str) async => _store.state.addExcursionState.cities,
                filterFn: (CityEntity city, str) =>
                    city.name.toLowerCase().contains(str.toLowerCase()),
                dropdownItemFn:
                    (dynamic city, int position, bool focused, bool selected, Function() onTap) {
                  return ListTile(
                    title: Text(
                      city.name,
                      style: Montserrat(color: Blue, size: 15),
                    ),
                    onTap: onTap,
                  );
                }),
            //error: [cityError, "Выберите город"],
            errorText: true,
          ),
        ],
      ),
    );
  }
}

class ControllerRoles {
  late CityEntity? city = null;
}

class TitleChapter extends StatelessWidget {
  final String? title;

  TitleChapter({required this.title});

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
            child: Text(this.title.toString(),
                style: Montserrat(color: Blue, style: SemiBold, size: 30)),
          ),
          Container(height: 1, width: double.infinity, color: Blue)
        ],
      ),
    );
  }
}

class ItemTypeExcursion {
  final String title;
  final String description;
  final String id;

  const ItemTypeExcursion({
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  String toString() {
    String name;
    if (title.length > 24) {
      name = title.split('').sublist(0, 24).join() + '...';
    } else {
      name = title;
    }
    return "$name-$id";
  }
}
