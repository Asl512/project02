import 'package:lan_code/back-end/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUser(String id);

  Future<List<UserEntity>?> getListUsers(List<String> listId);
}
