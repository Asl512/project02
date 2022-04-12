// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'city_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ListCitiesStateTearOff {
  const _$ListCitiesStateTearOff();

  _ListCitiesState call(
      {bool isError = false,
      bool isLoading = false,
      List<CityEntiti> cities = const []}) {
    return _ListCitiesState(
      isError: isError,
      isLoading: isLoading,
      cities: cities,
    );
  }
}

/// @nodoc
const $ListCitiesState = _$ListCitiesStateTearOff();

/// @nodoc
mixin _$ListCitiesState {
  bool get isError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<CityEntiti> get cities => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListCitiesStateCopyWith<ListCitiesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListCitiesStateCopyWith<$Res> {
  factory $ListCitiesStateCopyWith(
          ListCitiesState value, $Res Function(ListCitiesState) then) =
      _$ListCitiesStateCopyWithImpl<$Res>;
  $Res call({bool isError, bool isLoading, List<CityEntiti> cities});
}

/// @nodoc
class _$ListCitiesStateCopyWithImpl<$Res>
    implements $ListCitiesStateCopyWith<$Res> {
  _$ListCitiesStateCopyWithImpl(this._value, this._then);

  final ListCitiesState _value;
  // ignore: unused_field
  final $Res Function(ListCitiesState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? cities = freezed,
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
      cities: cities == freezed
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<CityEntiti>,
    ));
  }
}

/// @nodoc
abstract class _$ListCitiesStateCopyWith<$Res>
    implements $ListCitiesStateCopyWith<$Res> {
  factory _$ListCitiesStateCopyWith(
          _ListCitiesState value, $Res Function(_ListCitiesState) then) =
      __$ListCitiesStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isError, bool isLoading, List<CityEntiti> cities});
}

/// @nodoc
class __$ListCitiesStateCopyWithImpl<$Res>
    extends _$ListCitiesStateCopyWithImpl<$Res>
    implements _$ListCitiesStateCopyWith<$Res> {
  __$ListCitiesStateCopyWithImpl(
      _ListCitiesState _value, $Res Function(_ListCitiesState) _then)
      : super(_value, (v) => _then(v as _ListCitiesState));

  @override
  _ListCitiesState get _value => super._value as _ListCitiesState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? cities = freezed,
  }) {
    return _then(_ListCitiesState(
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cities: cities == freezed
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<CityEntiti>,
    ));
  }
}

/// @nodoc

class _$_ListCitiesState implements _ListCitiesState {
  const _$_ListCitiesState(
      {this.isError = false, this.isLoading = false, this.cities = const []});

  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final List<CityEntiti> cities;

  @override
  String toString() {
    return 'ListCitiesState(isError: $isError, isLoading: $isLoading, cities: $cities)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListCitiesState &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.cities, cities));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(cities));

  @JsonKey(ignore: true)
  @override
  _$ListCitiesStateCopyWith<_ListCitiesState> get copyWith =>
      __$ListCitiesStateCopyWithImpl<_ListCitiesState>(this, _$identity);
}

abstract class _ListCitiesState implements ListCitiesState {
  const factory _ListCitiesState(
      {bool isError,
      bool isLoading,
      List<CityEntiti> cities}) = _$_ListCitiesState;

  @override
  bool get isError;
  @override
  bool get isLoading;
  @override
  List<CityEntiti> get cities;
  @override
  @JsonKey(ignore: true)
  _$ListCitiesStateCopyWith<_ListCitiesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CityStateTearOff {
  const _$CityStateTearOff();

  _CityState call(
      {bool isError = false, bool isLoading = false, CityEntiti? city}) {
    return _CityState(
      isError: isError,
      isLoading: isLoading,
      city: city,
    );
  }
}

/// @nodoc
const $CityState = _$CityStateTearOff();

/// @nodoc
mixin _$CityState {
  bool get isError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  CityEntiti? get city => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CityStateCopyWith<CityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityStateCopyWith<$Res> {
  factory $CityStateCopyWith(CityState value, $Res Function(CityState) then) =
      _$CityStateCopyWithImpl<$Res>;
  $Res call({bool isError, bool isLoading, CityEntiti? city});
}

/// @nodoc
class _$CityStateCopyWithImpl<$Res> implements $CityStateCopyWith<$Res> {
  _$CityStateCopyWithImpl(this._value, this._then);

  final CityState _value;
  // ignore: unused_field
  final $Res Function(CityState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? city = freezed,
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
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityEntiti?,
    ));
  }
}

/// @nodoc
abstract class _$CityStateCopyWith<$Res> implements $CityStateCopyWith<$Res> {
  factory _$CityStateCopyWith(
          _CityState value, $Res Function(_CityState) then) =
      __$CityStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isError, bool isLoading, CityEntiti? city});
}

/// @nodoc
class __$CityStateCopyWithImpl<$Res> extends _$CityStateCopyWithImpl<$Res>
    implements _$CityStateCopyWith<$Res> {
  __$CityStateCopyWithImpl(_CityState _value, $Res Function(_CityState) _then)
      : super(_value, (v) => _then(v as _CityState));

  @override
  _CityState get _value => super._value as _CityState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? city = freezed,
  }) {
    return _then(_CityState(
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityEntiti?,
    ));
  }
}

/// @nodoc

class _$_CityState implements _CityState {
  const _$_CityState({this.isError = false, this.isLoading = false, this.city});

  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final bool isLoading;
  @override
  final CityEntiti? city;

  @override
  String toString() {
    return 'CityState(isError: $isError, isLoading: $isLoading, city: $city)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CityState &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.city, city));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(city));

  @JsonKey(ignore: true)
  @override
  _$CityStateCopyWith<_CityState> get copyWith =>
      __$CityStateCopyWithImpl<_CityState>(this, _$identity);
}

abstract class _CityState implements CityState {
  const factory _CityState({bool isError, bool isLoading, CityEntiti? city}) =
      _$_CityState;

  @override
  bool get isError;
  @override
  bool get isLoading;
  @override
  CityEntiti? get city;
  @override
  @JsonKey(ignore: true)
  _$CityStateCopyWith<_CityState> get copyWith =>
      throw _privateConstructorUsedError;
}
