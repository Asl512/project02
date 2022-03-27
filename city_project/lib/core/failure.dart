import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String error;

  ServerFailure({required this.error});
}