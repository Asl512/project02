import 'package:lan_code/back-end/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<List<CityEntiti>?> getAllCity();

  Future<CityEntiti?> getCity();
}
