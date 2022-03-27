import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

  const UserModel({
    required id,
    required name,
    required guidePermit,
    required photo,
    required verified,
  }):
        super(
        id: id,
        name: name,
        guidePermit:guidePermit,
        photo: photo,
        verified:verified
      );

  factory UserModel.fromDocument(DocumentSnapshot snapshot){
    return UserModel(
        id: snapshot.id,
        name: snapshot["name"],
        guidePermit:snapshot["guidePermit"],
        photo: snapshot["photo"],
        verified:snapshot["verified"]
    );
  }
}