import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';

abstract class ExcursionRepository {
  Future<List<ExcursionEntiti>?> getAllExcursion();

  Future<List<ExcursionEntiti>?> getExcursionByType(String type);
}
