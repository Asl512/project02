import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';

class TagModel extends TagEntity {
  const TagModel({
    required id,
    required name,
  }) : super(id: id, name: name);

  factory TagModel.fromDocument(DocumentSnapshot snapshot) {
    return TagModel(
      id: snapshot["id"],
      name: snapshot["name"],
    );
  }
}
