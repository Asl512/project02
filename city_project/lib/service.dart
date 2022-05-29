import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/user/user_actions.dart';
import 'package:redux/redux.dart';

class AuthService {
  final FirebaseAuth fauth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      UserCredential result =
          await fauth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return UserMeth.fromFirebase(user);
    } catch (e) {
      print("Sing Error ============");
      print(e);
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      UserCredential result = await fauth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return UserMeth.fromFirebase(user);
    } catch (e) {
      print("Register Error ============");
      print(e);
      return null;
    }
  }

  Future layout(BuildContext context) async {
    await fauth.signOut();
    Store store = StoreProvider.of<AppState>(context);
    store.dispatch(GetAuthAction(user: null, token: null));
  }

  Stream<UserMeth?> get currentUser {
    return fauth.authStateChanges().map(
          (dynamic user) => user != null ? UserMeth.fromFirebase(user) : null,
        );
  }
}

class UserMeth {
  String? id;

  UserMeth.fromFirebase(dynamic user) {
    id = user.uid;
  }
}
