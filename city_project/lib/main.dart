import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_state.dart';
import 'package:lan_code/back-end/redux/app/app_reducer.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/booking/booking_state.dart';
import 'package:lan_code/back-end/redux/city/city_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:lan_code/back-end/redux/user/user_state.dart';
import 'package:lan_code/service.dart';
import 'package:lan_code/test.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'ui/pages/navigation.dart';

main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF002550),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Store<AppState> store = Store(
    appReducer,
    middleware: [thunkMiddleware],
    initialState: const AppState(
      excursionInfoState: ExcursionInfoState(),
      listCitiesState: ListCitiesState(),
      cityState: CityState(),
      allExcursions: ListExcursionsState(),
      groupExcursions: ListExcursionsState(),
      individualExcursions: ListExcursionsState(),
      authState: AuthState(),
      addExcursionState: AddExcursionState(),
      insertExcursionState: InsertExcursionState(),
      bookingState: BookingState(),
      guidActiveExcursions: ListExcursionsState(),
      guidModerateExcursions: ListExcursionsState(),
      bookingInfoState: BookingInfoState(),
    ),
  );

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: StreamProvider<UserMeth?>.value(
        value: AuthService().currentUser,
        initialData: null,
        child: const MaterialApp(
          home: Navigation(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}
