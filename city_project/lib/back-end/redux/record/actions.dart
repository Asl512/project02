import 'package:lan_code/back-end/data/repositories/category_people_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/ticket_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/redux/record/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class RecordListAction {}

class LoadRecordListAction extends RecordListAction {}

class ErrorRecordListAction extends RecordListAction {}

class ShowRecordListAction extends RecordListAction {
  final List<Record> records;

  ShowRecordListAction({
    required this.records,
  });
}

ThunkAction RecordListThunkAction({required ExcursionEntity excursion}) => (Store store) async {
      store.dispatch(LoadRecordListAction());
      List<TicketEntity>? tickets =
          await TicketDataRepository().getTicketForExcursion(idExcursion: excursion.id);
      if (tickets != null) {
        try {
          List<Record> records = [];
          for (int i = 0; i < excursion.dates.length; i++) {
            List<TicketEntity> listTickets =
                tickets.where((element) => element.date == excursion.dates[i].date).toList();
            if(listTickets.isEmpty){
              records.add(Record(tickets: [], users: [], categoryPeople: []));
            }else{
              List<String> indexesUser = listTickets.map((e) => e.idUser).toList();
              List<UserEntity>? users = await UserDataRepository().getListUsers(indexesUser);
              List<List<CategoryPeopleEntity>> listCategory = [];
              for (int j = 0; j < listTickets.length; j++) {
                List<int> price = [];
                List<String> indexesCategory = listTickets[i].specialTickets.map((e) {
                  price.add(0);
                  return e['idCategory'] as String;
                }).toList();
                List<CategoryPeopleEntity>? category =
                await CategoryPeopleDataRepository().getListCategoryPeople(
                  indexes: indexesCategory,
                  prices: price,
                );
                listCategory.add(category!);
              }
              records.add(Record(tickets: listTickets, users: users!, categoryPeople: listCategory));
            }
          }
          store.dispatch(ShowRecordListAction(records: records));
        } catch (e) {
          store.dispatch(ErrorRecordListAction());
        }
      } else {
        store.dispatch(ErrorRecordListAction());
      }
    };
