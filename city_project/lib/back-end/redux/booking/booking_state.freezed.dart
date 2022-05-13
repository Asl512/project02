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
class _$BookingStateTearOff {
  const _$BookingStateTearOff();

  _BookingState call(
      {bool isLoading = false,
      List<dynamic> errorCountTickets = const [false, 'errorCountTickets'],
      List<dynamic> errorPhone = const [false, 'errorPhone'],
      List<dynamic> errorDate = const [false, 'errorDate'],
      int price = 0}) {
    return _BookingState(
      isLoading: isLoading,
      errorCountTickets: errorCountTickets,
      errorPhone: errorPhone,
      errorDate: errorDate,
      price: price,
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
  int get price => throw _privateConstructorUsedError;

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
      int price});
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
    Object? price = freezed,
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
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
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
      int price});
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
    Object? price = freezed,
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
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
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
      this.price = 0});

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
  final int price;

  @override
  String toString() {
    return 'BookingState(isLoading: $isLoading, errorCountTickets: $errorCountTickets, errorPhone: $errorPhone, errorDate: $errorDate, price: $price)';
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
            const DeepCollectionEquality().equals(other.price, price));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(errorCountTickets),
      const DeepCollectionEquality().hash(errorPhone),
      const DeepCollectionEquality().hash(errorDate),
      const DeepCollectionEquality().hash(price));

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
      int price}) = _$_BookingState;

  @override
  bool get isLoading;
  @override
  List<dynamic> get errorCountTickets;
  @override
  List<dynamic> get errorPhone;
  @override
  List<dynamic> get errorDate;
  @override
  int get price;
  @override
  @JsonKey(ignore: true)
  _$BookingStateCopyWith<_BookingState> get copyWith =>
      throw _privateConstructorUsedError;
}
