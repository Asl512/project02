// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RecordListStateTearOff {
  const _$RecordListStateTearOff();

  _RecordListState call(
      {bool isLoading = false,
      bool isError = false,
      List<Record> records = const []}) {
    return _RecordListState(
      isLoading: isLoading,
      isError: isError,
      records: records,
    );
  }
}

/// @nodoc
const $RecordListState = _$RecordListStateTearOff();

/// @nodoc
mixin _$RecordListState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  List<Record> get records => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordListStateCopyWith<RecordListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordListStateCopyWith<$Res> {
  factory $RecordListStateCopyWith(
          RecordListState value, $Res Function(RecordListState) then) =
      _$RecordListStateCopyWithImpl<$Res>;
  $Res call({bool isLoading, bool isError, List<Record> records});
}

/// @nodoc
class _$RecordListStateCopyWithImpl<$Res>
    implements $RecordListStateCopyWith<$Res> {
  _$RecordListStateCopyWithImpl(this._value, this._then);

  final RecordListState _value;
  // ignore: unused_field
  final $Res Function(RecordListState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isError = freezed,
    Object? records = freezed,
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
      records: records == freezed
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<Record>,
    ));
  }
}

/// @nodoc
abstract class _$RecordListStateCopyWith<$Res>
    implements $RecordListStateCopyWith<$Res> {
  factory _$RecordListStateCopyWith(
          _RecordListState value, $Res Function(_RecordListState) then) =
      __$RecordListStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isLoading, bool isError, List<Record> records});
}

/// @nodoc
class __$RecordListStateCopyWithImpl<$Res>
    extends _$RecordListStateCopyWithImpl<$Res>
    implements _$RecordListStateCopyWith<$Res> {
  __$RecordListStateCopyWithImpl(
      _RecordListState _value, $Res Function(_RecordListState) _then)
      : super(_value, (v) => _then(v as _RecordListState));

  @override
  _RecordListState get _value => super._value as _RecordListState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isError = freezed,
    Object? records = freezed,
  }) {
    return _then(_RecordListState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      records: records == freezed
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<Record>,
    ));
  }
}

/// @nodoc

class _$_RecordListState implements _RecordListState {
  const _$_RecordListState(
      {this.isLoading = false, this.isError = false, this.records = const []});

  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final List<Record> records;

  @override
  String toString() {
    return 'RecordListState(isLoading: $isLoading, isError: $isError, records: $records)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordListState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.records, records));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(records));

  @JsonKey(ignore: true)
  @override
  _$RecordListStateCopyWith<_RecordListState> get copyWith =>
      __$RecordListStateCopyWithImpl<_RecordListState>(this, _$identity);
}

abstract class _RecordListState implements RecordListState {
  const factory _RecordListState(
      {bool isLoading,
      bool isError,
      List<Record> records}) = _$_RecordListState;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  List<Record> get records;
  @override
  @JsonKey(ignore: true)
  _$RecordListStateCopyWith<_RecordListState> get copyWith =>
      throw _privateConstructorUsedError;
}
