// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BookingInfoStateTearOff {
  const _$BookingInfoStateTearOff();

  _BookingInfoState call(
      {bool isError = false,
      bool isLoading = false,
      bool isAuth = false,
      List<CategoryPeopleEntity> categoriesPeople = const [],
      ExcursionEntity? excursion}) {
    return _BookingInfoState(
      isError: isError,
      isLoading: isLoading,
      isAuth: isAuth,
      categoriesPeople: categoriesPeople,
      excursion: excursion,
    );
  }
}

/// @nodoc
const $BookingInfoState = _$BookingInfoStateTearOff();

/// @nodoc
mixin _$BookingInfoState {
  bool get isError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isAuth => throw _privateConstructorUsedError;
  List<CategoryPeopleEntity> get categoriesPeople =>
      throw _privateConstructorUsedError;
  ExcursionEntity? get excursion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingInfoStateCopyWith<BookingInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingInfoStateCopyWith<$Res> {
  factory $BookingInfoStateCopyWith(
          BookingInfoState value, $Res Function(BookingInfoState) then) =
      _$BookingInfoStateCopyWithImpl<$Res>;
  $Res call(
      {bool isError,
      bool isLoading,
      bool isAuth,
      List<CategoryPeopleEntity> categoriesPeople,
      ExcursionEntity? excursion});
}

/// @nodoc
class _$BookingInfoStateCopyWithImpl<$Res>
    implements $BookingInfoStateCopyWith<$Res> {
  _$BookingInfoStateCopyWithImpl(this._value, this._then);

  final BookingInfoState _value;
  // ignore: unused_field
  final $Res Function(BookingInfoState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? isAuth = freezed,
    Object? categoriesPeople = freezed,
    Object? excursion = freezed,
  }) {
    return _then(_value.copyWith(
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuth: isAuth == freezed
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      categoriesPeople: categoriesPeople == freezed
          ? _value.categoriesPeople
          : categoriesPeople // ignore: cast_nullable_to_non_nullable
              as List<CategoryPeopleEntity>,
      excursion: excursion == freezed
          ? _value.excursion
          : excursion // ignore: cast_nullable_to_non_nullable
              as ExcursionEntity?,
    ));
  }
}

/// @nodoc
abstract class _$BookingInfoStateCopyWith<$Res>
    implements $BookingInfoStateCopyWith<$Res> {
  factory _$BookingInfoStateCopyWith(
          _BookingInfoState value, $Res Function(_BookingInfoState) then) =
      __$BookingInfoStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isError,
      bool isLoading,
      bool isAuth,
      List<CategoryPeopleEntity> categoriesPeople,
      ExcursionEntity? excursion});
}

/// @nodoc
class __$BookingInfoStateCopyWithImpl<$Res>
    extends _$BookingInfoStateCopyWithImpl<$Res>
    implements _$BookingInfoStateCopyWith<$Res> {
  __$BookingInfoStateCopyWithImpl(
      _BookingInfoState _value, $Res Function(_BookingInfoState) _then)
      : super(_value, (v) => _then(v as _BookingInfoState));

  @override
  _BookingInfoState get _value => super._value as _BookingInfoState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? isAuth = freezed,
    Object? categoriesPeople = freezed,
    Object? excursion = freezed,
  }) {
    return _then(_BookingInfoState(
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuth: isAuth == freezed
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      categoriesPeople: categoriesPeople == freezed
          ? _value.categoriesPeople
          : categoriesPeople // ignore: cast_nullable_to_non_nullable
              as List<CategoryPeopleEntity>,
      excursion: excursion == freezed
          ? _value.excursion
          : excursion // ignore: cast_nullable_to_non_nullable
              as ExcursionEntity?,
    ));
  }
}

/// @nodoc

class _$_BookingInfoState implements _BookingInfoState {
  const _$_BookingInfoState(
      {this.isError = false,
      this.isLoading = false,
      this.isAuth = false,
      this.categoriesPeople = const [],
      this.excursion});

  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isAuth;
  @JsonKey()
  @override
  final List<CategoryPeopleEntity> categoriesPeople;
  @override
  final ExcursionEntity? excursion;

  @override
  String toString() {
    return 'BookingInfoState(isError: $isError, isLoading: $isLoading, isAuth: $isAuth, categoriesPeople: $categoriesPeople, excursion: $excursion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookingInfoState &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.isAuth, isAuth) &&
            const DeepCollectionEquality()
                .equals(other.categoriesPeople, categoriesPeople) &&
            const DeepCollectionEquality().equals(other.excursion, excursion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isAuth),
      const DeepCollectionEquality().hash(categoriesPeople),
      const DeepCollectionEquality().hash(excursion));

  @JsonKey(ignore: true)
  @override
  _$BookingInfoStateCopyWith<_BookingInfoState> get copyWith =>
      __$BookingInfoStateCopyWithImpl<_BookingInfoState>(this, _$identity);
}

abstract class _BookingInfoState implements BookingInfoState {
  const factory _BookingInfoState(
      {bool isError,
      bool isLoading,
      bool isAuth,
      List<CategoryPeopleEntity> categoriesPeople,
      ExcursionEntity? excursion}) = _$_BookingInfoState;

  @override
  bool get isError;
  @override
  bool get isLoading;
  @override
  bool get isAuth;
  @override
  List<CategoryPeopleEntity> get categoriesPeople;
  @override
  ExcursionEntity? get excursion;
  @override
  @JsonKey(ignore: true)
  _$BookingInfoStateCopyWith<_BookingInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$BookingStateTearOff {
  const _$BookingStateTearOff();

  _BookingState call(
      {bool isLoading = false,
      List<dynamic> errorCountTickets = const [false, 'errorCountTickets'],
      List<dynamic> errorPhone = const [false, 'errorPhone'],
      List<dynamic> errorDate = const [false, 'errorDate'],
      List<dynamic> errorDateForIndividual = const [
        false,
        'errorDateForIndividual'
      ],
      List<dynamic> errorTimeForIndividual = const [
        false,
        'errorTimeForIndividual'
      ],
      List<dynamic> errorMeetPoint = const [false, 'errorMeetPoint']}) {
    return _BookingState(
      isLoading: isLoading,
      errorCountTickets: errorCountTickets,
      errorPhone: errorPhone,
      errorDate: errorDate,
      errorDateForIndividual: errorDateForIndividual,
      errorTimeForIndividual: errorTimeForIndividual,
      errorMeetPoint: errorMeetPoint,
    );
  }
}

/// @nodoc
const $BookingState = _$BookingStateTearOff();

/// @nodoc
mixin _$BookingState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<dynamic> get errorCountTickets => throw _privateConstructorUsedError;
  List<dynamic> get errorPhone => throw _privateConstructorUsedError;
  List<dynamic> get errorDate => throw _privateConstructorUsedError;
  List<dynamic> get errorDateForIndividual =>
      throw _privateConstructorUsedError;
  List<dynamic> get errorTimeForIndividual =>
      throw _privateConstructorUsedError;
  List<dynamic> get errorMeetPoint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingStateCopyWith<BookingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<$Res> {
  factory $BookingStateCopyWith(
          BookingState value, $Res Function(BookingState) then) =
      _$BookingStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      List<dynamic> errorCountTickets,
      List<dynamic> errorPhone,
      List<dynamic> errorDate,
      List<dynamic> errorDateForIndividual,
      List<dynamic> errorTimeForIndividual,
      List<dynamic> errorMeetPoint});
}

/// @nodoc
class _$BookingStateCopyWithImpl<$Res> implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

  final BookingState _value;
  // ignore: unused_field
  final $Res Function(BookingState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? errorCountTickets = freezed,
    Object? errorPhone = freezed,
    Object? errorDate = freezed,
    Object? errorDateForIndividual = freezed,
    Object? errorTimeForIndividual = freezed,
    Object? errorMeetPoint = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCountTickets: errorCountTickets == freezed
          ? _value.errorCountTickets
          : errorCountTickets // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorPhone: errorPhone == freezed
          ? _value.errorPhone
          : errorPhone // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorDate: errorDate == freezed
          ? _value.errorDate
          : errorDate // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorDateForIndividual: errorDateForIndividual == freezed
          ? _value.errorDateForIndividual
          : errorDateForIndividual // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorTimeForIndividual: errorTimeForIndividual == freezed
          ? _value.errorTimeForIndividual
          : errorTimeForIndividual // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorMeetPoint: errorMeetPoint == freezed
          ? _value.errorMeetPoint
          : errorMeetPoint // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$BookingStateCopyWith<$Res>
    implements $BookingStateCopyWith<$Res> {
  factory _$BookingStateCopyWith(
          _BookingState value, $Res Function(_BookingState) then) =
      __$BookingStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      List<dynamic> errorCountTickets,
      List<dynamic> errorPhone,
      List<dynamic> errorDate,
      List<dynamic> errorDateForIndividual,
      List<dynamic> errorTimeForIndividual,
      List<dynamic> errorMeetPoint});
}

/// @nodoc
class __$BookingStateCopyWithImpl<$Res> extends _$BookingStateCopyWithImpl<$Res>
    implements _$BookingStateCopyWith<$Res> {
  __$BookingStateCopyWithImpl(
      _BookingState _value, $Res Function(_BookingState) _then)
      : super(_value, (v) => _then(v as _BookingState));

  @override
  _BookingState get _value => super._value as _BookingState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? errorCountTickets = freezed,
    Object? errorPhone = freezed,
    Object? errorDate = freezed,
    Object? errorDateForIndividual = freezed,
    Object? errorTimeForIndividual = freezed,
    Object? errorMeetPoint = freezed,
  }) {
    return _then(_BookingState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorCountTickets: errorCountTickets == freezed
          ? _value.errorCountTickets
          : errorCountTickets // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorPhone: errorPhone == freezed
          ? _value.errorPhone
          : errorPhone // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorDate: errorDate == freezed
          ? _value.errorDate
          : errorDate // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorDateForIndividual: errorDateForIndividual == freezed
          ? _value.errorDateForIndividual
          : errorDateForIndividual // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorTimeForIndividual: errorTimeForIndividual == freezed
          ? _value.errorTimeForIndividual
          : errorTimeForIndividual // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorMeetPoint: errorMeetPoint == freezed
          ? _value.errorMeetPoint
          : errorMeetPoint // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc

class _$_BookingState implements _BookingState {
  const _$_BookingState(
      {this.isLoading = false,
      this.errorCountTickets = const [false, 'errorCountTickets'],
      this.errorPhone = const [false, 'errorPhone'],
      this.errorDate = const [false, 'errorDate'],
      this.errorDateForIndividual = const [false, 'errorDateForIndividual'],
      this.errorTimeForIndividual = const [false, 'errorTimeForIndividual'],
      this.errorMeetPoint = const [false, 'errorMeetPoint']});

  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final List<dynamic> errorCountTickets;
  @JsonKey()
  @override
  final List<dynamic> errorPhone;
  @JsonKey()
  @override
  final List<dynamic> errorDate;
  @JsonKey()
  @override
  final List<dynamic> errorDateForIndividual;
  @JsonKey()
  @override
  final List<dynamic> errorTimeForIndividual;
  @JsonKey()
  @override
  final List<dynamic> errorMeetPoint;

  @override
  String toString() {
    return 'BookingState(isLoading: $isLoading, errorCountTickets: $errorCountTickets, errorPhone: $errorPhone, errorDate: $errorDate, errorDateForIndividual: $errorDateForIndividual, errorTimeForIndividual: $errorTimeForIndividual, errorMeetPoint: $errorMeetPoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BookingState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.errorCountTickets, errorCountTickets) &&
            const DeepCollectionEquality()
                .equals(other.errorPhone, errorPhone) &&
            const DeepCollectionEquality().equals(other.errorDate, errorDate) &&
            const DeepCollectionEquality()
                .equals(other.errorDateForIndividual, errorDateForIndividual) &&
            const DeepCollectionEquality()
                .equals(other.errorTimeForIndividual, errorTimeForIndividual) &&
            const DeepCollectionEquality()
                .equals(other.errorMeetPoint, errorMeetPoint));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(errorCountTickets),
      const DeepCollectionEquality().hash(errorPhone),
      const DeepCollectionEquality().hash(errorDate),
      const DeepCollectionEquality().hash(errorDateForIndividual),
      const DeepCollectionEquality().hash(errorTimeForIndividual),
      const DeepCollectionEquality().hash(errorMeetPoint));

  @JsonKey(ignore: true)
  @override
  _$BookingStateCopyWith<_BookingState> get copyWith =>
      __$BookingStateCopyWithImpl<_BookingState>(this, _$identity);
}

abstract class _BookingState implements BookingState {
  const factory _BookingState(
      {bool isLoading,
      List<dynamic> errorCountTickets,
      List<dynamic> errorPhone,
      List<dynamic> errorDate,
      List<dynamic> errorDateForIndividual,
      List<dynamic> errorTimeForIndividual,
      List<dynamic> errorMeetPoint}) = _$_BookingState;

  @override
  bool get isLoading;
  @override
  List<dynamic> get errorCountTickets;
  @override
  List<dynamic> get errorPhone;
  @override
  List<dynamic> get errorDate;
  @override
  List<dynamic> get errorDateForIndividual;
  @override
  List<dynamic> get errorTimeForIndividual;
  @override
  List<dynamic> get errorMeetPoint;
  @override
  @JsonKey(ignore: true)
  _$BookingStateCopyWith<_BookingState> get copyWith =>
      throw _privateConstructorUsedError;
}
