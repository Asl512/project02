import 'package:lan_code/back-end/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<List<CityEntity>?> getAllCity();

  Future<CityEntity?> getCity();
}
