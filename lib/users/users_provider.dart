import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersProvider {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<String?> changeName(String name) async {
    CollectionReference<Map<String, dynamic>> usersCollections =
        FirebaseFirestore.instance.collection('users');

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updateDisplayName(name);
        await usersCollections.doc(user.uid).update({'name': name});
        return null;
      } on FirebaseAuthException catch (err) {
        return err.code;
      }
    }
  }

  Future<Map<String, dynamic>> currentUser() async {
    Map<String, dynamic> mapUser = {};

    User? currentUser = auth.currentUser;

    if (currentUser != null) {
      var get = await firestore.collection('users').doc(currentUser.uid).get();

      Map<String, dynamic>? data = get.data();

      if (data != null) {
        mapUser = {
          'uid': currentUser.uid,
          'name': currentUser.displayName,
          'email': currentUser.email,
          'time': data['time'],
        };
      }
    }

    return mapUser;
  }
}
