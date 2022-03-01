import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth fauth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try{
      dynamic result = await fauth.signInWithEmailAndPassword(email: email, password: password);
      dynamic user = result.user;
      return User.fromFirebase(user);
    }catch(e){
      return null;
    }
  }

  Future register(String email, String password) async {
    try{
      dynamic result = await fauth.createUserWithEmailAndPassword(email: email, password: password);
      dynamic user = result.user;
      return User.fromFirebase(user);
    }catch(e){
      return null;
    }
  }

  Future loyaut()async{
    await fauth.signOut();
  }

  /*Stream get currentUser{
    return fauth.onAuthStateChanged.map((dynamic user)=> user != null ? User.fromFirebase(user):null);
  }*/
}

class User{
  String? id;
  User.fromFirebase(dynamic user){
    this.id = user.uid;

  }
}