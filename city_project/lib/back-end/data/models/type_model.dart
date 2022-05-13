import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';

class TypeModel extends TypeEntity {
  const TypeModel({required id, required name, required description})
      : super(id: id, name: name, description: description);

  factory TypeModel.fromDocument(DocumentSnapshot snapshot) {
    return TypeModel(
      id: snapshot["id"],
      name: snapshot["name"],
      description: snapshot["description"],
    );
  }
}
