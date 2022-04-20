import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';

class ReviewsModel extends ReviewsEntity {
  const ReviewsModel({
    required id,
    required review,
    required user,
    required date,
  }) : super(
          id: id,
          review: review,
          user: user,
          date: date,
        );

  factory ReviewsModel.fromDocument(DocumentSnapshot snapshot) {
    String month = '';
    if (snapshot["date"].toDate().month.toString().length == 1) {
      month = '0' + snapshot["date"].toDate().month.toString();
    } else {
      month = snapshot["date"].toDate().month.toString();
    }
    return ReviewsModel(
      id: snapshot.id,
      review: snapshot["review"],
      user: snapshot["idUser"],
      date: snapshot["date"].toDate().day.toString() +
          '.' +
          month +
          '.' +
          snapshot["date"].toDate().year.toString(),
    );
  }
}
