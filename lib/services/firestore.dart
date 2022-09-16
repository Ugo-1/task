import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmgmt_app/services/user.dart';

class FireStoreService {

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future createUser({required CustomUser user}) async {
    try {
      await _collectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e;
    }
  }

  Future getUser(String uid) async {
    var userData = await _collectionReference.doc(uid).get();
    return CustomUser.fromJson(userData.data());
  }

}
