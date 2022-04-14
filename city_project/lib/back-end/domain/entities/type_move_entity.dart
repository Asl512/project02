import 'package:equatable/equatable.dart';

class TypeMoveEntity extends Equatable {
  final String id;
  final String name;

  const TypeMoveEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
