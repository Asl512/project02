import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

part 'ticket_state.freezed.dart';

@freezed
class TicketListState with _$TicketListState {
  const factory TicketListState({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default([]) List<ExcursionEntity> excursions,
    @Default([]) List<TicketEntity> tickets,
  }) = _TicketListState;
}


@freezed
class TicketDetailState with _$TicketDetailState {
  const factory TicketDetailState({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    UserEntity? guide,
    @Default([]) List<TypeMoveEntity> typesMove,
    @Default([]) List<CategoryPeopleEntity> categoryPeople,
  }) = _TicketDetailState;
}
