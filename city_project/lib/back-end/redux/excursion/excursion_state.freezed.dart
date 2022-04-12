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
      {List<ExcursionEntiti> excursions = const [],
      List<UserEntity> users = const [],
      List<TypeEntity> types = const [],
      bool isError = false,
      bool isLoading = false}) {
    return _ListExcursionsState(
      excursions: excursions,
      users: users,
      types: types,
      isError: isError,
      isLoading: isLoading,
    );
  }
}

/// @nodoc
const $ListExcursionsState = _$ListExcursionsStateTearOff();

/// @nodoc
mixin _$ListExcursionsState {
  List<ExcursionEntiti> get excursions => throw _privateConstructorUsedError;
  List<UserEntity> get users => throw _privateConstructorUsedError;
  List<TypeEntity> get types => throw _privateConstructorUsedError;
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
      {List<ExcursionEntiti> excursions,
      List<UserEntity> users,
      List<TypeEntity> types,
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
    Object? isError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      excursions: excursions == freezed
          ? _value.excursions
          : excursions // ignore: cast_nullable_to_non_nullable
              as List<ExcursionEntiti>,
      users: users == freezed
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<TypeEntity>,
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
      {List<ExcursionEntiti> excursions,
      List<UserEntity> users,
      List<TypeEntity> types,
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
    Object? isError = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_ListExcursionsState(
      excursions: excursions == freezed
          ? _value.excursions
          : excursions // ignore: cast_nullable_to_non_nullable
              as List<ExcursionEntiti>,
      users: users == freezed
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<TypeEntity>,
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
      this.isError = false,
      this.isLoading = false});

  @JsonKey()
  @override
  final List<ExcursionEntiti> excursions;
  @JsonKey()
  @override
  final List<UserEntity> users;
  @JsonKey()
  @override
  final List<TypeEntity> types;
  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'ListExcursionsState(excursions: $excursions, users: $users, types: $types, isError: $isError, isLoading: $isLoading)';
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
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(excursions),
      const DeepCollectionEquality().hash(users),
      const DeepCollectionEquality().hash(types),
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
      {List<ExcursionEntiti> excursions,
      List<UserEntity> users,
      List<TypeEntity> types,
      bool isError,
      bool isLoading}) = _$_ListExcursionsState;

  @override
  List<ExcursionEntiti> get excursions;
  @override
  List<UserEntity> get users;
  @override
  List<TypeEntity> get types;
  @override
  bool get isError;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$ListExcursionsStateCopyWith<_ListExcursionsState> get copyWith =>
      throw _privateConstructorUsedError;
}
