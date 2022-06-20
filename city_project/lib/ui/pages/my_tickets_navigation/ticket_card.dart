import 'package:flutter/material.dart';
import 'package:lan_code/back-end/domain/entities/excursion_entity.dart';
import 'package:lan_code/back-end/domain/entities/ticket_entity.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/my_tickets_navigation/ticket_detail_page.dart';
import 'package:lan_code/ui/widgets/style.dart';

enum StatusTicket {
  active,
  cancel,
}

class TicketCard extends StatelessWidget {
  final ExcursionEntity excursion;
  final TicketEntity ticket;
  final StatusTicket status;

  const TicketCard({
    required this.excursion,
    required this.ticket,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 60),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketDetailPage(
                excursion: excursion,
                ticket: ticket,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    ImageExcursionHeader(photo: excursion.photo),
                    Container(
                      height: 50,

                      ///сделать размер черной подложки нормальным
                      width: excursion.name.length.toDouble() * 14 + 50 >=
                              MediaQuery.of(context).size.width / 1.4
                          ? MediaQuery.of(context).size.width / 1.4
                          : excursion.name.length.toDouble() * 14 + 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 15),
                      child: Flexible(
                        child: Text(
                          excursion.name,
                          style: Montserrat(size: 15, style: SemiBold, color: White),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            ///ОПИСАНИЕ
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: White,
                boxShadow: [ShadowForContainer()],
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${ticket.getTickets} билетов',
                        style: Montserrat(
                          size: 17,
                          style: SemiBold,
                          color: const Color(0xFF55596A),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            status == StatusTicket.active ? 'Активно' : 'Не активно',
                            style: Montserrat(
                              size: 12,
                              style: SemiBold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: status == StatusTicket.active ? Colors.green : Red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Дата: ${ticket.getDate}',
                        style: Montserrat(size: 16, style: Bold),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Время: ${ticket.getTime}',
                        style: Montserrat(size: 15, style: Medium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageExcursionHeader extends StatelessWidget {
  final String photo;

  const ImageExcursionHeader({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

        ///КАРТИНКА
        ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: Image.network(
        photo,
        fit: BoxFit.cover,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 10 + 20,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return Placholder(
            double.infinity,
            MediaQuery.of(context).size.height / 10 + 20,
          );
        },
        errorBuilder: (context, error, stackTrace) => Image.asset(
          excursionDef,
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 10 + 20,
        ),
      ),
    );
  }
}
