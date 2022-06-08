import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/category_people_model.dart';

abstract class CategoryPeopleRemoteDataSource {
  Future<List<CategoryPeopleModel>?> getAllCategoryPeople();

  Future<List<CategoryPeopleModel>?> getListCategoryPeople(
    List<String> indexes,
    List<int> prices,
  );
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
          .map((categoryPeople) => CategoryPeopleModel.fromDocument(categoryPeople, 0))
          .toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CategoryPeopleModel>?> getListCategoryPeople(
    List<String> indexes,
    List<int> prices,
  ) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('categoriesPeople')
        .where('id', whereIn: indexes)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      List<CategoryPeopleModel> categories = [];
      for (int i = 0; i < response.length; i++) {
        categories.add(CategoryPeopleModel.fromDocument(response[i], prices[i]));
      }
      return categories;
    } catch (e) {
      return null;
    }
  }
}
