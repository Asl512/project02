import 'package:equatable/equatable.dart';

class DateExcursion {
  final DateTime date;
  final int places;

  DateExcursion({
    required this.date,
    required this.places,
  });

  String get getDate =>
      [date.day.toString(), date.month.toString(), date.year.toString()].join('.');

  String get getTime => [date.hour.toString(), date.minute.toString()].join(':');
}

class ExcursionEntity extends Equatable {
  final String id;
  final String name;
  final String photo;
  final String description;
  final int groupSize;
  final String guide;
  final String type;
  final bool moment;
  final String duration;
  final List<dynamic> photos;
  final List<dynamic> moveType;
  final List<dynamic> rating;
  final List<dynamic> tags;
  final List<dynamic> specialPrice;
  final List<DateExcursion> dates;
  final String meetPoint;
  final int standardPrice;
  final String addServices;
  final String included;
  final String currency;
  final String organizationalDetails;

  const ExcursionEntity({
    required this.specialPrice,
    required this.id,
    required this.organizationalDetails,
    required this.addServices,
    required this.dates,
    required this.tags,
    required this.photos,
    required this.included,
    required this.currency,
    required this.name,
    required this.photo,
    required this.description,
    required this.groupSize,
    required this.duration,
    required this.guide,
    required this.type,
    required this.moment,
    required this.moveType,
    required this.meetPoint,
    required this.standardPrice,
    required this.rating,
  });

  @override
  List<Object?> get props => [
        name,
        rating,
        addServices,
        tags,
        included,
        photos,
        dates,
        specialPrice,
        organizationalDetails,
        duration,
        currency,
        photo,
        description,
        groupSize,
        type,
        guide,
        moment,
        moveType,
        meetPoint,
        standardPrice
      ];
}
