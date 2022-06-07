import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/user/user_actions.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/pages/navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const TIMEOUT_SECONDS = 3;
  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
    _store.dispatch(GetCityThunkAction());
  }

  void _navigateToNext() async {
    Future.delayed(const Duration(seconds: TIMEOUT_SECONDS), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const Navigation();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: White,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(logo),
            margin: const EdgeInsets.only(bottom: 30),
          ),
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Blue,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
