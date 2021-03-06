import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:lan_code/back-end/redux/user/user_actions.dart';
import 'package:lan_code/back-end/redux/user/user_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/city_page.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/not_auth_profile_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/personal_area_page.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:redux/redux.dart';

import 'my_tickets_navigation/my_tickets_page.dart';

class Navigation extends StatelessWidget {
  final int index;

  const Navigation({
    this.index = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: BodyNavigation(index: index),
    );
  }
}

class BodyNavigation extends StatefulWidget {
  final int index;

  const BodyNavigation({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  _BodyNavigationState createState() => _BodyNavigationState();
}

class _BodyNavigationState extends State<BodyNavigation> {
  int? page;

  late Store<AppState> _store;
  late _FloatingActionButton floatingActionButton;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    floatingActionButton = _FloatingActionButton();
    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(AuthThunkAction(context));
    page ??= widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Blue,
        hasNotch: true,
        opacity: .2,
        currentIndex: page,
        onTap: (index) => setState(() => page = index!),
        elevation: 8,
        tilesPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        items: [
          MenuItem(icon: iconMenuExcursion, text: "??????????????????").widget,
          MenuItem(icon: iconMenuTickets, text: "?????? ????????????").widget,
          MenuItem(icon: iconMenuProfile, text: "??????????????").widget,
        ],
      ),
      floatingActionButton: floatingActionButton,
      body: page == 0
          ? const _City()
          : page == 1
              ? const MyTicketsPage()
              : const _Profile(),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, store) {
        if (store.isLoggedIn) {
          if (store.user!.guidePermit) {
            return FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddExcursionPage()),
              ),
              child: const Icon(Icons.add),
              backgroundColor: Blue,
            );
          }
        }
        return Container();
      },
    );
  }
}

class MenuItem {
  late BubbleBottomBarItem widget;
  final Widget icon;
  final String text;

  MenuItem({required this.icon, required this.text}) {
    widget = BubbleBottomBarItem(
        backgroundColor: Colors.deepPurple,
        icon: icon,
        activeIcon: icon,
        title: Text(text, style: Montserrat(color: White, size: 13)));
  }
}

class _City extends StatelessWidget {
  const _City({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, CityState>(
      converter: (store) => store.state.cityState,
      builder: (context, store) {
        if (store.isLoading) {
          return const LoadingWidget();
        } else if (store.isError) {
          return PageReloadWidget(
            errorText: '???????????? ?????????????????? ????????????',
            func: _store.dispatch(GetCityThunkAction()),
          );
        }
        return const CityPage();
      },
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, store) {
        if (store.isLoading) {
          return const LoadingWidget();
        } else if (store.isError) {
          return PageReloadWidget(
            errorText: '???????????? ???????????????? ??????????????',
            func: _store.dispatch(AuthThunkAction(context)),
          );
        } else if (store.isLoggedIn) {
          return PersonalAreaPage(store.user);
        }
        return const NotAuthProfilePage();
      },
    );
  }
}
