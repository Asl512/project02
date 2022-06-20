import 'package:lan_code/back-end/data/repositories/category_people_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/excursion_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/ticket_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_move_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class TicketListActivityAction {}

class LoadTicketListActivityAction extends TicketListActivityAction {}

class ErrorTicketListActivityAction extends TicketListActivityAction {}

class ShowTicketListActivityAction extends TicketListActivityAction {
  final List<ExcursionEntity> excursions;
  final List<TicketEntity> tickets;

  ShowTicketListActivityAction({
    required this.excursions,
    required this.tickets,
  });
}

ThunkAction TicketListActivityThunkAction() => (Store store) async {
      store.dispatch(LoadTicketListActivityAction());
      List<TicketEntity>? tickets =
          await TicketDataRepository().getTicketForUser(idUser: store.state.authState.user.id);
      if (tickets == null) {
        store.dispatch(ErrorTicketListActivityAction());
      } else {
        if (tickets.isEmpty) {
          store.dispatch(ShowTicketListActivityAction(
            excursions: [],
            tickets: [],
          ));
        } else {
          List<ExcursionEntity> excursions = [];
          for (int i = 0; i < tickets.length; i++) {
            ExcursionEntity? excursion =
                await ExcursionDataRepository().getOneExcursion(tickets[i].idExcursion);
            if (excursion != null) {
              excursions.add(excursion);
            }
          }
          if (excursions.length == tickets.length) {
            store.dispatch(ShowTicketListActivityAction(
              excursions: excursions,
              tickets: tickets,
            ));
          } else {
            store.dispatch(ErrorTicketListActivityAction());
          }
        }
      }
    };

abstract class TicketListCancelAction {}

class LoadTicketListCancelAction extends TicketListCancelAction {}

class ErrorTicketListCancelAction extends TicketListCancelAction {}

class ShowTicketListCancelAction extends TicketListCancelAction {
  final List<ExcursionEntity> excursions;
  final List<TicketEntity> tickets;

  ShowTicketListCancelAction({
    required this.excursions,
    required this.tickets,
  });
}

ThunkAction TicketListCancelThunkAction() => (Store store) async {
      store.dispatch(LoadTicketListCancelAction());
      List<TicketEntity>? tickets =
          await TicketDataRepository().getTicketForUser(idUser: store.state.authState.user.id);
      if (tickets == null) {
        store.dispatch(ErrorTicketListCancelAction());
      } else {
        if (tickets.isEmpty) {
          store.dispatch(ShowTicketListCancelAction(
            excursions: [],
            tickets: [],
          ));
        } else {
          store.dispatch(ShowTicketListCancelAction(
            excursions: [],
            tickets: [],
          ));
        }
      }
    };

abstract class TicketDetailAction {}

class LoadTicketDetailAction extends TicketDetailAction {}

class ErrorTicketDetailAction extends TicketDetailAction {}

class ShowTicketDetailAction extends TicketDetailAction {
  final UserEntity? guide;
  final List<TypeMoveEntity> typesMove;
  final List<CategoryPeopleEntity> categoryPeople;

  ShowTicketDetailAction({
    required this.guide,
    required this.typesMove,
    required this.categoryPeople,
  });
}

ThunkAction TicketDetailThunkAction({
  required ExcursionEntity excursion,
  required TicketEntity ticket,
}) =>
    (Store store) async {
      store.dispatch(LoadTicketDetailAction());
      UserEntity? guide = await UserDataRepository().getUser(excursion.guide);
      List<String> indexesTypeMove = excursion.moveType.map((e) => e as String).toList();
      List<TypeMoveEntity> typesMove = [];
      List<TypeMoveEntity>? tm =
          await TypeMoveDataRepository().getListTypeMove(indexes: indexesTypeMove);
      if (tm != null) typesMove = tm;

      List<int> pr = [];
      List<String> indexesCategoryPeople = ticket.specialTickets.map((e) {
        pr.add(0);
        return e['idCategory'] as String;
      }).toList();
      List<CategoryPeopleEntity> categoryPeople = [];
      List<CategoryPeopleEntity>? cp = await CategoryPeopleDataRepository()
          .getListCategoryPeople(indexes: indexesCategoryPeople, prices: pr);
      if (cp != null) categoryPeople = cp;

      store.dispatch(ShowTicketDetailAction(
        guide: guide,
        typesMove: typesMove,
        categoryPeople: categoryPeople,
      ));
    };
