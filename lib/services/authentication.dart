import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmgmt_app/models/firebase.dart';
import 'package:taskmgmt_app/services/firestore.dart';
import 'package:taskmgmt_app/services/user.dart';

class AuthenticationService {

  CustomUser? _currentUser;
  CustomUser? get currentUser => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireBaseModel _fireBaseModel = FireBaseModel();
  final FireStoreService _fireStoreService = FireStoreService();

  Future _populateCurrentUser(User? user) async {
    if (user != null) {
      _currentUser = await _fireStoreService.getUser(user.uid);
    }
  }

  Future registerUser({
    required String email,
    required String password,
    required String userName,
  }) async {

    try{
      UserCredential userCredential = await _fireBaseModel.signUpUser(email, password);
      final user = userCredential.user;
      if (user != null){
        CustomUser customUser = CustomUser(
          id: user.uid,
          email: email,
          userName: userName,
        );
        await _fireStoreService.createUser(user: customUser);
        _currentUser = customUser;
      }
      return user != null;
    } catch (e){
      return e;
    }
  }

  Future loginUser({
    required String email,
    required String password,
  }) async {

    try {
      UserCredential userCredential = await _fireBaseModel.signInUser(email, password);
      User? user = userCredential.user;
      await _populateCurrentUser(user);
      return user != null;
    } catch (e){
      return e;
    }
  }

  Future<bool> isUserLoggedIn() async{
    User? user = _auth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  void logOut() async {
    await _auth.signOut();
  }
}