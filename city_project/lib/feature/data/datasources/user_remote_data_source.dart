import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/core/exception.dart';
import 'package:lan_code/feature/data/models/user_model.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource{
  Future<UserEntity> getUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{

  @override
  Future<UserEntity> getUser(String id)async{
    List response = [];
    await FirebaseFirestore.instance.collection('user').where('id',isEqualTo:id).limit(1).get().then((snapshot) => {
      response = snapshot.docs
    });
    try{
      if(response.first["name"] != null){
        return UserModel.fromDocument(response.first);
      }else{
        throw ServerException();
      }
    }catch(e){
      throw ServerException();
    }
  }

}