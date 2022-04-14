import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/photos_excursion_model.dart';

abstract class PhotosExcursionRemoteDataSource {
  Future<PhotosExcursionModel?> getPhotosExcursion({required String idExcursion});
}

class PhotosExcursionRemoteDataSourceImpl implements PhotosExcursionRemoteDataSource {
  @override
  Future<PhotosExcursionModel?> getPhotosExcursion({required String idExcursion}) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('photoExcursion')
        .where('idExcursion', isEqualTo: idExcursion)
        .limit(1)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return PhotosExcursionModel.fromDocument(response.first);
    } catch (e) {
      return null;
    }
  }
}
