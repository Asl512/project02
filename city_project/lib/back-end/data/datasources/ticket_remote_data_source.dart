import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lan_code/back-end/data/models/ticket_model.dart';

abstract class TicketRemoteDataSource {
  Future<List<TicketModel>?> getTicketForUser({required String idUser});

  Future<List<TicketModel>?> getTicketForExcursion({required String idExcursion});
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  @override
  Future<List<TicketModel>?> getTicketForUser({required String idUser}) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('tickets')
        .where('idUser', isEqualTo: idUser)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((ticket) => TicketModel.fromDocument(ticket)).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<TicketModel>?> getTicketForExcursion({required String idExcursion}) async {
    List response = [];
    await FirebaseFirestore.instance
        .collection('tickets')
        .where('idExcursion', isEqualTo: idExcursion)
        .get()
        .then(
          (snapshot) => {response = snapshot.docs},
        );

    try {
      return response.map((ticket) => TicketModel.fromDocument(ticket)).toList();
    } catch (e) {
      return null;
    }
  }
}
