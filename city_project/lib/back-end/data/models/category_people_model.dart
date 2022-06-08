import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';

class CategoryPeopleModel extends CategoryPeopleEntity {
  const CategoryPeopleModel({
    required id,
    required name,
    required price,
  }) : super(
          id: id,
          name: name,
          price: price,
        );

  factory CategoryPeopleModel.fromDocument(DocumentSnapshot snapshot, int price) {
    return CategoryPeopleModel(
      id: snapshot["id"],
      name: snapshot["name"],
      price: price,
    );
  }
}
