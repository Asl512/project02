import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';

class TicketModel extends TicketEntity {
  const TicketModel({
    required id,
    required date,
    required idExcursion,
    required idUser,
    required phoneUser,
    required specialTickets,
    required standardTickets,
    required userDate,
    required userMeetPoint,
  }) : super(
          id: id,
          date: date,
          idExcursion: idExcursion,
          idUser: idUser,
          phoneUser: phoneUser,
          specialTickets: specialTickets,
          standardTickets: standardTickets,
          userDate: userDate,
          userMeetPoint: userMeetPoint,
        );

  factory TicketModel.fromDocument(DocumentSnapshot snapshot) {
    return TicketModel(
      id: snapshot.id,
      date: DateTime.fromMillisecondsSinceEpoch(snapshot["date"].seconds * 1000),
      idExcursion: snapshot["idExcursion"],
      idUser: snapshot["idUser"],
      phoneUser: snapshot["phoneUser"],
      specialTickets: snapshot["specialTickets"],
      standardTickets: snapshot["standardTickets"],
      userDate: DateTime.fromMillisecondsSinceEpoch(snapshot["userDate"].seconds * 1000),
      userMeetPoint: snapshot["userMeetPoint"],
    );
  }
}
