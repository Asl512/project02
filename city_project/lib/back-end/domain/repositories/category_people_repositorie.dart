import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';

abstract class CategoryPeopleRepository {
  Future<List<CategoryPeopleEntity>?> getAllCategoryPeople();

  Future<List<CategoryPeopleEntity>?> getListCategoryPeople({required List<String> indexes});
}
