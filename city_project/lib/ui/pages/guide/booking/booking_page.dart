import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/booking/booking_action.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking/book_categories_price.dart';
import 'package:lan_code/ui/pages/profile_navigation/authorization/authorization_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/authorization/registration.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:redux/redux.dart';

class BookingController {
  TextEditingController standardTicket = TextEditingController();
  TextEditingController phone = TextEditingController();
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
    _store.dispatch(BookingInfoThunkAction(_store.state.excursionInfoState.excursion));
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
                          BookingInfoThunkAction(_store.state.excursionInfoState.excursion)),
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    controller = BookingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///ТЕКСТ О БРОНИ
            Container(
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
            ),

            _StandardTickets(controller: controller),
            if (_store.state.bookingInfoState.categoriesPeople.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 20),
                  BookingCategoryPrice(controller: controller),
                ],
              ),

            if (_store.state.excursionInfoState.excursion!.type == '3') const Text('YEEEEEEEEEEEP'),

            _Phone(controller: controller),

            //вывод оставшихся мест
            ///DATES

            -1 > 0
                ? Column(
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
                            ///бронь, сколько должен гиду, итого
                            //ReturnInfoPrice(title: 'Итого:',ticket: tikets,factor: widget.data!["price"]),
                            //ReturnInfoPrice(title: 'Бронь:',ticket: tikets,factor: (widget.data!["price"]/100*20).round(),),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),

            ///КНОПКА ЗАБРОНИРОВАТЬ
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height / 4.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    padding:
                        EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 12),
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
                                    });
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
      ],
    );
  }
}

class ReturnInfoPrice extends StatelessWidget {
  final String title;
  double price = 0;

  ReturnInfoPrice({required this.title, required double ticket, int factor = 1}) {
    price = ticket * factor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Montserrat(color: Blue, size: 20)),
          Text("₽ " + price.toStringAsFixed(1),
              style: Montserrat(color: Blue, size: 20, style: Bold)),
        ]);
  }
}

class _StandardTickets extends StatelessWidget {
  final BookingController controller;

  const _StandardTickets({
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
          const TitleTextFormField(text: 'Стандартный билет', required: true),
          StoreConnector<AppState, BookingState>(
            converter: (store) => store.state.bookingState,
            builder: (context, store) {
              return TextFieldWithShadow(
                TextFormField(
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  style: Montserrat(color: Blue, size: 15),
                  onChanged: (String value) {
                    controller.standardTicket.text = value;
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
          )
        ],
      ),
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    maskPhoneNumber = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Номер телефона', required: true),
          StoreConnector<AppState, BookingState>(
            converter: (store) => store.state.bookingState,
            builder: (context, store) {
              return TextFieldWithShadow(
                TextFormField(
                  initialValue: _store.state.authState.user!.phone == 'null'
                      ? ''
                      : _store.state.authState.user!.phone,
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
                error: store.errorCountTickets,
                errorText: true,
              );
            },
          )
        ],
      ),
    );
  }
}
