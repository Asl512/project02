import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/review_model.dart';

abstract class ReviewsRemoteDataSource {
  Future<List<ReviewsModel>?> getReviews(String idExcursion);
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  @override
  Future<List<ReviewsModel>?> getReviews(String idExcursion) async {
    late List response;
    await FirebaseFirestore.instance
        .collection('reviews')
        .where('idExcursion', isEqualTo: idExcursion)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((review) => ReviewsModel.fromDocument(review)).toList();
    } catch (e) {
      return null;
    }
  }
}
