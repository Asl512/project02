import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/core/exception.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';

class ExcursionModel extends ExcursionEntiti {
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
    required standardPrice,
    required rating,
    required type,
  }) : super(
            id: id,
            name: name,
            photo: photo,
            description: description,
            groupSize: groupSize,
            rating: rating,
            guide: guide,
            moment: moment,
            moveType: moveType,
            meetPoint: meetPoint,
            standardPrice: standardPrice,
            type: type);

  factory ExcursionModel.fromDocument(DocumentSnapshot snapshot) {
    return ExcursionModel(
      id: snapshot.id,
      name: snapshot["name"],
      photo: snapshot["photo"],
      description: snapshot["description"],
      guide: snapshot["idGuide"],
      type: snapshot["type"],
      moment: snapshot["moment"],
      moveType: snapshot["moveType"],
      meetPoint: snapshot["meetPoint"],
      rating: snapshot["rating"],
      groupSize: snapshot["groupSize"],
      standardPrice: snapshot["standartPrice"],
    );
  }
}
