import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';

class ExcursionModel extends ExcursionEntity {
  const ExcursionModel({
    required id,
    required name,
    required photo,
    required description,
    required groupSize,
    required guide,
    required moment,
    required specialPrice,
    required moveType,
    required meetPoint,
    required currency,
    required standardPrice,
    required organizationalDetails,
    required dates,
    required addServices,
    required included,
    required tags,
    required duration,
    required rating,
    required type,
    required photos,
    required isCheck,
  }) : super(
          id: id,
          duration: duration,
          photos: photos,
          isCheck: isCheck,
          dates: dates,
          specialPrice: specialPrice,
          organizationalDetails: organizationalDetails,
          addServices: addServices,
          included: included,
          name: name,
          tags: tags,
          currency: currency,
          photo: photo,
          description: description,
          groupSize: groupSize,
          rating: rating,
          guide: guide,
          moment: moment,
          moveType: moveType,
          meetPoint: meetPoint,
          standardPrice: standardPrice,
          type: type,
        );

  factory ExcursionModel.fromDocument(DocumentSnapshot snapshot) {
    List<DateExcursion> dates = [];
    try {
      for (int i = 0; i < snapshot["dates"].length; i++) {
        dates.add(DateExcursion(
          date: DateTime.fromMillisecondsSinceEpoch(snapshot["dates"][i]["date"].seconds * 1000),
          places: snapshot["dates"][i]['places'],
        ));
      }
    } catch (e) {
      print(e);
    }

    return ExcursionModel(
      id: snapshot.id,
      dates: dates,
      name: snapshot["name"],
      isCheck: snapshot["isCheck"],
      photo: snapshot["photo"],
      photos: snapshot["photos"],
      specialPrice: snapshot["specialPrice"],
      organizationalDetails: snapshot["organizationalDetails"],
      addServices: snapshot["addServices"],
      included: snapshot["included"],
      tags: snapshot["tags"],
      duration: snapshot["duration"],
      description: snapshot["description"],
      guide: snapshot["idGuide"],
      currency: snapshot["currency"],
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
