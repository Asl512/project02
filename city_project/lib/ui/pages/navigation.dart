import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/excursion_navigation/city_page.dart';
import 'package:lan_code/ui/pages/guide/addExcursion.dart';
import 'package:lan_code/ui/pages/my_tickets_navigation/my_tickets_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/not_auth_profile_page.dart';
import 'package:lan_code/ui/pages/profile_navigation/personal_area_page.dart';
import 'package:lan_code/ui/widgets/loading_widget.dart';
import 'package:lan_code/ui/widgets/page_reload_widget.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:redux/redux.dart';

class Navigation extends StatelessWidget {
  final int index;

  const Navigation({this.index = 0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final UserMeth? userProvider = Provider.of<UserMeth?>(context);

    return Scaffold(
        backgroundColor: Grey,
        body: BodyNavigation(
          index: index,
        ));
  }
}

class BodyNavigation extends StatefulWidget {
  final int index;
  final UserEntity? userEntity;

  const BodyNavigation({this.userEntity, required this.index, Key? key}) : super(key: key);

  @override
  _BodyNavigationState createState() => _BodyNavigationState();
}

class _BodyNavigationState extends State<BodyNavigation> {
  int? page;

  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(GetCityThunkAction());
    page ??= widget.index;
  }

  @override
  Widget build(BuildContext context) {
    //final UserMeth? userProvider = Provider.of<UserMeth?>(context);

    _FloatingActionButton floatingActionButton = _FloatingActionButton(widget.userEntity);

    return Scaffold(
        bottomNavigationBar: BubbleBottomBar(
            fabLocation: floatingActionButton.fabLocation(),
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
              MenuItem(icon: iconMenuExcursion, text: "Экскурсии").widget,
              MenuItem(icon: iconMenuTickets, text: "Мои билеты").widget,
              MenuItem(icon: iconMenuProfile, text: "Профиль").widget,
            ]),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButton.location(),
        body: page == 0
            ? const _City()
            : page == 1
                ? const MyTicketsPage()
                : widget.userEntity == null
                    ? const NotAuthProfilePage()
                    : PersonalAreaPage(widget.userEntity));
  }
}

class _FloatingActionButton extends StatelessWidget {
  final UserEntity? user;
  late bool guidePermit;

  _FloatingActionButton(this.user) {
    guidePermit = (user?.guidePermit) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (guidePermit) {
      return FloatingActionButton(
        ///нунжо передать данные
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AddExcursion(typeExcursion: []))),
        child: const Icon(Icons.add),
        backgroundColor: Blue,
      );
    } else {
      return Container();
    }
  }

  FloatingActionButtonLocation? location() {
    if (guidePermit) {
      return FloatingActionButtonLocation.endDocked;
    } else {
      return null;
    }
  }

  BubbleBottomBarFabLocation? fabLocation() {
    if (guidePermit) {
      return BubbleBottomBarFabLocation.end;
    } else {
      return null;
    }
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
    return StoreConnector<AppState, CityState>(
      converter: (store) => store.state.cityState,
      builder: (context, store) {
        if (store.isLoading) {
          return const LoadingWidget();
        } else if (store.isError) {
          return const PageReloadWidget('Ошибка получения города');
        }
        return CityPage(store.city);
      },
    );
  }
}
