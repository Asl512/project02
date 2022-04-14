import 'package:equatable/equatable.dart';

class CategoryPeopleEntity extends Equatable {
  final String id;
  final String name;

  const CategoryPeopleEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
