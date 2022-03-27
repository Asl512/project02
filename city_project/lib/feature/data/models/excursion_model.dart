import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/core/exception.dart';
import 'package:lan_code/feature/data/datasources/user_remote_data_source.dart';
import 'package:lan_code/feature/data/models/type_model.dart';
import 'package:lan_code/feature/data/models/user_model.dart';
import 'package:lan_code/feature/data/repositories/user_data_repository.dart';
import 'package:lan_code/feature/domain/entities/excursion_entity.dart';
import '../../domain/entities/city_entity.dart';

class ExcursionModel extends ExcursionEntiti{

  const ExcursionModel({
    required id,
    required name,
    required photo,
    required description,
    required groupSize,
    required guide,
    required moment,
    required moveType,
    required meetPoint,
    required duration,
    required price,
    required rating,
    required type,
  }):
        super(
        id:id,
        name:name,
        photo:photo,
        description:description,
        groupSize:groupSize,
        rating:rating,
        guide:guide,
        moment:moment,
        moveType:moveType,
        meetPoint:meetPoint,
        duration:duration,
        price:price,
        type: type
      );

  factory ExcursionModel.fromDocument(DocumentSnapshot snapshot){
    return ExcursionModel(
      id: snapshot.id,
      name: snapshot["name"],
      photo: snapshot["photo"],
      description:snapshot["description"],
      guide: snapshot["idGid"],
      type: snapshot["type"],
      moment:snapshot["moment"],
      moveType:snapshot["moveType"],
      meetPoint:snapshot["meetPoint"],
      rating:snapshot["rating"],
      groupSize:snapshot["groupSize"],
      duration:snapshot["time"],
      price:snapshot["price"],
    );
  }
}