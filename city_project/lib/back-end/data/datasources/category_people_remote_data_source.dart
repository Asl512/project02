import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/category_people_model.dart';
import 'package:lan_code/back-end/data/models/tag_model.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';

abstract class CategoryPeopleRemoteDataSource {
  Future<List<CategoryPeopleModel>?> getAllCategoryPeople();

  Future<List<CategoryPeopleModel>?> getListCategoryPeople(List<String> indexes);
}

class CategoryPeopleRemoteDataSourceImpl implements CategoryPeopleRemoteDataSource {
  @override
  Future<List<CategoryPeopleModel>?> getAllCategoryPeople() async {
    List response = [];
    await FirebaseFirestore.instance.collection('categoriesPeople').get().then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response
          .map((categoryPeople) => CategoryPeopleModel.fromDocument(categoryPeople))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CategoryPeopleModel>?> getListCategoryPeople(List<String> indexes) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('categoriesPeople')
        .where('id', whereIn: indexes)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response
          .map((categoryPeople) => CategoryPeopleModel.fromDocument(categoryPeople))
          .toList();
    } catch (e) {
      return null;
    }
  }
}
