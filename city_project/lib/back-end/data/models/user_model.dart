import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required id,
    required name,
    required guidePermit,
    required photo,
    required verified,
    required countTravel,
    required countCompleted,
    required idDocument,
  }) : super(
          id: id,
          countCompleted: countCompleted,
          countTravel: countTravel,
          name: name,
          guidePermit: guidePermit,
          photo: photo,
          verified: verified,
          idDocument: idDocument,
        );

  factory UserModel.fromDocument(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot["id"],
      countTravel: snapshot["countTravel"],
      countCompleted: snapshot["countCompleted"],
      name: snapshot["name"],
      guidePermit: snapshot["guidePermit"],
      photo: snapshot["photo"],
      verified: snapshot["verified"],
      idDocument: snapshot.id,
    );
  }
}
