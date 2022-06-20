import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/ticket/ticket_actions.dart';
import 'package:lan_code/back-end/redux/ticket/ticket_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/my_tickets_navigation/ticket_card.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            if (_store.state.ticketListActivityState.excursions.isEmpty) {
              _store.dispatch(TicketListActivityThunkAction());
            }
            break;
          case 1:
            if (_store.state.ticketListCancelState.excursions.isEmpty) {
              _store.dispatch(TicketListCancelThunkAction());
            }
            break;
        }
      }
    });
    if (_store.state.ticketListActivityState.excursions.isEmpty) {
      _store.dispatch(TicketListActivityThunkAction());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      appBar: AppBar(
        title: Text(
          "Мои билеты",
          style: Montserrat(size: 25, style: Bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          //isScrollable: true,
          indicatorColor: Blue,
          tabs: [
            Tab(child: Text("Активные", style: Montserrat())),
            //Tab(child: Text("Избранные", style: Montserrat())),
            Tab(child: Text("Отмененные", style: Montserrat())),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Grey,
      ),
      body: Scaffold(
        backgroundColor: Grey,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            _Activity(storeApp: _store),
            _Cancel(storeApp: _store),
          ],
        ),
      ),
    );
  }
}

class _Activity extends StatelessWidget {
  final Store<AppState> storeApp;

  const _Activity({
    Key? key,
    required this.storeApp,
  }) : super(key: key);

  void refresh() {
    storeApp.dispatch(TicketListActivityThunkAction());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Blue,
      onRefresh: () => Future(() => refresh()),
      child: StoreConnector<AppState, TicketListState>(
        converter: (store) => store.state.ticketListActivityState,
        builder: (context, store) {
          if (store.isLoading) {
            return const LoadingWidget();
          } else if (store.isError) {
            return PageReloadWidget(
              errorText: 'Ошибка загрузки билетов',
              func: refresh,
            );
          }
          if (store.excursions.isEmpty) {
            return Center(
              child: Text(
                'У вас нет активных экскурсий',
                style: Montserrat(style: Bold, size: 15),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.separated(
            itemCount: store.tickets.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              return TicketCard(
                excursion: store.excursions[index],
                ticket: store.tickets[index],
                status: StatusTicket.active,
              );
            },
          );
        },
      ),
    );
  }
}

class _Cancel extends StatelessWidget {
  final Store<AppState> storeApp;

  const _Cancel({
    Key? key,
    required this.storeApp,
  }) : super(key: key);

  void refresh() {
    storeApp.dispatch(TicketListCancelThunkAction());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Blue,
      onRefresh: () => Future(() => refresh()),
      child: StoreConnector<AppState, TicketListState>(
        converter: (store) => store.state.ticketListCancelState,
        builder: (context, store) {
          if (store.isLoading) {
            return const LoadingWidget();
          } else if (store.isError) {
            return PageReloadWidget(
              errorText: 'Ошибка загрузки билетов',
              func: refresh,
            );
          }
          if (store.excursions.isEmpty) {
            return Center(
              child: Text(
                'У вас нет отмененных экскурсий',
                style: Montserrat(style: Bold, size: 15),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.separated(
            itemCount: store.tickets.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              return TicketCard(
                excursion: store.excursions[index],
                ticket: store.tickets[index],
                status: StatusTicket.cancel,
              );
            },
          );
        },
      ),
    );
  }
}
