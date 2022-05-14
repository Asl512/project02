import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/useCases/user_useCase.dart';
import 'package:lan_code/back-end/redux/add_excursion/add_excursion_actions.dart';
import 'package:lan_code/service.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

abstract class AuthAction {}

class LoadAuthAction extends AuthAction {}

class NotAuthAction extends AuthAction {}

class ErrorAuthAction extends AuthAction {}

class GetAuthAction extends AuthAction {
  final String? token;
  final UserEntity? user;

  GetAuthAction({
    required this.token,
    required this.user,
  });
}

ThunkAction AuthThunkAction(context) => (Store store) async {
      store.dispatch(LoadAuthAction());
      UserMeth? _userMeth = Provider.of<UserMeth?>(context);
      if (_userMeth == null) {
        store.dispatch(NotAuthAction());
      } else {
        UserEntity? user = await GetUser(UserDataRepository()).call(_userMeth.id!);
        if (user == null) {
          store.dispatch(ErrorAuthAction());
        } else {
          store.dispatch(GetAuthAction(
            token: user.id,
            user: user,
          ));
        }
      }
    };
