import 'package:lan_code/back-end/domain/entities/type_entity.dart';

abstract class TypeRepository {
  Future<TypeEntity?> getType(String id);

  Future<List<TypeEntity>?> getAllType();

  Future<List<TypeEntity>?> getListType(List<String> listId);
}
