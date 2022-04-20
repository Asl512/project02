// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'add_excursion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AddExcursionStateTearOff {
  const _$AddExcursionStateTearOff();

  _AddExcursionState call(
      {bool isError = false,
      bool isLoading = false,
      List<CityEntity> cities = const [],
      List<TypeEntity> types = const [],
      List<TagEntity> tags = const [],
      List<TypeMoveEntity> typesMove = const []}) {
    return _AddExcursionState(
      isError: isError,
      isLoading: isLoading,
      cities: cities,
      types: types,
      tags: tags,
      typesMove: typesMove,
    );
  }
}

/// @nodoc
const $AddExcursionState = _$AddExcursionStateTearOff();

/// @nodoc
mixin _$AddExcursionState {
  bool get isError => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  List<CityEntity> get cities => throw _privateConstructorUsedError;
  List<TypeEntity> get types => throw _privateConstructorUsedError;
  List<TagEntity> get tags => throw _privateConstructorUsedError;
  List<TypeMoveEntity> get typesMove => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddExcursionStateCopyWith<AddExcursionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddExcursionStateCopyWith<$Res> {
  factory $AddExcursionStateCopyWith(
          AddExcursionState value, $Res Function(AddExcursionState) then) =
      _$AddExcursionStateCopyWithImpl<$Res>;
  $Res call(
      {bool isError,
      bool isLoading,
      List<CityEntity> cities,
      List<TypeEntity> types,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove});
}

/// @nodoc
class _$AddExcursionStateCopyWithImpl<$Res>
    implements $AddExcursionStateCopyWith<$Res> {
  _$AddExcursionStateCopyWithImpl(this._value, this._then);

  final AddExcursionState _value;
  // ignore: unused_field
  final $Res Function(AddExcursionState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? cities = freezed,
    Object? types = freezed,
    Object? tags = freezed,
    Object? typesMove = freezed,
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
              as List<CityEntity>,
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<TypeEntity>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagEntity>,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
    ));
  }
}

/// @nodoc
abstract class _$AddExcursionStateCopyWith<$Res>
    implements $AddExcursionStateCopyWith<$Res> {
  factory _$AddExcursionStateCopyWith(
          _AddExcursionState value, $Res Function(_AddExcursionState) then) =
      __$AddExcursionStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isError,
      bool isLoading,
      List<CityEntity> cities,
      List<TypeEntity> types,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove});
}

/// @nodoc
class __$AddExcursionStateCopyWithImpl<$Res>
    extends _$AddExcursionStateCopyWithImpl<$Res>
    implements _$AddExcursionStateCopyWith<$Res> {
  __$AddExcursionStateCopyWithImpl(
      _AddExcursionState _value, $Res Function(_AddExcursionState) _then)
      : super(_value, (v) => _then(v as _AddExcursionState));

  @override
  _AddExcursionState get _value => super._value as _AddExcursionState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? isLoading = freezed,
    Object? cities = freezed,
    Object? types = freezed,
    Object? tags = freezed,
    Object? typesMove = freezed,
  }) {
    return _then(_AddExcursionState(
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
              as List<CityEntity>,
      types: types == freezed
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as List<TypeEntity>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagEntity>,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
    ));
  }
}

/// @nodoc

class _$_AddExcursionState implements _AddExcursionState {
  const _$_AddExcursionState(
      {this.isError = false,
      this.isLoading = false,
      this.cities = const [],
      this.types = const [],
      this.tags = const [],
      this.typesMove = const []});

  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final List<CityEntity> cities;
  @JsonKey()
  @override
  final List<TypeEntity> types;
  @JsonKey()
  @override
  final List<TagEntity> tags;
  @JsonKey()
  @override
  final List<TypeMoveEntity> typesMove;

  @override
  String toString() {
    return 'AddExcursionState(isError: $isError, isLoading: $isLoading, cities: $cities, types: $types, tags: $tags, typesMove: $typesMove)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddExcursionState &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.cities, cities) &&
            const DeepCollectionEquality().equals(other.types, types) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.typesMove, typesMove));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isError),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(cities),
      const DeepCollectionEquality().hash(types),
      const DeepCollectionEquality().hash(tags),
      const DeepCollectionEquality().hash(typesMove));

  @JsonKey(ignore: true)
  @override
  _$AddExcursionStateCopyWith<_AddExcursionState> get copyWith =>
      __$AddExcursionStateCopyWithImpl<_AddExcursionState>(this, _$identity);
}

abstract class _AddExcursionState implements AddExcursionState {
  const factory _AddExcursionState(
      {bool isError,
      bool isLoading,
      List<CityEntity> cities,
      List<TypeEntity> types,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove}) = _$_AddExcursionState;

  @override
  bool get isError;
  @override
  bool get isLoading;
  @override
  List<CityEntity> get cities;
  @override
  List<TypeEntity> get types;
  @override
  List<TagEntity> get tags;
  @override
  List<TypeMoveEntity> get typesMove;
  @override
  @JsonKey(ignore: true)
  _$AddExcursionStateCopyWith<_AddExcursionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$InsertExcursionStateTearOff {
  const _$InsertExcursionStateTearOff();

  _InsertExcursionState call(
      {bool isError = false,
      List<dynamic> errorName = const [false, 'errorName'],
      List<dynamic> errorCity = const [false, 'errorCity'],
      List<dynamic> errorGroupSize = const [false, 'errorGroupSize'],
      List<dynamic> errorDuration = const [false, 'errorDuration'],
      List<dynamic> errorMeetPoint = const [false, 'errorMeetPoint'],
      List<dynamic> errorStandardPrice = const [false, 'errorStandardPrice'],
      List<dynamic> errorTypesMove = const [false, 'errorTypesMove'],
      bool isLoading = false,
      CityEntity? city,
      TypeEntity? type,
      String name = '',
      String description = 'null',
      String photo = 'null',
      int groupSize = 0,
      String guide = '',
      bool moment = false,
      String duration = '',
      double rating = 0.0,
      String meetPoint = '',
      int standardPrice = 0,
      String addServices = 'null',
      String included = 'null',
      String organizationalDetails = 'null',
      List<TagEntity> tags = const [],
      List<TypeMoveEntity> typesMove = const []}) {
    return _InsertExcursionState(
      isError: isError,
      errorName: errorName,
      errorCity: errorCity,
      errorGroupSize: errorGroupSize,
      errorDuration: errorDuration,
      errorMeetPoint: errorMeetPoint,
      errorStandardPrice: errorStandardPrice,
      errorTypesMove: errorTypesMove,
      isLoading: isLoading,
      city: city,
      type: type,
      name: name,
      description: description,
      photo: photo,
      groupSize: groupSize,
      guide: guide,
      moment: moment,
      duration: duration,
      rating: rating,
      meetPoint: meetPoint,
      standardPrice: standardPrice,
      addServices: addServices,
      included: included,
      organizationalDetails: organizationalDetails,
      tags: tags,
      typesMove: typesMove,
    );
  }
}

/// @nodoc
const $InsertExcursionState = _$InsertExcursionStateTearOff();

/// @nodoc
mixin _$InsertExcursionState {
  bool get isError => throw _privateConstructorUsedError;
  List<dynamic> get errorName => throw _privateConstructorUsedError;
  List<dynamic> get errorCity => throw _privateConstructorUsedError;
  List<dynamic> get errorGroupSize => throw _privateConstructorUsedError;
  List<dynamic> get errorDuration => throw _privateConstructorUsedError;
  List<dynamic> get errorMeetPoint => throw _privateConstructorUsedError;
  List<dynamic> get errorStandardPrice => throw _privateConstructorUsedError;
  List<dynamic> get errorTypesMove => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  CityEntity? get city => throw _privateConstructorUsedError;
  TypeEntity? get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;
  int get groupSize => throw _privateConstructorUsedError;
  String get guide => throw _privateConstructorUsedError;
  bool get moment => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get meetPoint => throw _privateConstructorUsedError;
  int get standardPrice => throw _privateConstructorUsedError;
  String get addServices => throw _privateConstructorUsedError;
  String get included => throw _privateConstructorUsedError;
  String get organizationalDetails => throw _privateConstructorUsedError;
  List<TagEntity> get tags => throw _privateConstructorUsedError;
  List<TypeMoveEntity> get typesMove => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsertExcursionStateCopyWith<InsertExcursionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsertExcursionStateCopyWith<$Res> {
  factory $InsertExcursionStateCopyWith(InsertExcursionState value,
          $Res Function(InsertExcursionState) then) =
      _$InsertExcursionStateCopyWithImpl<$Res>;
  $Res call(
      {bool isError,
      List<dynamic> errorName,
      List<dynamic> errorCity,
      List<dynamic> errorGroupSize,
      List<dynamic> errorDuration,
      List<dynamic> errorMeetPoint,
      List<dynamic> errorStandardPrice,
      List<dynamic> errorTypesMove,
      bool isLoading,
      CityEntity? city,
      TypeEntity? type,
      String name,
      String description,
      String photo,
      int groupSize,
      String guide,
      bool moment,
      String duration,
      double rating,
      String meetPoint,
      int standardPrice,
      String addServices,
      String included,
      String organizationalDetails,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove});
}

/// @nodoc
class _$InsertExcursionStateCopyWithImpl<$Res>
    implements $InsertExcursionStateCopyWith<$Res> {
  _$InsertExcursionStateCopyWithImpl(this._value, this._then);

  final InsertExcursionState _value;
  // ignore: unused_field
  final $Res Function(InsertExcursionState) _then;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorName = freezed,
    Object? errorCity = freezed,
    Object? errorGroupSize = freezed,
    Object? errorDuration = freezed,
    Object? errorMeetPoint = freezed,
    Object? errorStandardPrice = freezed,
    Object? errorTypesMove = freezed,
    Object? isLoading = freezed,
    Object? city = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? photo = freezed,
    Object? groupSize = freezed,
    Object? guide = freezed,
    Object? moment = freezed,
    Object? duration = freezed,
    Object? rating = freezed,
    Object? meetPoint = freezed,
    Object? standardPrice = freezed,
    Object? addServices = freezed,
    Object? included = freezed,
    Object? organizationalDetails = freezed,
    Object? tags = freezed,
    Object? typesMove = freezed,
  }) {
    return _then(_value.copyWith(
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorName: errorName == freezed
          ? _value.errorName
          : errorName // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorCity: errorCity == freezed
          ? _value.errorCity
          : errorCity // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorGroupSize: errorGroupSize == freezed
          ? _value.errorGroupSize
          : errorGroupSize // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorDuration: errorDuration == freezed
          ? _value.errorDuration
          : errorDuration // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorMeetPoint: errorMeetPoint == freezed
          ? _value.errorMeetPoint
          : errorMeetPoint // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorStandardPrice: errorStandardPrice == freezed
          ? _value.errorStandardPrice
          : errorStandardPrice // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorTypesMove: errorTypesMove == freezed
          ? _value.errorTypesMove
          : errorTypesMove // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityEntity?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeEntity?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
      groupSize: groupSize == freezed
          ? _value.groupSize
          : groupSize // ignore: cast_nullable_to_non_nullable
              as int,
      guide: guide == freezed
          ? _value.guide
          : guide // ignore: cast_nullable_to_non_nullable
              as String,
      moment: moment == freezed
          ? _value.moment
          : moment // ignore: cast_nullable_to_non_nullable
              as bool,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      meetPoint: meetPoint == freezed
          ? _value.meetPoint
          : meetPoint // ignore: cast_nullable_to_non_nullable
              as String,
      standardPrice: standardPrice == freezed
          ? _value.standardPrice
          : standardPrice // ignore: cast_nullable_to_non_nullable
              as int,
      addServices: addServices == freezed
          ? _value.addServices
          : addServices // ignore: cast_nullable_to_non_nullable
              as String,
      included: included == freezed
          ? _value.included
          : included // ignore: cast_nullable_to_non_nullable
              as String,
      organizationalDetails: organizationalDetails == freezed
          ? _value.organizationalDetails
          : organizationalDetails // ignore: cast_nullable_to_non_nullable
              as String,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagEntity>,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
    ));
  }
}

/// @nodoc
abstract class _$InsertExcursionStateCopyWith<$Res>
    implements $InsertExcursionStateCopyWith<$Res> {
  factory _$InsertExcursionStateCopyWith(_InsertExcursionState value,
          $Res Function(_InsertExcursionState) then) =
      __$InsertExcursionStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isError,
      List<dynamic> errorName,
      List<dynamic> errorCity,
      List<dynamic> errorGroupSize,
      List<dynamic> errorDuration,
      List<dynamic> errorMeetPoint,
      List<dynamic> errorStandardPrice,
      List<dynamic> errorTypesMove,
      bool isLoading,
      CityEntity? city,
      TypeEntity? type,
      String name,
      String description,
      String photo,
      int groupSize,
      String guide,
      bool moment,
      String duration,
      double rating,
      String meetPoint,
      int standardPrice,
      String addServices,
      String included,
      String organizationalDetails,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove});
}

/// @nodoc
class __$InsertExcursionStateCopyWithImpl<$Res>
    extends _$InsertExcursionStateCopyWithImpl<$Res>
    implements _$InsertExcursionStateCopyWith<$Res> {
  __$InsertExcursionStateCopyWithImpl(
      _InsertExcursionState _value, $Res Function(_InsertExcursionState) _then)
      : super(_value, (v) => _then(v as _InsertExcursionState));

  @override
  _InsertExcursionState get _value => super._value as _InsertExcursionState;

  @override
  $Res call({
    Object? isError = freezed,
    Object? errorName = freezed,
    Object? errorCity = freezed,
    Object? errorGroupSize = freezed,
    Object? errorDuration = freezed,
    Object? errorMeetPoint = freezed,
    Object? errorStandardPrice = freezed,
    Object? errorTypesMove = freezed,
    Object? isLoading = freezed,
    Object? city = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? photo = freezed,
    Object? groupSize = freezed,
    Object? guide = freezed,
    Object? moment = freezed,
    Object? duration = freezed,
    Object? rating = freezed,
    Object? meetPoint = freezed,
    Object? standardPrice = freezed,
    Object? addServices = freezed,
    Object? included = freezed,
    Object? organizationalDetails = freezed,
    Object? tags = freezed,
    Object? typesMove = freezed,
  }) {
    return _then(_InsertExcursionState(
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorName: errorName == freezed
          ? _value.errorName
          : errorName // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorCity: errorCity == freezed
          ? _value.errorCity
          : errorCity // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorGroupSize: errorGroupSize == freezed
          ? _value.errorGroupSize
          : errorGroupSize // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorDuration: errorDuration == freezed
          ? _value.errorDuration
          : errorDuration // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorMeetPoint: errorMeetPoint == freezed
          ? _value.errorMeetPoint
          : errorMeetPoint // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorStandardPrice: errorStandardPrice == freezed
          ? _value.errorStandardPrice
          : errorStandardPrice // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      errorTypesMove: errorTypesMove == freezed
          ? _value.errorTypesMove
          : errorTypesMove // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityEntity?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeEntity?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
      groupSize: groupSize == freezed
          ? _value.groupSize
          : groupSize // ignore: cast_nullable_to_non_nullable
              as int,
      guide: guide == freezed
          ? _value.guide
          : guide // ignore: cast_nullable_to_non_nullable
              as String,
      moment: moment == freezed
          ? _value.moment
          : moment // ignore: cast_nullable_to_non_nullable
              as bool,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      meetPoint: meetPoint == freezed
          ? _value.meetPoint
          : meetPoint // ignore: cast_nullable_to_non_nullable
              as String,
      standardPrice: standardPrice == freezed
          ? _value.standardPrice
          : standardPrice // ignore: cast_nullable_to_non_nullable
              as int,
      addServices: addServices == freezed
          ? _value.addServices
          : addServices // ignore: cast_nullable_to_non_nullable
              as String,
      included: included == freezed
          ? _value.included
          : included // ignore: cast_nullable_to_non_nullable
              as String,
      organizationalDetails: organizationalDetails == freezed
          ? _value.organizationalDetails
          : organizationalDetails // ignore: cast_nullable_to_non_nullable
              as String,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagEntity>,
      typesMove: typesMove == freezed
          ? _value.typesMove
          : typesMove // ignore: cast_nullable_to_non_nullable
              as List<TypeMoveEntity>,
    ));
  }
}

/// @nodoc

class _$_InsertExcursionState implements _InsertExcursionState {
  const _$_InsertExcursionState(
      {this.isError = false,
      this.errorName = const [false, 'errorName'],
      this.errorCity = const [false, 'errorCity'],
      this.errorGroupSize = const [false, 'errorGroupSize'],
      this.errorDuration = const [false, 'errorDuration'],
      this.errorMeetPoint = const [false, 'errorMeetPoint'],
      this.errorStandardPrice = const [false, 'errorStandardPrice'],
      this.errorTypesMove = const [false, 'errorTypesMove'],
      this.isLoading = false,
      this.city,
      this.type,
      this.name = '',
      this.description = 'null',
      this.photo = 'null',
      this.groupSize = 0,
      this.guide = '',
      this.moment = false,
      this.duration = '',
      this.rating = 0.0,
      this.meetPoint = '',
      this.standardPrice = 0,
      this.addServices = 'null',
      this.included = 'null',
      this.organizationalDetails = 'null',
      this.tags = const [],
      this.typesMove = const []});

  @JsonKey()
  @override
  final bool isError;
  @JsonKey()
  @override
  final List<dynamic> errorName;
  @JsonKey()
  @override
  final List<dynamic> errorCity;
  @JsonKey()
  @override
  final List<dynamic> errorGroupSize;
  @JsonKey()
  @override
  final List<dynamic> errorDuration;
  @JsonKey()
  @override
  final List<dynamic> errorMeetPoint;
  @JsonKey()
  @override
  final List<dynamic> errorStandardPrice;
  @JsonKey()
  @override
  final List<dynamic> errorTypesMove;
  @JsonKey()
  @override
  final bool isLoading;
  @override
  final CityEntity? city;
  @override
  final TypeEntity? type;
  @JsonKey()
  @override
  final String name;
  @JsonKey()
  @override
  final String description;
  @JsonKey()
  @override
  final String photo;
  @JsonKey()
  @override
  final int groupSize;
  @JsonKey()
  @override
  final String guide;
  @JsonKey()
  @override
  final bool moment;
  @JsonKey()
  @override
  final String duration;
  @JsonKey()
  @override
  final double rating;
  @JsonKey()
  @override
  final String meetPoint;
  @JsonKey()
  @override
  final int standardPrice;
  @JsonKey()
  @override
  final String addServices;
  @JsonKey()
  @override
  final String included;
  @JsonKey()
  @override
  final String organizationalDetails;
  @JsonKey()
  @override
  final List<TagEntity> tags;
  @JsonKey()
  @override
  final List<TypeMoveEntity> typesMove;

  @override
  String toString() {
    return 'InsertExcursionState(isError: $isError, errorName: $errorName, errorCity: $errorCity, errorGroupSize: $errorGroupSize, errorDuration: $errorDuration, errorMeetPoint: $errorMeetPoint, errorStandardPrice: $errorStandardPrice, errorTypesMove: $errorTypesMove, isLoading: $isLoading, city: $city, type: $type, name: $name, description: $description, photo: $photo, groupSize: $groupSize, guide: $guide, moment: $moment, duration: $duration, rating: $rating, meetPoint: $meetPoint, standardPrice: $standardPrice, addServices: $addServices, included: $included, organizationalDetails: $organizationalDetails, tags: $tags, typesMove: $typesMove)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InsertExcursionState &&
            const DeepCollectionEquality().equals(other.isError, isError) &&
            const DeepCollectionEquality().equals(other.errorName, errorName) &&
            const DeepCollectionEquality().equals(other.errorCity, errorCity) &&
            const DeepCollectionEquality()
                .equals(other.errorGroupSize, errorGroupSize) &&
            const DeepCollectionEquality()
                .equals(other.errorDuration, errorDuration) &&
            const DeepCollectionEquality()
                .equals(other.errorMeetPoint, errorMeetPoint) &&
            const DeepCollectionEquality()
                .equals(other.errorStandardPrice, errorStandardPrice) &&
            const DeepCollectionEquality()
                .equals(other.errorTypesMove, errorTypesMove) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality().equals(other.groupSize, groupSize) &&
            const DeepCollectionEquality().equals(other.guide, guide) &&
            const DeepCollectionEquality().equals(other.moment, moment) &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality().equals(other.rating, rating) &&
            const DeepCollectionEquality().equals(other.meetPoint, meetPoint) &&
            const DeepCollectionEquality()
                .equals(other.standardPrice, standardPrice) &&
            const DeepCollectionEquality()
                .equals(other.addServices, addServices) &&
            const DeepCollectionEquality().equals(other.included, included) &&
            const DeepCollectionEquality()
                .equals(other.organizationalDetails, organizationalDetails) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.typesMove, typesMove));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(isError),
        const DeepCollectionEquality().hash(errorName),
        const DeepCollectionEquality().hash(errorCity),
        const DeepCollectionEquality().hash(errorGroupSize),
        const DeepCollectionEquality().hash(errorDuration),
        const DeepCollectionEquality().hash(errorMeetPoint),
        const DeepCollectionEquality().hash(errorStandardPrice),
        const DeepCollectionEquality().hash(errorTypesMove),
        const DeepCollectionEquality().hash(isLoading),
        const DeepCollectionEquality().hash(city),
        const DeepCollectionEquality().hash(type),
        const DeepCollectionEquality().hash(name),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(photo),
        const DeepCollectionEquality().hash(groupSize),
        const DeepCollectionEquality().hash(guide),
        const DeepCollectionEquality().hash(moment),
        const DeepCollectionEquality().hash(duration),
        const DeepCollectionEquality().hash(rating),
        const DeepCollectionEquality().hash(meetPoint),
        const DeepCollectionEquality().hash(standardPrice),
        const DeepCollectionEquality().hash(addServices),
        const DeepCollectionEquality().hash(included),
        const DeepCollectionEquality().hash(organizationalDetails),
        const DeepCollectionEquality().hash(tags),
        const DeepCollectionEquality().hash(typesMove)
      ]);

  @JsonKey(ignore: true)
  @override
  _$InsertExcursionStateCopyWith<_InsertExcursionState> get copyWith =>
      __$InsertExcursionStateCopyWithImpl<_InsertExcursionState>(
          this, _$identity);
}

abstract class _InsertExcursionState implements InsertExcursionState {
  const factory _InsertExcursionState(
      {bool isError,
      List<dynamic> errorName,
      List<dynamic> errorCity,
      List<dynamic> errorGroupSize,
      List<dynamic> errorDuration,
      List<dynamic> errorMeetPoint,
      List<dynamic> errorStandardPrice,
      List<dynamic> errorTypesMove,
      bool isLoading,
      CityEntity? city,
      TypeEntity? type,
      String name,
      String description,
      String photo,
      int groupSize,
      String guide,
      bool moment,
      String duration,
      double rating,
      String meetPoint,
      int standardPrice,
      String addServices,
      String included,
      String organizationalDetails,
      List<TagEntity> tags,
      List<TypeMoveEntity> typesMove}) = _$_InsertExcursionState;

  @override
  bool get isError;
  @override
  List<dynamic> get errorName;
  @override
  List<dynamic> get errorCity;
  @override
  List<dynamic> get errorGroupSize;
  @override
  List<dynamic> get errorDuration;
  @override
  List<dynamic> get errorMeetPoint;
  @override
  List<dynamic> get errorStandardPrice;
  @override
  List<dynamic> get errorTypesMove;
  @override
  bool get isLoading;
  @override
  CityEntity? get city;
  @override
  TypeEntity? get type;
  @override
  String get name;
  @override
  String get description;
  @override
  String get photo;
  @override
  int get groupSize;
  @override
  String get guide;
  @override
  bool get moment;
  @override
  String get duration;
  @override
  double get rating;
  @override
  String get meetPoint;
  @override
  int get standardPrice;
  @override
  String get addServices;
  @override
  String get included;
  @override
  String get organizationalDetails;
  @override
  List<TagEntity> get tags;
  @override
  List<TypeMoveEntity> get typesMove;
  @override
  @JsonKey(ignore: true)
  _$InsertExcursionStateCopyWith<_InsertExcursionState> get copyWith =>
      throw _privateConstructorUsedError;
}
