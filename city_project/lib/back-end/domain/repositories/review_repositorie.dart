import 'package:lan_code/back-end/domain/entities/review_entity.dart';

abstract class ReviewRepository {
  Future<List<ReviewsEntity>?> getReview({required String idExcursion});
}
