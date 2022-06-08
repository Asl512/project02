import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/back-end/data/repositories/category_people_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/excursion_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/useCases/category_people_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/user_useCase.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/booking/booking_page.dart';
import 'package:lan_code/ui/pages/navigation.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class BookingInfoAction {}

class LoadBookingInfoAction extends BookingInfoAction {}

class ErrorBookingInfoAction extends BookingInfoAction {}

class NotAuthBookingInfoAction extends BookingInfoAction {}

class ShowBookingInfoAction extends BookingInfoAction {
  final List<CategoryPeopleEntity> categoriesPeople;
  final ExcursionEntity excursion;

  ShowBookingInfoAction({
    required this.categoriesPeople,
    required this.excursion,
  });
}

ThunkAction BookingInfoThunkAction(String idExcursion) => (Store store) async {
      store.dispatch(LoadBookingInfoAction());
      if (store.state.authState.user == null) {
        store.dispatch(NotAuthBookingInfoAction());
      } else {
        ExcursionEntity? exception = await ExcursionDataRepository().getOneExcursion(idExcursion);
        if (exception != null) {
          List<String> indexes =
              exception.specialPrice.map((e) => e["idCategory"] as String).toList();

          List<int> prices = exception.specialPrice.map((e) => e["price"] as int).toList();

          List<CategoryPeopleEntity> responseCategoriesPeople = [];
          if (indexes.isNotEmpty) {
            List<CategoryPeopleEntity>? response =
                await GetListCategoryPeople(CategoryPeopleDataRepository()).call(
              indexes: indexes,
              prices: prices,
            );
            if (response != null) {
              responseCategoriesPeople = response;
            } else {
              store.dispatch(ErrorBookingInfoAction());
            }
          }

          store.dispatch(ShowBookingInfoAction(
            categoriesPeople: responseCategoriesPeople,
            excursion: exception,
          ));
        } else {
          store.dispatch(ErrorBookingInfoAction());
        }
      }
    };

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
  final List? erorMeetPoint;
  final List? errorTimeForIndividual;
  final List? errorDateForIndividual;

  ErrorBookingAction({
    this.errorCountTickets,
    this.errorPhone,
    this.errorDate,
    this.erorMeetPoint,
    this.errorDateForIndividual,
    this.errorTimeForIndividual,
  });
}

Future<bool> checkAuth({
  required BuildContext context,
  required String? token,
}) async {
  if (token == null) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: 'Ошибка обработки запроса',
        textStyle: Montserrat(size: 15, color: White),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Navigation(index: 0)),
      (route) => false,
    );
    return false;
  } else {
    UserEntity? responseUser = await GetUser(UserDataRepository()).call(token);
    if (responseUser == null) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: 'Ошибка обработки запроса',
          textStyle: Montserrat(size: 15, color: White),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Navigation(index: 0)),
        (route) => false,
      );
      return false;
    } else {
      return true;
    }
  }
}

ThunkAction BookingThunkAction({
  required context,
  required BookingController controller,
}) =>
    (Store store) async {
      store.dispatch(LoadBookingAction());
      bool error = false;
      List? errorCountTickets;
      List? errorPhone;
      List? errorDate;
      List? errorDateForIndividual;
      List? errorTimeForIndividual;
      List? errorMeetPoint;
      late int tickets = 0;
      late Timestamp timestampInd = Timestamp(0, 0);
      late Timestamp timestampGroup = Timestamp(0, 0);

      if (await checkAuth(context: context, token: store.state.authState.token)) {
        if (controller.standardTicket.text == '') {
          errorCountTickets = [true, "Введите количество стандартных билетов"];
          error = true;
        } else {
          try {
            int standardTicket = int.parse(controller.standardTicket.text.trim());
            if (standardTicket < 0) {
              errorCountTickets = [true, "Количество билетов должно быть больше 1-го"];
              error = true;
            } else if (standardTicket > 10) {
              errorCountTickets = [true, "Вы можете забронировать не больше 10 билетов"];
              error = true;
            } else {
              tickets += standardTicket;
            }
          } catch (e) {
            errorCountTickets = [true, "Не верный формат"];
            error = true;
          }
        }

        if (store.state.excursionInfoState.excursion.type == '3') {
          if (controller.meetPoint.text == '') {
            error = true;
            errorMeetPoint = [true, 'Введите место сбора'];
          } else if (controller.meetPoint.text.length <= 5) {
            error = true;
            errorMeetPoint = [true, 'Слишком короткое название места сбора'];
          }

          if (controller.dateForIndividual.text == '' ||
              controller.timeForIndividual.text == '' ||
              controller.dateForIndividual.text.length != 10 ||
              controller.timeForIndividual.text.length != 5) {
            error = true;
            errorDateForIndividual = [true, 'Напишите дату и время'];
            errorTimeForIndividual = [true, ''];
          } else {
            int hours = 0;
            int minutes = 0;
            bool checkTime = true;
            try {
              List time = controller.timeForIndividual.text.split(':');
              hours = int.parse(time.first);
              minutes = int.parse(time.last);
              if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
                errorTimeForIndividual = [true, 'Не коректное время'];
                error = true;
              }
            } catch (e) {
              checkTime = false;
              errorTimeForIndividual = [true, e.toString()];
              error = true;
            }
            DateTime? date;
            if (checkTime) {
              try {
                List data = controller.dateForIndividual.text.split('.');
                date = DateTime(
                  int.parse(data.last),
                  int.parse(data[1]),
                  int.parse(data.first),
                  hours,
                  minutes,
                );
                DateTime now = DateTime.now();
                DateTime lastDate = DateTime(2023, 12, 30);
                if (date.millisecondsSinceEpoch > lastDate.millisecondsSinceEpoch) {
                  errorDateForIndividual = [true, 'Не коректная дата'];
                  error = true;
                } else if (date.millisecondsSinceEpoch + 10 <= now.millisecondsSinceEpoch) {
                  errorDateForIndividual = [true, 'Дата уже не действительна'];
                  error = true;
                }
              } catch (e) {
                errorDateForIndividual = [true, e.toString()];
                error = true;
              }
            }
            if (date != null) {
              timestampInd = Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);
            }
          }
        } else {
          timestampGroup = Timestamp.fromMillisecondsSinceEpoch(
              controller.dateExcursion!.date.millisecondsSinceEpoch);
        }

        if (!error) {
          for (int i = 0; i < controller.categoriesPeople.length; i++) {
            List category = controller.categoriesPeople[i].toList();
            tickets += int.parse(category[1]);
          }

          if (tickets > controller.dateExcursion!.places) {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: 'Вы забронировали $tickets билетов, а осталось ' +
                    controller.dateExcursion!.places.toString(),
                textStyle: Montserrat(size: 15, color: White),
              ),
            );
            store.dispatch(ErrorBookingAction());
          } else {
            try {
              await FirebaseFirestore.instance.collection('tickets').add({
                "idExcursion": store.state.excursionInfoState.excursion.id,
                "idUser": store.state.authState.token,
                "phoneUser": controller.phone.text.trim(),
                'standardTickets': int.parse(controller.standardTicket.text.trim()),
                'date': timestampGroup,
                "specialTickets": controller.categoriesPeople
                    .map((list) => {
                          "idCategory": list.first.id,
                          "tickets": int.parse(list.last),
                        })
                    .toList(),
                "userMeetPoint": controller.meetPoint.text.trim() == ''
                    ? 'null'
                    : controller.meetPoint.text.trim(),
                "userDate": timestampInd,
              });

              await FirebaseFirestore.instance
                  .collection('excursion')
                  .doc(store.state.excursionInfoState.excursion.id)
                  .update({
                'dates': store.state.bookingInfoState.excursion.dates.map((date) {
                  if (controller.dateExcursion == date) {
                    return {
                      'date': date.date,
                      'places': date.places - tickets,
                    };
                  }
                  return {
                    'date': date.date,
                    'places': date.places,
                  };
                }).toList(),
              });

              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  message: 'Вы успешно забронировали экскурсию',
                  textStyle: Montserrat(size: 15, color: White),
                ),
              );

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Navigation(index: 1)),
                (route) => false,
              );
              store.dispatch(ErrorBookingAction());
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
          }
        } else {
          store.dispatch(ErrorBookingAction(
            errorCountTickets: errorCountTickets,
            errorPhone: errorPhone,
            errorDate: errorDate,
            erorMeetPoint: errorMeetPoint,
            errorDateForIndividual: errorDateForIndividual,
            errorTimeForIndividual: errorTimeForIndividual,
          ));
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: 'Ошибка валидации',
              textStyle: Montserrat(size: 15, color: White),
            ),
          );
        }
      }
    };
