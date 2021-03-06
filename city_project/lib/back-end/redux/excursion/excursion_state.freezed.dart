// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'excursion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ListExcursionsStateTearOff {
  const _$ListExcursionsStateTearOff();

  _ListExcursionsState call(
      {List<ExcursionEntity> excursions = const [],
      List<UserEntity> users = const [],
      List<TypeEntity> types = const [],
      List<CurrencyEntity> currencies = const [],
      bool isError = false,
      bool isLoading = false}) {
    return _ListExcursionsState(
      excursions: excursions,
      users: users,
      types: types,
      currencies: currencies,
      isError: isError,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $ListExcursionsState = _$ListExcursionsStateTearOff();

/// @nodoc
mixin _$ListExcursionsState {
  List<ExcursionEntity> get excursions => throw _privateConstructorUsedError;
  List<UserEntity> get users => throw _privateConstructorUsedError;
  List<TypeEntity> get types => throw _privateConstructorUsedError;
  List<CurrencyEntity> get currencies => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListExcursionsStateCopyWith<ListExcursionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListExcursionsStateCopyWith<$Res> {
  factory $ListExcursionsStateCopyWith(
          ListExcursionsState value, $Res Function(ListExcursionsState) then) =
      _$ListExcursionsStateCopyWithImpl<$Res>;
  $Res call(
      {List<ExcursionEntity> excursions,
      List<UserEntity> users,
      List<TypeEntity> types,
      List<CurrencyEntity> currencies,
      bool isError,
      bool isLoading});
}

/// @nodoc
class _$ListExcursionsStateCopyWithImpl<$Res>
    implements $ListExcursionsStateCopyWith<$Res> {
  _$ListExcursionsStateCopyWithImpl(this._value, this._then);

  final ListExcursionsState _value;
  // ignore: unused_field
  final $Res Function(ListExcursionsState) _then;

  @override
  $Res call({
    Object? excursions = freezed,
    Object? users = freezed,
    Object? types = freezed,
    Object? currencies = freezed,
    Object? isError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      excursions: excursions == freezed
          ? _value.excursions
          : excursions // ignore: cast_nullable_to_non_nullable
              as List<ExcursionEntity>,
      users: users == freezed
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<TypeEntity>,
      currencies: currencies == freezed
          ? _value.currencies
          : currencies // ignore: cast_nullable_to_non_nullable
              as List<CurrencyEntity>,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ListExcursionsStateCopyWith<$Res>
    implements $ListExcursionsStateCopyWith<$Res> {
  factory _$ListExcursionsStateCopyWith(_ListExcursionsState value,
          $Res Function(_ListExcursionsState) then) =
      __$ListExcursionsStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<ExcursionEntity> excursions,
      List<UserEntity> users,
      List<TypeEntity> types,
      List<CurrencyEntity> currencies,
      bool isError,
      bool isLoading});
}

/// @nodoc
class __$ListExcursionsStateCopyWithImpl<$Res>
    extends _$ListExcursionsStateCopyWithImpl<$Res>
    implements _$ListExcursionsStateCopyWith<$Res> {
  __$ListExcursionsStateCopyWithImpl(
      _ListExcursionsState _value, $Res Function(_ListExcursionsState) _then)
      : super(_value, (v) => _then(v as _ListExcursionsState));

  @override
  _ListExcursionsState get _value => super._value as _ListExcursionsState;

  @override
  $Res call({
    Object? excursions = freezed,
    Object? users = freezed,
    Object? types = freezed,
    Object? currencies = freezed,
    Object? isError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_ListExcursionsState(
      excursions: excursions == freezed
          ? _value.excursions
          : excursions // ignore: cast_nullable_to_non_nullable
              as List<ExcursionEntity>,
      users: users == freezed
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<TypeEntity>,
      currencies: currencies == freezed
          ? _value.currencies
          : currencies // ignore: cast_nullable_to_non_nullable
              as List<CurrencyEntity>,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ListExcursionsState implements _ListExcursionsState {
  const _$_ListExcursionsState(
      {this.excursions = const [],
      this.users = const [],
      this.types = const [],
      this.currencies = const [],
      this.isError = false,
      this.isLoading = false});

  @JsonKey()
  @override
  final List<ExcursionEntity> excursions;
  @JsonKey()
  @override
  final List<UserEntity> users;
  @JsonKey()
  @override
  final List<TypeEntity> types;
  @JsonKey()
  @override
  final List<CurrencyEntity> currencies;
  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'ListExcursionsState(excursions: $excursions, users: $users, types: $types, currencies: $currencies, isError: $isError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListExcursionsState &&
            const DeepCollectionEquality()
                .equals(other.excursions, excursions) &&
            const DeepCollectionEquality().equals(other.users, users) &&
            const DeepCollectionEquality().equals(other.types, types) &&
            const DeepCollectionEquality()
                .equals(other.currencies, currencies) &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(excursions),
      const DeepCollectionEquality().hash(users),
      const DeepCollectionEquality().hash(types),
      const DeepCollectionEquality().hash(currencies),
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$ListExcursionsStateCopyWith<_ListExcursionsState> get copyWith =>
      __$ListExcursionsStateCopyWithImpl<_ListExcursionsState>(
          this, _$identity);
}

abstract class _ListExcursionsState implements ListExcursionsState {
  const factory _ListExcursionsState(
      {List<ExcursionEntity> excursions,
      List<UserEntity> users,
      List<TypeEntity> types,
      List<CurrencyEntity> currencies,
      bool isError,
      bool isLoading}) = _$_ListExcursionsState;

  @override
  List<ExcursionEntity> get excursions;
  @override
  List<UserEntity> get users;
  @override
  List<TypeEntity> get types;
  @override
  List<CurrencyEntity> get currencies;
  @override
  bool get isError;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$ListExcursionsStateCopyWith<_ListExcursionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ExcursionInfoStateTearOff {
  const _$ExcursionInfoStateTearOff();

  _ExcursionInfoState call(
      {ExcursionEntity? excursion,
      UserEntity? user,
      TypeEntity? type,
      CurrencyEntity? currency,
      List<ReviewsEntity>? reviews,
      List<UserEntity>? userReview,
      List<TagEntity> tags = const [],
      List<TypeMoveEntity> typesMove = const [],
      bool isError = false,
      bool isLoading = false}) {
    return _ExcursionInfoState(
      excursion: excursion,
      user: user,
      type: type,
      currency: currency,
      reviews: reviews,
      userReview: userReview,
      tags: tags,
      typesMove: typesMove,
      isError: isError,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $ExcursionInfoState = _$ExcursionInfoStateTearOff();

/// @nodoc
mixin _$ExcursionInfoState {
  ExcursionEntity? get excursion => throw _privateConstructorUsedError;
  UserEntity? get user => throw _privateConstructorUsedError;
  TypeEntity? get type => throw _privateConstructorUsedError;
  CurrencyEntity? get currency => throw _privateConstructorUsedError;
  List<ReviewsEntity>? get reviews => throw _privateConstructorUsedError;
  List<UserEntity>? get userReview => throw _privateConstructorUsedError;
  List<TagEntity> get tags => throw _privateConstructorUsedError;
  List<TypeMoveEntity> get typesMove => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExcursionInfoStateCopyWith<ExcursionInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExcursionInfoStateCopyWith<$Res> {
  factory $ExcursionInfoStateCopyWith(
          ExcursionInfoState value, $Res Function(ExcursionInfoState) then) =
      _$ExcursionInfoStateCopyWithImpl<$Res>;
  $Res call(
      {ExcursionEntity? excursion,
      UserEntity? user,
      TypeEntity? type,
      CurrencyEntity? currency,
      List<ReviewsEntity>? reviews,
      List<UserEntity>? userReview,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove,
      bool isError,
      bool isLoading});
}

/// @nodoc
class _$ExcursionInfoStateCopyWithImpl<$Res>
    implements $ExcursionInfoStateCopyWith<$Res> {
  _$ExcursionInfoStateCopyWithImpl(this._value, this._then);

  final ExcursionInfoState _value;
  // ignore: unused_field
  final $Res Function(ExcursionInfoState) _then;

  @override
  $Res call({
    Object? excursion = freezed,
    Object? user = freezed,
    Object? type = freezed,
    Object? currency = freezed,
    Object? reviews = freezed,
    Object? userReview = freezed,
    Object? tags = freezed,
    Object? typesMove = freezed,
    Object? isError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      excursion: excursion == freezed
          ? _value.excursion
          : excursion // ignore: cast_nullable_to_non_nullable
              as ExcursionEntity?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeEntity?,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as CurrencyEntity?,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewsEntity>?,
      userReview: userReview == freezed
          ? _value.userReview
          : userReview // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagEntity>,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ExcursionInfoStateCopyWith<$Res>
    implements $ExcursionInfoStateCopyWith<$Res> {
  factory _$ExcursionInfoStateCopyWith(
          _ExcursionInfoState value, $Res Function(_ExcursionInfoState) then) =
      __$ExcursionInfoStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {ExcursionEntity? excursion,
      UserEntity? user,
      TypeEntity? type,
      CurrencyEntity? currency,
      List<ReviewsEntity>? reviews,
      List<UserEntity>? userReview,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove,
      bool isError,
      bool isLoading});
}

/// @nodoc
class __$ExcursionInfoStateCopyWithImpl<$Res>
    extends _$ExcursionInfoStateCopyWithImpl<$Res>
    implements _$ExcursionInfoStateCopyWith<$Res> {
  __$ExcursionInfoStateCopyWithImpl(
      _ExcursionInfoState _value, $Res Function(_ExcursionInfoState) _then)
      : super(_value, (v) => _then(v as _ExcursionInfoState));

  @override
  _ExcursionInfoState get _value => super._value as _ExcursionInfoState;

  @override
  $Res call({
    Object? excursion = freezed,
    Object? user = freezed,
    Object? type = freezed,
    Object? currency = freezed,
    Object? reviews = freezed,
    Object? userReview = freezed,
    Object? tags = freezed,
    Object? typesMove = freezed,
    Object? isError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_ExcursionInfoState(
      excursion: excursion == freezed
          ? _value.excursion
          : excursion // ignore: cast_nullable_to_non_nullable
              as ExcursionEntity?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeEntity?,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as CurrencyEntity?,
      reviews: reviews == freezed
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewsEntity>?,
      userReview: userReview == freezed
          ? _value.userReview
          : userReview // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagEntity>,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ExcursionInfoState implements _ExcursionInfoState {
  const _$_ExcursionInfoState(
      {this.excursion,
      this.user,
      this.type,
      this.currency,
      this.reviews,
      this.userReview,
      this.tags = const [],
      this.typesMove = const [],
      this.isError = false,
      this.isLoading = false});

  @override
  final ExcursionEntity? excursion;
  @override
  final UserEntity? user;
  @override
  final TypeEntity? type;
  @override
  final CurrencyEntity? currency;
  @override
  final List<ReviewsEntity>? reviews;
  @override
  final List<UserEntity>? userReview;
  @JsonKey()
  @override
  final List<TagEntity> tags;
  @JsonKey()
  @override
  final List<TypeMoveEntity> typesMove;
  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'ExcursionInfoState(excursion: $excursion, user: $user, type: $type, currency: $currency, reviews: $reviews, userReview: $userReview, tags: $tags, typesMove: $typesMove, isError: $isError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExcursionInfoState &&
            const DeepCollectionEquality().equals(other.excursion, excursion) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.currency, currency) &&
            const DeepCollectionEquality().equals(other.reviews, reviews) &&
            const DeepCollectionEquality()
                .equals(other.userReview, userReview) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.typesMove, typesMove) &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(excursion),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(currency),
      const DeepCollectionEquality().hash(reviews),
      const DeepCollectionEquality().hash(userReview),
      const DeepCollectionEquality().hash(tags),
      const DeepCollectionEquality().hash(typesMove),
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(isLoading));

  @JsonKey(ignore: true)
  @override
  _$ExcursionInfoStateCopyWith<_ExcursionInfoState> get copyWith =>
      __$ExcursionInfoStateCopyWithImpl<_ExcursionInfoState>(this, _$identity);
}

abstract class _ExcursionInfoState implements ExcursionInfoState {
  const factory _ExcursionInfoState(
      {ExcursionEntity? excursion,
      UserEntity? user,
      TypeEntity? type,
      CurrencyEntity? currency,
      List<ReviewsEntity>? reviews,
      List<UserEntity>? userReview,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove,
      bool isError,
      bool isLoading}) = _$_ExcursionInfoState;

  @override
  ExcursionEntity? get excursion;
  @override
  UserEntity? get user;
  @override
  TypeEntity? get type;
  @override
  CurrencyEntity? get currency;
  @override
  List<ReviewsEntity>? get reviews;
  @override
  List<UserEntity>? get userReview;
  @override
  List<TagEntity> get tags;
  @override
  List<TypeMoveEntity> get typesMove;
  @override
  bool get isError;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$ExcursionInfoStateCopyWith<_ExcursionInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}
