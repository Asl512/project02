import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';

class ReviewsModel extends ReviewsEntity {
  const ReviewsModel({
    required id,
    required reviews,
    required users,
  }) : super(
          id: id,
          reviews: reviews,
          users: users,
        );

  factory ReviewsModel.fromDocument(DocumentSnapshot snapshot) {
    return ReviewsModel(
      id: snapshot.id,
      reviews: snapshot["reviews"].map((review)=>review['review']).toList(),
      users: snapshot["reviews"].map((review)=>review['user']).toList(),
    );
  }
}
