
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/wigets/dailo.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool?> login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        DailogWidget.showDailog("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        DailogWidget.showDailog("Wrong password provided for that user.");
      }
    }
    return false;
  }

  Future logout() async {
    auth.signOut();
  }
}