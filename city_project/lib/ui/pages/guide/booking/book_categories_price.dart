import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking/booking_page.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;

class BookingCategoryPrice extends StatefulWidget {
  final BookingController controller;

  const BookingCategoryPrice({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<BookingCategoryPrice> createState() => _BookingCategoryPriceState();
}

class _BookingCategoryPriceState extends State<BookingCategoryPrice> {
  late CategoryPeopleEntity? categoryPeople;
  late Store<AppState> _store;
  late TextEditingController tickets;
  late List listCategory;
  late List<List> activeCategory = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    categoryPeople = null;
    tickets = TextEditingController();
    tickets.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextFormField(text: 'Категория'),
                  TextFieldWithShadow(
                    DropdownButtonHideUnderline(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: DropdownButton2(
                          style: Montserrat(color: Blue, size: 15),
                          dropdownWidth: MediaQuery.of(context).size.width * 0.65,
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
                                  Icons.person,
                                  color: White,
                                ),
                              ),
                              if (categoryPeople == null)
                                Text('Выберите', style: Montserrat(color: Blue, size: 15))
                              else
                                Text(
                                  nameCategory(categoryPeople!.name),
                                  style: Montserrat(color: Blue, size: 15),
                                ),
                            ],
                          ),
                          items: dropdownItem(),
                          onChanged: (value) {
                            setState(() => categoryPeople = (value as CategoryPeopleEntity));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextFormField(text: 'Кол-во'),
                  TextFieldWithShadow(
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        controller: tickets,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        style: Montserrat(color: Blue, size: 15),
                        decoration: TextFieldDecoration().inputDecoration,
                      ),
                    ),
                  ),
                ],
              ),
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
                onPressed: validPrice,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Добавить', style: Montserrat(color: White)),
                ),
              ),
            ),
          ),
          StoreConnector<AppState, InsertExcursionState>(
            converter: (store) => store.state.insertExcursionState,
            builder: (context, storeInsert) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: activeCategory.map((category) {
                  late String countTickets = category.first.name + ' - ';
                  late String dop = category.last + ' шт.';
                  countTickets += dop;
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
                          child: Text(
                            countTickets,
                            style: Montserrat(size: 15, color: White),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              listCategory.add(category.first);
                              activeCategory
                                  .removeWhere((element) => element.first.id == category.first.id);
                            });
                          },
                          icon: const Icon(Icons.clear, color: White),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void validPrice() {
    String errorText = '';
    if (tickets.text == '') {
      errorText = 'Введите количество';
    } else {
      try {
        int standardPrice = int.parse(tickets.text);
        if (standardPrice <= 0) {
          errorText = 'Количество билетов должно быть больше 0.';
        }
      } catch (e) {
        errorText = 'Не верный формат количества';
      }
    }

    if (categoryPeople == null) {
      errorText = 'Выберите категорию';
    }

    if (errorText == '') {
      setState(() {
        activeCategory.add([categoryPeople!, tickets.text]);
        listCategory.removeWhere((element) => element.id == categoryPeople!.id);
        categoryPeople = null;
        tickets.text = '0';
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: errorText,
          textStyle: Montserrat(size: 15, color: White),
        ),
      );
    }
  }

  String nameCategory(String name) {
    late String result = name;
    if (name.length > 16) {
      result = name.split('').sublist(0, 16).join() + '...';
    }
    return result;
  }

  List<DropdownMenuItem<CategoryPeopleEntity>> dropdownItem() {
    listCategory = _store.state.bookingInfoState.categoriesPeople;
    List<DropdownMenuItem<CategoryPeopleEntity>> list = [];
    for (int i = 0; i < listCategory.length; i++) {
      late String price;
      if (_store.state.excursionInfoState.excursion!.specialPrice[i]['price'] == 0) {
        price = 'бесплатно';
      } else {
        price = _store.state.excursionInfoState.excursion!.specialPrice[i]['price'].toString() +
            ' ' +
            _store.state.excursionInfoState.excursion!.currency;
      }
      list.add(
        DropdownMenuItem<CategoryPeopleEntity>(
          value: listCategory[i],
          child: Text(
            listCategory[i].name + ' - ' + price,
            style: Montserrat(color: Blue, size: 15, style: SemiBold),
          ),
        ),
      );
    }
    return list;
  }
}
