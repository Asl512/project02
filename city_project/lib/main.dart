import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/feature/presentation/widgets/page_reload_widget.dart';
import 'package:lan_code/service.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'feature/presentation/navigation.dart';
import 'feature/presentation/redux/navigation_redux/navigation_state.dart';
import 'feature/presentation/redux/navigation_redux/navigation_reducer.dart';

main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: Color(0xFF002550)));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Store<NavigationState> store = Store(
      navigationReducer,
      middleware: [thunkMiddleware],
      initialState: NavigationState(
        navigation: const PageReloadWidget("Ошибка попробуйте позже"),
      )
  );

  runApp(
      StoreProvider(
        store: store,
        child: StreamProvider<UserMeth?>.value(
          value: AuthService().currentUser,
          initialData: null,
          child: const MaterialApp(
            home: Navigation()
          ),
        ),
      )
  );
}