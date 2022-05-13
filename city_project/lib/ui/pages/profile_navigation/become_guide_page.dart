import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/city/city_actions.dart';
import 'package:lan_code/back-end/redux/user/user_actions.dart';
import 'package:lan_code/service.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/navigation.dart';
import 'package:lan_code/ui/widgets/button_widget.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class BecomeGuidePage extends StatefulWidget {
  const BecomeGuidePage({Key? key}) : super(key: key);

  @override
  State<BecomeGuidePage> createState() => _BecomeGuidePageState();
}

class _BecomeGuidePageState extends State<BecomeGuidePage> {
  late Store<AppState> _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  void becomeGuide() async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(_store.state.authState.user!.idDocument)
          .update({
        "guidePermit": true,
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Navigation(index: 2)),
        (route) => false,
      );

      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: 'Вы стали гидом',
          textStyle: Montserrat(size: 15, color: White),
        ),
      );
    } catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: e.toString(),
          textStyle: Montserrat(size: 15, color: White),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Grey,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20, color: Blue),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                "Стать гидом",
                style: Montserrat(color: Blue, size: 25, style: Bold),
              ),
            ),
          ];
        },
        body: Center(
          child: ButtonWidget(
            buttonColor: Red,
            text: "Стать гидом",
            func: becomeGuide,
          ),
        ),
      ),
    );
  }
}
