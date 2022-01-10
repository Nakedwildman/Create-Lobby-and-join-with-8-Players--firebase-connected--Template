import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_card_game_updated/classes/user.dart';

class Authentication {

  final String gameID;

  Authentication({required this.gameID});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(uid: user.uid, gameID: gameID);
    }
  }

  Future signIn() async {
    try {
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}