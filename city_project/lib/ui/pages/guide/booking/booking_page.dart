import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/booking/booking_action.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking/book_categories_price.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:redux/redux.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

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
                    onPressed: () => Navigator.pop(context)),
                title: Text("Бронирование", style: Montserrat(size: 25, style: Bold)),
              ),
              body: const _Body(),
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
            BookingCategoryPrice(controller:controller),

            if (_store.state.excursionInfoState.excursion!.type == '3') const Text('YEEEEEEEEEEEP'),

            ///ВРЕМЯ

            ///ТЕЛЕФОН

            //вывод оставшихся мест
            ///DATES
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleTextFormField(text: "Даты", required: true),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: White,
                          boxShadow: [ShadowForContainer()],
                          border: false ? Border.all(color: Red) : Border.all(color: White)),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      child: SfDateRangePicker(
                        view: DateRangePickerView.month,
                        monthViewSettings: const DateRangePickerMonthViewSettings(
                            firstDayOfWeek: 1, dayFormat: 'EEE'),
                        selectableDayPredicate: (DateTime dateTime) {
                          DateTime start = DateTime(2022, 03, 03);
                          DateTime end = DateTime(2022, 03, 25);
                          if (dateTime.isAfter(start) && dateTime.isBefore(end)) return true;
                          return false;
                        },
                        enablePastDates: false,
                        selectionMode: DateRangePickerSelectionMode.single,
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {},
                        selectionColor: Blue,
                        todayHighlightColor: Blue,
                      ),
                    ),
                    false
                        ? Container(
                            margin: const EdgeInsets.only(top: 10, left: 15),
                            child: RichText(
                              text: TextSpan(
                                  text: "Ошибка даты".toString(),
                                  style: Montserrat(size: 13, color: Red)),
                            ))
                        : Container()
                  ],
                )),

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
                          ))
                    ],
                  )
                : Container(),

            ///КНОПКА КУПИТЬ
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
                          idGuide: _store.state.authState.token,
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

class BookingController {
  TextEditingController standardTicket = TextEditingController();
}
