import 'package:equatable/equatable.dart';

class ReviewsEntity extends Equatable {
  final String id;
  final List reviews;
  final List users;

  const ReviewsEntity({
    required this.id,
    required this.reviews,
    required this.users,
  });

  @override
  List<Object?> get props => [id, users,reviews];
}
