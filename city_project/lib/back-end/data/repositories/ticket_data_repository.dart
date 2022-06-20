import 'package:lan_code/back-end/data/datasources/ticket_remote_data_source.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/back-end/domain/repositories/ticket_repositorie.dart';

class TicketDataRepository extends TicketRepository {
  @override
  Future<List<TicketEntity>?> getTicketForUser({required String idUser}) async {
    return await _getListTicket(() {
      return TicketRemoteDataSourceImpl().getTicketForUser(idUser: idUser);
    });
  }

  @override
  Future<List<TicketEntity>?> getTicketForExcursion({required String idExcursion}) async {
    return await _getListTicket(() {
      return TicketRemoteDataSourceImpl().getTicketForExcursion(idExcursion: idExcursion);
    });
  }

  Future<List<TicketEntity>?> _getListTicket(
      Future<List<TicketEntity>?> Function() getTickets) async {
    return getTickets();
  }
}
