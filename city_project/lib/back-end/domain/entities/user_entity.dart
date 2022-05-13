import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String photo;
  final bool verified;
  final bool guidePermit;
  final String idDocument;
  final int countCompleted;
  final int countTravel;

  const UserEntity({
    required this.id,
    required this.countCompleted,
    required this.countTravel,
    required this.guidePermit,
    required this.name,
    required this.photo,
    required this.verified,
    required this.idDocument,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        photo,
        verified,
        countCompleted,
        countTravel,
      ];
}
