import 'package:lan_code/back-end/data/datasources/user_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/repositories/user_repositorie.dart';

class UserDataRepository extends UserRepository {
  @override
  Future<UserEntity?> getUser(String id) async {
    return await _getUser(() {
      return UserRemoteDataSourceImpl().getUser(id);
    });
  }

  Future<UserEntity?> _getUser(Future<UserEntity?> Function() getUser) async {
    final remoteUser = await getUser();
    return remoteUser;
  }

  @override
  Future<List<UserEntity>?> getListUsers(List<String> listId) async {
    return await _getListUsers(() {
      return UserRemoteDataSourceImpl().getListUsers(listId);
    });
  }

  Future<List<UserEntity>?> _getListUsers(
      Future<List<UserEntity>?> Function() getListUsers) async {
    final remoteUser = await getListUsers();
    return remoteUser;
  }
}
