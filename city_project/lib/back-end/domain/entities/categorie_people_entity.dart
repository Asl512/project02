import 'package:equatable/equatable.dart';

class CategoryPeopleEntity extends Equatable {
  final String id;
  final String name;
  final int price;

  const CategoryPeopleEntity({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
      ];
}
