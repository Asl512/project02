import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/photos_excursion_entity.dart';

class PhotosExcursionModel extends PhotosExcursionEntity {
  const PhotosExcursionModel({
    required idExcursion,
    required photos,
  }) : super(idExcursion: idExcursion, photos: photos);

  factory PhotosExcursionModel.fromDocument(DocumentSnapshot snapshot) {
    return PhotosExcursionModel(
      idExcursion: snapshot["idExcursion"],
      photos: snapshot["photo"],
    );
  }
}
