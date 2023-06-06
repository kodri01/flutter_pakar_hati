import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pakar_hati/admin/admin_navbar.dart';
import 'package:pakar_hati/pages/navbar.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  //reference for collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  Future saveUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'role': 'user',
      'uid': uid,
    });
  }

  Future saveUserGoogle(User user) async {
    return await userCollection.doc(uid).set({
      'fullName': user.displayName,
      'email': user.email,
      'role': 'user',
      'uid': uid
    });
  }

  Future getUser() async {
    DocumentSnapshot snap = await userCollection.doc(uid).get();
    return snap;
  }
}
