import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/user_model.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<UserEntity?> getUser(String id);

  Future<List<UserEntity>?> getListUsers(List<String> listId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserEntity?> getUser(String id) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: id)
        .limit(1)
        .get()
        .then((snapshot) => {response = snapshot.docs});

    try {
      return UserModel.fromDocument(response.first);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<UserEntity>?> getListUsers(List<String> listId) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('user')
        .where('id', whereIn: listId)
        .get()
        .then((snapshot) => {response = snapshot.docs});

    try {
      return response.map((user) => UserModel.fromDocument(user)).toList();
    } catch (e) {
      return null;
    }
  }
}
