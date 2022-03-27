import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/core/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/city_model.dart';

abstract class CityRemoteDataSource{
  Future<List<CityModel>> getAllCity();
  Future<CityModel> getCityCash();
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource{

  @override
  Future<List<CityModel>> getAllCity()async{
    List response = [];
    await FirebaseFirestore.instance.collection('city').get().then((snapshot) => {
      response = snapshot.docs
    });
    try{
      if(response.first["name"] != null){
        return response.map((city) => CityModel.fromDocument(city)).toList();
      }else{
        throw ServerException();
      }
    }catch(e){
      throw ServerException();
    }
  }

  @override
  Future<CityModel> getCityCash()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ///поработать какой id при первом запуске брать
    String idCity = prefs.getString('city') ?? 'EZbunvBvO0EJEVg29Qt9';
    DocumentSnapshot response;
    try{
      response = await FirebaseFirestore.instance.collection('city').doc(idCity).get();
      if(response["name"] != null){
        return CityModel.fromDocument(response);
      }else{
        throw ServerException();
      }
    }catch(e){
      throw ServerException();
    }
  }

}