import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String id;
  final String name;
  final String photo;
  final bool verified;
  final bool guidePermit;

  const UserEntity({
    required this.id,
    required this.guidePermit,
    required this.name,
    required this.photo,
    required this.verified,
  });

  @override
  List<Object?> get props => [id, name, photo,verified];
}
