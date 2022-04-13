import 'package:equatable/equatable.dart';

class ExcursionEntity extends Equatable {
  final String id;
  final String name;
  final String photo;
  final String description;
  final int groupSize;
  final String guide;
  final String type;
  final bool moment;
  final List<dynamic> moveType;
  final List<dynamic> rating;
  final String meetPoint;
  final int standardPrice;

  const ExcursionEntity(
      {required this.id,
      required this.name,
      required this.photo,
      required this.description,
      required this.groupSize,
      required this.guide,
      required this.type,
      required this.moment,
      required this.moveType,
      required this.meetPoint,
      required this.standardPrice,
      required this.rating});

  @override
  List<Object?> get props => [
        name,
        rating,
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
