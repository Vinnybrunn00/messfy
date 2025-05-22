import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messfy/utils/utils.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> signInAndSignUp({
    required Map<String, dynamic> mapCredential,
  }) async {
    try {
      if (!mapCredential['isLogin']) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: mapCredential['email'],
          password: mapCredential['password'],
        );

        User? user = cred.user;

        if (user != null) {
          await user.updateDisplayName(mapCredential['name']);
          await firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'name': Utils.capitalize(mapCredential['name']),
            'photo': null,
            'followers': [],
            'following': [],
            'email': mapCredential['email'],
            'time': Utils.time,
          });
        }
        return null;
      }
      await firebaseAuth.signInWithEmailAndPassword(
        email: mapCredential['email'],
        password: mapCredential['password'],
      );
      return null;
    } on FirebaseAuthException catch (err) {
      return Utils.firebaseAuthException(err.code);
    }
  }
}
