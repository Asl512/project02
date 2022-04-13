import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  const CityModel({required id, required name, required photo})
      : super(
          id: id,
          name: name,
          photo: photo,
        );

  factory CityModel.fromDocument(DocumentSnapshot snapshot) {
    return CityModel(
      id: snapshot.id,
      name: snapshot["name"],
      photo: snapshot["photo"],
    );
  }
}
