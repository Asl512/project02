import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/review_model.dart';
import 'package:lan_code/back-end/data/models/tag_model.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';

abstract class ReviewsRemoteDataSource {
  Future<ReviewsModel?> getReviews(String idExcursion);
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  @override
  Future<ReviewsModel?> getReviews(String idExcursion) async {
    late DocumentSnapshot response;
    await FirebaseFirestore.instance
        .collection('review')
        .where('idExcursion', isEqualTo: idExcursion)
        .limit(1)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs.first},
        );

    try {
      return ReviewsModel.fromDocument(response);
    } catch (e) {
      return null;
    }
  }
}
