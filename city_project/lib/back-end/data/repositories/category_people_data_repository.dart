import 'package:lan_code/back-end/data/datasources/category_people_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/repositories/category_people_repositorie.dart';

class CategoryPeopleDataRepository extends CategoryPeopleRepository {
  @override
  Future<List<CategoryPeopleEntity>?> getAllCategoryPeople() async {
    return await _getListCategoryPeople(() {
      return CategoryPeopleRemoteDataSourceImpl().getAllCategoryPeople();
    });
  }

  @override
  Future<List<CategoryPeopleEntity>?> getListCategoryPeople({required List<String> indexes}) async {
    return await _getListCategoryPeople(() {
      return CategoryPeopleRemoteDataSourceImpl().getListCategoryPeople(indexes);
    });
  }

  Future<List<CategoryPeopleEntity>?> _getListCategoryPeople(
      Future<List<CategoryPeopleEntity>?> Function() getCategoryPeople) async {
    final remoteCategoryPeople = await getCategoryPeople();
    return remoteCategoryPeople;
  }
}
