import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/booking/booking_action.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking/book_categories_price.dart';
import 'package:lan_code/ui/pages/guide/booking/for_individual.dart';
import 'package:lan_code/ui/pages/profile_navigation/authorization/authorization_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/authorization/registration.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/dropdown_field.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:redux/redux.dart';

class BookingController {
  final TextEditingController standardTicket = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController meetPoint = TextEditingController();
  final TextEditingController dateForIndividual = TextEditingController();
  final TextEditingController timeForIndividual = TextEditingController();
  late List<List> categoriesPeople = [];
  late DateExcursion? dateExcursion;
}

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(BookingInfoThunkAction(_store.state.excursionInfoState.excursion!.id));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookingState>(
      converter: (store) => store.state.bookingState,
      builder: (context, store) {
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
                title: Text("Бронирование", style: Montserrat(size: 25, style: Bold)),
              ),
              body: StoreConnector<AppState, BookingInfoState>(
                converter: (store) => store.state.bookingInfoState,
                builder: (context, store) {
                  if (!store.isAuth) {
                    return const _Authorization();
                  } else if (store.isLoading) {
                    return const LoadingWidget();
                  } else if (store.isError) {
                    return PageReloadWidget(
                      errorText: 'Ошибка загрузки брони',
                      func: () => _store.dispatch(
                          BookingInfoThunkAction(_store.state.excursionInfoState.excursion!.id)),
                    );
                  }
                  return const _Body();
                },
              ),
            ),
            if (store.isLoading)
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

class _Authorization extends StatelessWidget {
  const _Authorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Что бы забронировать экскурсию, вы должны быть авторизованы',
            style: Montserrat(size: 15),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              text: "Войти",
              padding: 0,
              func: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AuthorizationPage()),
              ),
            ),
            ButtonWidget(
              text: "Регистрация",
              padding: 0,
              func: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Registration()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late BookingController controller;
  late Store<AppState> _store;
  final StreamController<bool> _priceStreamController = StreamController();
  final StreamController<bool> _dateStreamController = StreamController();

  @override
  void initState() {
    super.initState();
    _priceStreamController.sink.add(false);
    _dateStreamController.sink.add(false);
  }

  @override
  void dispose() {
    _priceStreamController.close();
    _dateStreamController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    controller = BookingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///ТЕКСТ О БРОНИ
            const _TextButtonAboutBooking(),

            _Phone(controller: controller),

            _StandardTickets(
              controller: controller,
              streamController: _priceStreamController,
            ),
            if (_store.state.bookingInfoState.categoriesPeople.isNotEmpty)
              BookingCategoryPrice(
                controller: controller,
                streamController: _priceStreamController,
              ),

            if (_store.state.bookingInfoState.excursion!.type == '3')
              Column(
                children: [
                  MeetPointForIndividual(controller: controller),
                  DateTimeForIndividual(controller: controller),
                ],
              )
            else
              _DateTimeWidget(
                controller: controller,
                streamController: _dateStreamController,
              ),

            _PriceInformation(
              streamController: _priceStreamController,
              controller: controller,
            ),

            Container(
              margin: const EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height / 4.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///КНОПКА ЗАБРОНИРОВАТЬ
                  ButtonWidget(
                    text: "Забронировать",
                    padding: 0,
                    func: () {
                      _store.dispatch(
                        BookingThunkAction(
                          context: context,
                          controller: controller,
                        ),
                      );
                    },
                  ),

                  ///ТЕКСТ О ПЛАТЕЖЕ
                  const _TextButtonAboutPriced(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceInformation extends StatefulWidget {
  final StreamController<bool> streamController;
  final BookingController controller;

  const _PriceInformation({
    Key? key,
    required this.streamController,
    required this.controller,
  }) : super(key: key);

  @override
  State<_PriceInformation> createState() => _PriceInformationState();
}

class _PriceInformationState extends State<_PriceInformation> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          late double price = 0;
          if (widget.controller.standardTicket.text != '') {
            price += int.parse(widget.controller.standardTicket.text) *
                _store.state.bookingInfoState.excursion!.standardPrice;
          }

          for (int i = 0; i < widget.controller.categoriesPeople.length; i++) {
            List category = widget.controller.categoriesPeople[i].toList();
            price += int.parse(category[1]) * category.first.price;
          }

          if (price > 0) {
            return Column(
              children: [
                Container(
                    height: 0.3,
                    margin: const EdgeInsets.only(top: 40),
                    width: double.infinity,
                    color: Blue),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      ReturnInfoPrice(
                        title: 'Итого:',
                        price: price,
                      ),
                      ReturnInfoPrice(
                        title: 'Бронь:',
                        price: price * 0.2,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        }
        return Container();
      },
    );
  }
}

class ReturnInfoPrice extends StatelessWidget {
  final String title;
  final double price;

  const ReturnInfoPrice({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Montserrat(color: Blue, size: 20)),
        Text(
          "₽ " + price.toStringAsFixed(1),
          style: Montserrat(color: Blue, size: 20, style: Bold),
        ),
      ],
    );
  }
}

class _StandardTickets extends StatefulWidget {
  final BookingController controller;
  final StreamController<bool> streamController;

  const _StandardTickets({
    Key? key,
    required this.controller,
    required this.streamController,
  }) : super(key: key);

  @override
  State<_StandardTickets> createState() => _StandardTicketsState();
}

class _StandardTicketsState extends State<_StandardTickets> {
  late MaskTextInputFormatter maskCountTickets;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maskCountTickets = MaskTextInputFormatter(
      mask: '##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextFormField(text: 'Стандартный билет', required: true),
        StoreConnector<AppState, BookingState>(
          converter: (store) => store.state.bookingState,
          builder: (context, store) {
            return TextFieldWithShadow(
              TextFormField(
                maxLength: 2,
                inputFormatters: [maskCountTickets],
                keyboardType: TextInputType.number,
                style: Montserrat(color: Blue, size: 15),
                onChanged: (String value) {
                  widget.streamController.sink.add(true);
                  widget.controller.standardTicket.text = value;
                  widget.streamController.sink.add(false);
                },
                decoration: TextFieldDecoration(
                  hintText: "Сколько вас будет",
                  prefixIcon: PrefixIconTextField(
                    color: const Color(0xFFff645a),
                    icon: const Icon(
                      Icons.people,
                      color: White,
                      size: 25,
                    ),
                  ),
                ).inputDecoration,
              ),
              error: store.errorCountTickets,
              errorText: true,
            );
          },
        ),
      ],
    );
  }
}

class _Phone extends StatefulWidget {
  final BookingController controller;

  const _Phone({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<_Phone> createState() => _PhoneState();
}

class _PhoneState extends State<_Phone> {
  late MaskTextInputFormatter maskPhoneNumber;
  late Store<AppState> _store;
  late String phone = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    maskPhoneNumber = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    if (_store.state.authState.user!.phone != 'null') {
      phone = _store.state.authState.user!.phone;
      widget.controller.phone.text = phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Номер телефона', required: true),
          StoreConnector<AppState, BookingState>(
            converter: (store) => store.state.bookingState,
            builder: (context, store) {
              return TextFieldWithShadow(
                TextFormField(
                  initialValue: phone,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  style: Montserrat(color: Blue, size: 15),
                  onChanged: (String value) {
                    widget.controller.phone.text = value;
                  },
                  inputFormatters: [maskPhoneNumber],
                  decoration: TextFieldDecoration(
                    hintText: '+7 (___) ___-__-__',
                    prefixIcon: PrefixIconTextField(
                      color: const Color(0xff4ee08e),
                      icon: const Icon(
                        Icons.phone,
                        color: White,
                        size: 25,
                      ),
                    ),
                  ).inputDecoration,
                ),
                error: store.errorPhone,
                errorText: true,
              );
            },
          )
        ],
      ),
    );
  }
}

class _DateTimeWidget extends StatefulWidget {
  final BookingController controller;
  final StreamController<bool> streamController;

  const _DateTimeWidget({
    Key? key,
    required this.controller,
    required this.streamController,
  }) : super(key: key);

  @override
  State<_DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<_DateTimeWidget> {
  late Store<AppState> _store;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleTextFormField(text: 'Дата и время (AM)', required: true),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: StreamBuilder<bool>(
                stream: widget.streamController.stream,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    late int count = 0;
                    if (widget.controller.dateExcursion != null) {
                      count = widget.controller.dateExcursion!.places;
                    }

                    return Text(
                      'осталось $count мест',
                      style: Montserrat(color: Red),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
        StoreConnector<AppState, BookingState>(
          converter: (store) => store.state.bookingState,
          builder: (context, store) {
            return TextFieldWithShadow(
              _store.state.bookingInfoState.excursion!.dates.isNotEmpty
                  ? DropdownField(
                      controller: widget.controller,
                      dates: _store.state.bookingInfoState.excursion!.dates,
                      streamController: widget.streamController,
                    )
                  : Container(
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
                    ),
              error: store.errorDate,
              errorText: true,
            );
          },
        ),
      ],
    );
  }
}

class _TextButtonAboutBooking extends StatelessWidget {
  const _TextButtonAboutBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Оплата происходит только за бронь, 20% от полной стоимости билета. ",
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
    );
  }
}

class _TextButtonAboutPriced extends StatelessWidget {
  const _TextButtonAboutPriced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Оплатить бронь вы сможете только после разрешения гида. ",
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
    );
  }
}
