import 'package:equatable/equatable.dart';

class TicketEntity extends Equatable {
  final String id;
  final DateTime date;
  final DateTime userDate;
  final String userMeetPoint;
  final String idExcursion;
  final String idUser;
  final String phoneUser;
  final List<dynamic> specialTickets;
  final int standardTickets;

  const TicketEntity({
    required this.id,
    required this.date,
    required this.idExcursion,
    required this.idUser,
    required this.phoneUser,
    required this.specialTickets,
    required this.standardTickets,
    required this.userDate,
    required this.userMeetPoint,
  });

  int get getTickets{
    int tickets = standardTickets;
    for(int i = 0; i < specialTickets.length; i++){
      tickets += specialTickets[i]['tickets'] as int;
    }
    return tickets;
  }
  String get getDate => '12.12.2222';
  String get getTime => '15:00';

  @override
  List<Object?> get props => [
        id,
        date,
        userDate,
        userMeetPoint,
        idUser,
        idExcursion,
        phoneUser,
        standardTickets,
        standardTickets,
      ];
}
