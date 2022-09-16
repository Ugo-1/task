import 'package:firebase_auth/firebase_auth.dart';

class FireBaseModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUpUser(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInUser(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

}