import 'package:flutter/material.dart';
import 'package:lan_code/feature/domain/entities/city_entity.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';
import 'package:lan_code/feature/presentation/pages/activity_navigation/activity_page.dart';
import 'package:lan_code/feature/presentation/pages/excursion_navigation/city_page.dart';
import 'package:lan_code/feature/presentation/pages/my_tickets_navigation/my_tickets_page.dart';
import 'package:lan_code/feature/presentation/pages/profile_navigation/personal_area_page.dart';
import 'package:lan_code/feature/presentation/redux/navigation_redux/navigation_action.dart';
import 'package:lan_code/feature/presentation/redux/navigation_redux/navigation_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:redux/redux.dart';
import '../../common/colors.dart';
import '../../common/icons.dart';
import '../../common/textStyle.dart';
import '../../service.dart';
import 'pages/guide/addExcursion.dart';
import 'pages/profile_navigation/not_auth_profile_page.dart';

class Navigation extends StatelessWidget {
  final int index;
  const Navigation({this.index = 0,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    final Store<NavigationState> store = StoreProvider.of<NavigationState>(context);
    final UserMeth? userProvider = Provider.of<UserMeth?>(context);
    store.dispatch(NavigationThunkAction(userProvider,index));
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Grey,
        body: StoreConnector<NavigationState,NavigationState>(
            converter: (store) =>store.state,
            builder: (context, store) => store.navigation
        ),
      ),
    );
  }
}


class BodyNavigation extends StatefulWidget {
  final int index;
  final CityEntiti cityEntiti;
  final UserEntity? userEntity;
  const BodyNavigation({
    required this.userEntity,
    required this.cityEntiti,
    required this.index,
    Key? key}) : super(key: key);
  @override
  _BodyNavigationState createState() => _BodyNavigationState();
}

class _BodyNavigationState extends State<BodyNavigation> {
  int? page;

  @override
  Widget build(BuildContext context) {
    _floatingActionButton floatingActionButton =  _floatingActionButton(widget.userEntity);
    page ??= widget.index;

    return Scaffold(
        bottomNavigationBar: BubbleBottomBar(
            fabLocation: floatingActionButton.fabLocation(),
            backgroundColor: Blue,
            hasNotch: true,
            opacity: .2,
            currentIndex: page,
            onTap: (index)=>setState(() => page = index!),
            elevation: 8,
            tilesPadding: const EdgeInsets.symmetric(vertical: 8.0,),
            items: [
              MenuItem(icon: iconMenuExcursion,text: "Экскурсии").widget,
              MenuItem(icon: iconMenuTickets,text: "Мои билеты").widget,
              MenuItem(icon: iconMenuActivity,text: "Активность").widget,
              MenuItem(icon: iconMenuProfile,text: "Профиль").widget,
            ]
        ),

        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButton.location(),
        body:
        page == 0? CityPage(widget.cityEntiti):
        page == 1? const MyTicketsPage():
        page == 2? const ActivityPage():
        widget.userEntity == null? const NotAuthProfilePage(): PersonalAreaPage(widget.userEntity)
    );
  }
}


class _floatingActionButton extends StatelessWidget {
  final UserEntity? user;
  late bool guidePermit;

  _floatingActionButton(this.user){
    guidePermit = (user?.guidePermit)??false;
  }

  @override
  Widget build(BuildContext context) {
    if(guidePermit){
      return FloatingActionButton(
        ///нунжо передать данные
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => const AddExcursion(typeExcursion: []))),
        child: const Icon(Icons.add),
        backgroundColor: Blue,
      );
    }
    else {
      return Container();
    }
  }

  FloatingActionButtonLocation? location(){
    if(guidePermit) {
      return FloatingActionButtonLocation.endDocked;
    } else {
      return null;
    }
  }

  BubbleBottomBarFabLocation? fabLocation(){
    if(guidePermit) {
      return BubbleBottomBarFabLocation.end;
    } else {
      return null;
    }
  }
}


class MenuItem{
  late BubbleBottomBarItem widget;
  final Widget icon;
  final String text;
  MenuItem({required this.icon, required this.text}){
   widget = BubbleBottomBarItem(
       backgroundColor: Colors.deepPurple,
       icon: icon,
       activeIcon: icon,
       title: Text(text,style: Montserrat(color: White,size: 13))
   );
  }
}