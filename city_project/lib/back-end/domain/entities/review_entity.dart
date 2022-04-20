import 'package:equatable/equatable.dart';

class ReviewsEntity extends Equatable {
  final String id;
  final String review;
  final String user;
  final String date;

  const ReviewsEntity({
    required this.id,
    required this.review,
    required this.user,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        review,
        date,
      ];
}
