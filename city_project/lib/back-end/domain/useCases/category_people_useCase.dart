import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/repositories/category_people_repositorie.dart';

class GetAllCategoryPeople {
  final CategoryPeopleRepository _categoryPeopleRepository;

  GetAllCategoryPeople(this._categoryPeopleRepository);

  Future<List<CategoryPeopleEntity>?> call() async {
    return await _categoryPeopleRepository.getAllCategoryPeople();
  }
}

class GetListCategoryPeople {
  final CategoryPeopleRepository _categoryPeopleRepository;

  GetListCategoryPeople(this._categoryPeopleRepository);

  Future<List<CategoryPeopleEntity>?> call({
    required List<String> indexes,
    required List<int> prices,
  }) async {
    return await _categoryPeopleRepository.getListCategoryPeople(indexes: indexes, prices: prices);
  }
}
