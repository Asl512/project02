import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking/booking_page.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MeetPointForIndividual extends StatelessWidget {
  final BookingController controller;

  const MeetPointForIndividual({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Где вас забрать', required: true),
          StoreConnector<AppState, BookingState>(
            converter: (store) => store.state.bookingState,
            builder: (context, store) {
              return TextFieldWithShadow(
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
                    prefixIcon: PrefixIconTextField(
                      color: const Color(0xFFff5454),
                      icon: iconLocation,
                    ),
                  ).inputDecoration,
                ),
                error: store.errorMeetPoint,
                errorText: true,
              );
            },
          ),
        ],
      ),
    );
  }
}

class DateTimeForIndividual extends StatefulWidget {
  final BookingController controller;

  const DateTimeForIndividual({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DateTimeForIndividual> createState() => _DateTimeForIndividualState();
}

class _DateTimeForIndividualState extends State<DateTimeForIndividual> {
  late MaskTextInputFormatter maskDate;
  late MaskTextInputFormatter maskTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    maskDate = MaskTextInputFormatter(
      mask: '##.##.####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    maskTime = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: 'Дата и время (AM)', required: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: StoreConnector<AppState, BookingState>(
                  converter: (store) => store.state.bookingState,
                  builder: (context, store) {
                    return TextFieldWithShadow(
                      TextFormField(
                        controller: widget.controller.dateForIndividual,
                        keyboardType: TextInputType.number,
                        style: Montserrat(color: Blue, size: 15),
                        inputFormatters: [maskDate],
                        decoration: TextFieldDecoration(
                          hintText: "19.05.2022",
                          prefixIcon: PrefixIconTextField(
                            color: const Color(0xFFc25cf2),
                            icon: const Icon(
                              Icons.calendar_today_rounded,
                              color: White,
                              size: 25,
                            ),
                          ),
                        ).inputDecoration,
                      ),
                      error: store.errorDateForIndividual,
                      errorText: true,
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: StoreConnector<AppState, BookingState>(
                  converter: (store) => store.state.bookingState,
                  builder: (context, store) {
                    return TextFieldWithShadow(
                      TextFormField(
                        controller: widget.controller.timeForIndividual,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskTime],
                        style: Montserrat(color: Blue, size: 15),
                        decoration: TextFieldDecoration(
                          hintText: "13:00",
                        ).inputDecoration,
                      ),
                      error: store.errorTimeForIndividual,
                      errorText: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
