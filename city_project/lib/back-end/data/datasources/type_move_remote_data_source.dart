import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/type_move_model.dart';

abstract class TypeMoveRemoteDataSource {
  Future<List<TypeMoveModel>?> getAllTypeMove();

  Future<List<TypeMoveModel>?> getListTypeMove(List<String> indexes);
}

class TypeMoveRemoteDataSourceImpl implements TypeMoveRemoteDataSource {
  @override
  Future<List<TypeMoveModel>?> getAllTypeMove() async {
    List response = [];
    await FirebaseFirestore.instance.collection('typeMove').get().then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((typeMove) => TypeMoveModel.fromDocument(typeMove)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<TypeMoveModel>?> getListTypeMove(List<String> indexes) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('typeMove')
        .where('id', whereIn: indexes)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((typeMove) => TypeMoveModel.fromDocument(typeMove)).toList();
    } catch (e) {
      return null;
    }
  }
}
