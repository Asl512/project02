import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';

abstract class ExcursionRepository {
  Future<List<ExcursionEntity>?> getAllExcursion();
  Future<List<ExcursionEntity>?> getActiveExcursionByGuide(String id);
  Future<List<ExcursionEntity>?> getModerateExcursionByGuide(String id);
  Future<List<ExcursionEntity>?> getExcursionByType(String type);
}
