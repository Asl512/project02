import 'package:lan_code/back-end/data/datasources/reviews_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';
import 'package:lan_code/back-end/domain/repositories/review_repositorie.dart';

class ReviewDataRepository extends ReviewRepository {

  @override
  Future<ReviewsEntity?> getReview({required String idExcursion}) async {
    final remote = await ReviewsRemoteDataSourceImpl().getReviews(idExcursion);
    return remote;
  }
}
