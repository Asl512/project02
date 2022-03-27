import 'package:equatable/equatable.dart';

class ExcursionEntiti extends Equatable{
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
  final dynamic duration;
  final int price;

  const ExcursionEntiti({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.groupSize,
    required this.guide,
    required this.type,
    required this.moment,
    required this.moveType,
    required this.meetPoint,
    required this.duration,
    required this.price,
    required this.rating
  });

  @override
  List<Object?> get props => [name,rating, photo, description, groupSize,type, guide, moment, moveType, meetPoint, duration, price];
}
