import 'package:lan_code/back-end/data/datasources/type_move_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/repositories/type_move_repositorie.dart';

class TypeMoveDataRepository extends TypeMoveRepository {
  @override
  Future<List<TypeMoveEntity>?> getAllTypeMove() async {
    return await _getListTypeMove(() {
      return TypeMoveRemoteDataSourceImpl().getAllTypeMove();
    });
  }

  @override
  Future<List<TypeMoveEntity>?> getListTypeMove({required List<String> indexes}) async {
    return await _getListTypeMove(() {
      return TypeMoveRemoteDataSourceImpl().getListTypeMove(indexes);
    });
  }

  Future<List<TypeMoveEntity>?> _getListTypeMove(
    Future<List<TypeMoveEntity>?> Function() getTypeMove,
  ) async {
    final remoteTypeMove = await getTypeMove();
    return remoteTypeMove;
  }
}
