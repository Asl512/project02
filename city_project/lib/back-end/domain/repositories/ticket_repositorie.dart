import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';

abstract class TicketRepository {
  Future<List<TicketEntity>?> getTicketForUser({required String idUser});
  Future<List<TicketEntity>?> getTicketForExcursion({required String idExcursion});
}
