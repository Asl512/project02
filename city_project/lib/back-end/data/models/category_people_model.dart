import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';

class CategoryPeopleModel extends CategoryPeopleEntity {
  const CategoryPeopleModel({
    required id,
    required name,
  }) : super(id: id, name: name);

  factory CategoryPeopleModel.fromDocument(DocumentSnapshot snapshot) {
    return CategoryPeopleModel(
      id: snapshot["id"],
      name: snapshot["name"],
    );
  }
}
