import 'package:lan_code/back-end/domain/entities/review_entity.dart';
import 'package:lan_code/back-end/domain/repositories/review_repositorie.dart';

class GetReviews {
  final ReviewRepository _reviewRepository;

  GetReviews(this._reviewRepository);

  Future<List<ReviewsEntity>?> call({required String idExcursion}) async {
    return await _reviewRepository.getReview(idExcursion: idExcursion);
  }
}
