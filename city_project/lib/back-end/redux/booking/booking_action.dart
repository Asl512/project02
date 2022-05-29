import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking/booking_page.dart';
import 'package:lan_code/ui/pages/navigation.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class BookingAction {}

class LoadBookingAction extends BookingAction {}

class AddPriceBookingAction extends BookingAction {
  final int price;

  AddPriceBookingAction({required this.price});
}

class ErrorBookingAction extends BookingAction {
  final List? errorCountTickets;
  final List? errorPhone;
  final List? errorDate;

  ErrorBookingAction({
    this.errorCountTickets,
    this.errorPhone,
    this.errorDate,
  });
}

ThunkAction BookingThunkAction({
  required context,
  required BookingController controller,
  required String idGuide,
}) =>
    (Store store) async {
      store.dispatch(LoadBookingAction());
      bool error = false;
      List? errorCountTickets;
      List? errorPhone;
      List? errorDate;

      if (controller.standardTicket.text == '') {
        errorCountTickets = [true, "Введите количество стандартных билетов"];
        error = true;
      } else {
        try {
          int price = int.parse(controller.standardTicket.text.trim());
          if (price < 0) {
            errorCountTickets = [true, "Количество билетов должно быть больше 1-го"];
            error = true;
          } else if (price > 10) {
            errorCountTickets = [true, "Вы можете забронировать не больше 10 билетов"];
            error = true;
          }
        } catch (e) {
          errorCountTickets = [true, "Не верный формат"];
          error = true;
        }
      }

      if (!error) {
        try {
          //ИЗМЕНЕНИЯ В БД

          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: 'Вы успешно забронировали экскурсию',
              textStyle: Montserrat(size: 15, color: White),
            ),
          );

          /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Navigation(index: 1)),
            (route) => false,
          );*/
        } catch (e) {
          store.dispatch(ErrorBookingAction());
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: e.toString(),
              textStyle: Montserrat(size: 15, color: White),
            ),
          );
        }
      } else {
        store.dispatch(ErrorBookingAction(
          errorCountTickets: errorCountTickets,
          errorPhone: errorPhone,
          errorDate: errorDate,
        ));
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: 'Ошибка валидации',
            textStyle: Montserrat(size: 15, color: White),
          ),
        );
      }
    };
