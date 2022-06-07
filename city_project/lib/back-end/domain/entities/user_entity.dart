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
  final String phone;

  const UserEntity({
    required this.id,
    required this.countCompleted,
    required this.countTravel,
    required this.guidePermit,
    required this.name,
    required this.photo,
    required this.verified,
    required this.idDocument,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        photo,
        verified,
        countCompleted,
        countTravel,
      ];
}
