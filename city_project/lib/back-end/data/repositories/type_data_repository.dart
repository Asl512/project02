import 'package:lan_code/back-end/data/datasources/type_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/repositories/type_repositorie.dart';

class TypeDataRepository extends TypeRepository {
  @override
  Future<List<TypeEntity>?> getAllType() async {
    return await _getListType(() {
      return TypeRemoteDataSourceImpl().getAllType();
    });
  }

  @override
  Future<List<TypeEntity>?> getListType(List<String> listId) async {
    return await _getListType(() {
      return TypeRemoteDataSourceImpl().getListType(listId);
    });
  }

  Future<List<TypeEntity>?> _getListType(
      Future<List<TypeEntity>?> Function() getAllType) async {
    final remoteTypes = await getAllType();
    return remoteTypes;
  }

  @override
  Future<TypeEntity?> getType(String id) async {

    final remoteTypes = await TypeRemoteDataSourceImpl().getType(id);
    return remoteTypes;
  }

}
