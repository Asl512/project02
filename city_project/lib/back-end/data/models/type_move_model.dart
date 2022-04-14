import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';

class TypeMoveModel extends TypeMoveEntity {
  const TypeMoveModel({
    required id,
    required name,
  }) : super(id: id, name: name);

  factory TypeMoveModel.fromDocument(DocumentSnapshot snapshot) {
    return TypeMoveModel(
      id: snapshot["id"],
      name: snapshot["name"],
    );
  }
}
