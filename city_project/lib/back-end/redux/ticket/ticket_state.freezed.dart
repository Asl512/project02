// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ticket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TicketListStateTearOff {
  const _$TicketListStateTearOff();

  _TicketListState call(
      {bool isLoading = false,
      bool isError = false,
      List<ExcursionEntity> excursions = const [],
      List<TicketEntity> tickets = const []}) {
    return _TicketListState(
      isLoading: isLoading,
      isError: isError,
      excursions: excursions,
      tickets: tickets,
    );
  }
}

/// @nodoc
const $TicketListState = _$TicketListStateTearOff();

/// @nodoc
mixin _$TicketListState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  List<ExcursionEntity> get excursions => throw _privateConstructorUsedError;
  List<TicketEntity> get tickets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicketListStateCopyWith<TicketListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketListStateCopyWith<$Res> {
  factory $TicketListStateCopyWith(
          TicketListState value, $Res Function(TicketListState) then) =
      _$TicketListStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool isError,
      List<ExcursionEntity> excursions,
      List<TicketEntity> tickets});
}

/// @nodoc
class _$TicketListStateCopyWithImpl<$Res>
    implements $TicketListStateCopyWith<$Res> {
  _$TicketListStateCopyWithImpl(this._value, this._then);

  final TicketListState _value;
  // ignore: unused_field
  final $Res Function(TicketListState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isError = freezed,
    Object? excursions = freezed,
    Object? tickets = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      excursions: excursions == freezed
          ? _value.excursions
          : excursions // ignore: cast_nullable_to_non_nullable
              as List<ExcursionEntity>,
      tickets: tickets == freezed
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<TicketEntity>,
    ));
  }
}

/// @nodoc
abstract class _$TicketListStateCopyWith<$Res>
    implements $TicketListStateCopyWith<$Res> {
  factory _$TicketListStateCopyWith(
          _TicketListState value, $Res Function(_TicketListState) then) =
      __$TicketListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool isError,
      List<ExcursionEntity> excursions,
      List<TicketEntity> tickets});
}

/// @nodoc
class __$TicketListStateCopyWithImpl<$Res>
    extends _$TicketListStateCopyWithImpl<$Res>
    implements _$TicketListStateCopyWith<$Res> {
  __$TicketListStateCopyWithImpl(
      _TicketListState _value, $Res Function(_TicketListState) _then)
      : super(_value, (v) => _then(v as _TicketListState));

  @override
  _TicketListState get _value => super._value as _TicketListState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isError = freezed,
    Object? excursions = freezed,
    Object? tickets = freezed,
  }) {
    return _then(_TicketListState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      excursions: excursions == freezed
          ? _value.excursions
          : excursions // ignore: cast_nullable_to_non_nullable
              as List<ExcursionEntity>,
      tickets: tickets == freezed
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as List<TicketEntity>,
    ));
  }
}

/// @nodoc

class _$_TicketListState implements _TicketListState {
  const _$_TicketListState(
      {this.isLoading = false,
      this.isError = false,
      this.excursions = const [],
      this.tickets = const []});

  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final List<ExcursionEntity> excursions;
  @JsonKey()
  @override
  final List<TicketEntity> tickets;

  @override
  String toString() {
    return 'TicketListState(isLoading: $isLoading, isError: $isError, excursions: $excursions, tickets: $tickets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TicketListState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality()
                .equals(other.excursions, excursions) &&
            const DeepCollectionEquality().equals(other.tickets, tickets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(excursions),
      const DeepCollectionEquality().hash(tickets));

  @JsonKey(ignore: true)
  @override
  _$TicketListStateCopyWith<_TicketListState> get copyWith =>
      __$TicketListStateCopyWithImpl<_TicketListState>(this, _$identity);
}

abstract class _TicketListState implements TicketListState {
  const factory _TicketListState(
      {bool isLoading,
      bool isError,
      List<ExcursionEntity> excursions,
      List<TicketEntity> tickets}) = _$_TicketListState;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  List<ExcursionEntity> get excursions;
  @override
  List<TicketEntity> get tickets;
  @override
  @JsonKey(ignore: true)
  _$TicketListStateCopyWith<_TicketListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$TicketDetailStateTearOff {
  const _$TicketDetailStateTearOff();

  _TicketDetailState call(
      {bool isLoading = false,
      bool isError = false,
      UserEntity? guide,
      List<TypeMoveEntity> typesMove = const [],
      List<CategoryPeopleEntity> categoryPeople = const []}) {
    return _TicketDetailState(
      isLoading: isLoading,
      isError: isError,
      guide: guide,
      typesMove: typesMove,
      categoryPeople: categoryPeople,
    );
  }
}

/// @nodoc
const $TicketDetailState = _$TicketDetailStateTearOff();

/// @nodoc
mixin _$TicketDetailState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  UserEntity? get guide => throw _privateConstructorUsedError;
  List<TypeMoveEntity> get typesMove => throw _privateConstructorUsedError;
  List<CategoryPeopleEntity> get categoryPeople =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicketDetailStateCopyWith<TicketDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketDetailStateCopyWith<$Res> {
  factory $TicketDetailStateCopyWith(
          TicketDetailState value, $Res Function(TicketDetailState) then) =
      _$TicketDetailStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      bool isError,
      UserEntity? guide,
      List<TypeMoveEntity> typesMove,
      List<CategoryPeopleEntity> categoryPeople});
}

/// @nodoc
class _$TicketDetailStateCopyWithImpl<$Res>
    implements $TicketDetailStateCopyWith<$Res> {
  _$TicketDetailStateCopyWithImpl(this._value, this._then);

  final TicketDetailState _value;
  // ignore: unused_field
  final $Res Function(TicketDetailState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isError = freezed,
    Object? guide = freezed,
    Object? typesMove = freezed,
    Object? categoryPeople = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      guide: guide == freezed
          ? _value.guide
          : guide // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
      categoryPeople: categoryPeople == freezed
          ? _value.categoryPeople
          : categoryPeople // ignore: cast_nullable_to_non_nullable
              as List<CategoryPeopleEntity>,
    ));
  }
}

/// @nodoc
abstract class _$TicketDetailStateCopyWith<$Res>
    implements $TicketDetailStateCopyWith<$Res> {
  factory _$TicketDetailStateCopyWith(
          _TicketDetailState value, $Res Function(_TicketDetailState) then) =
      __$TicketDetailStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      bool isError,
      UserEntity? guide,
      List<TypeMoveEntity> typesMove,
      List<CategoryPeopleEntity> categoryPeople});
}

/// @nodoc
class __$TicketDetailStateCopyWithImpl<$Res>
    extends _$TicketDetailStateCopyWithImpl<$Res>
    implements _$TicketDetailStateCopyWith<$Res> {
  __$TicketDetailStateCopyWithImpl(
      _TicketDetailState _value, $Res Function(_TicketDetailState) _then)
      : super(_value, (v) => _then(v as _TicketDetailState));

  @override
  _TicketDetailState get _value => super._value as _TicketDetailState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isError = freezed,
    Object? guide = freezed,
    Object? typesMove = freezed,
    Object? categoryPeople = freezed,
  }) {
    return _then(_TicketDetailState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      guide: guide == freezed
          ? _value.guide
          : guide // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
      categoryPeople: categoryPeople == freezed
          ? _value.categoryPeople
          : categoryPeople // ignore: cast_nullable_to_non_nullable
              as List<CategoryPeopleEntity>,
    ));
  }
}

/// @nodoc

class _$_TicketDetailState implements _TicketDetailState {
  const _$_TicketDetailState(
      {this.isLoading = false,
      this.isError = false,
      this.guide,
      this.typesMove = const [],
      this.categoryPeople = const []});

  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isError;
  @override
  final UserEntity? guide;
  @JsonKey()
  @override
  final List<TypeMoveEntity> typesMove;
  @JsonKey()
  @override
  final List<CategoryPeopleEntity> categoryPeople;

  @override
  String toString() {
    return 'TicketDetailState(isLoading: $isLoading, isError: $isError, guide: $guide, typesMove: $typesMove, categoryPeople: $categoryPeople)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TicketDetailState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.guide, guide) &&
            const DeepCollectionEquality().equals(other.typesMove, typesMove) &&
            const DeepCollectionEquality()
                .equals(other.categoryPeople, categoryPeople));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(guide),
      const DeepCollectionEquality().hash(typesMove),
      const DeepCollectionEquality().hash(categoryPeople));

  @JsonKey(ignore: true)
  @override
  _$TicketDetailStateCopyWith<_TicketDetailState> get copyWith =>
      __$TicketDetailStateCopyWithImpl<_TicketDetailState>(this, _$identity);
}

abstract class _TicketDetailState implements TicketDetailState {
  const factory _TicketDetailState(
      {bool isLoading,
      bool isError,
      UserEntity? guide,
      List<TypeMoveEntity> typesMove,
      List<CategoryPeopleEntity> categoryPeople}) = _$_TicketDetailState;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  UserEntity? get guide;
  @override
  List<TypeMoveEntity> get typesMove;
  @override
  List<CategoryPeopleEntity> get categoryPeople;
  @override
  @JsonKey(ignore: true)
  _$TicketDetailStateCopyWith<_TicketDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}
