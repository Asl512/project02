import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

part 'state.freezed.dart';

@freezed
class RecordListState with _$RecordListState {
  const factory RecordListState({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default([]) List<Record> records,
  }) = _RecordListState;
}

class Record {
  final List<TicketEntity> tickets;
  final List<UserEntity> users;
  final List<List<CategoryPeopleEntity>> categoryPeople;

  Record({
    required this.tickets,
    required this.users,
    required this.categoryPeople,
  });
}
