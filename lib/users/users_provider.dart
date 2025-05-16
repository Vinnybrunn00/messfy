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
      } on FirebaseAuthException catch (err) {
        return err.code;
      }
    }
    return null;
  }

  //-----------------------------------------------------//
  // start Followers and Following ----------------------//
  //-----------------------------------------------------//

  Future<bool> currentFollowers(String id) async {
    bool? isFollower;

    User? user = auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> get =
          await firestore.collection('users').doc(id).get();

      Map<String, dynamic>? data = get.data();
      if (data != null) {
        List followers = data['followers'] as List;

        if (followers.contains(user.uid)) {
          isFollower = true;
        } else {
          isFollower = false;
        }
      }
    }
    return isFollower ?? false;
  }

  static Future<void> _addOrRemoveFollowingAndFollowers({
    required Map<String, dynamic> map,
    required bool removeFollowingOrFollowers,
  }) async {
    if (removeFollowingOrFollowers) {
      map['newFollowers'] = map['followers'];
      map['newFollowers'].remove(map['uid']);

      map['newFollowing'] = map['following'];
      map['newFollowing'].remove(map['id']);

      await map['usersCollections'].doc(map['id']).update({
        'followers': map['newFollowers'],
      });
      await map['usersCollections'].doc(map['uid']).update({
        'following': map['newFollowing'],
      });
    } else {
      map['newFollowers'] = map['followers'];
      map['newFollowers'].add(map['uid']);

      map['newFollowing'] = map['following'];
      map['newFollowing'].add(map['id']);

      await map['usersCollections'].doc(map['id']).update({
        'followers': map['newFollowers'],
      });
      await map['usersCollections'].doc(map['uid']).update({
        'following': map['newFollowing'],
      });
    }
  }

  Future<void> setFollowerUser(String id) async {
    CollectionReference<Map<String, dynamic>> usersCollections = firestore
        .collection('users');

    DocumentSnapshot<Map<String, dynamic>> get =
        await firestore.collection('users').doc(id).get();

    List newFollowers = [];
    List newFollowing = [];

    Map<String, dynamic>? data = get.data();

    if (data != null) {
      List followers = data['followers'] as List;
      List following = data['following'] as List;

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Map<String, dynamic> map = {
          'id': id,
          'uid': user.uid,
          'followers': followers,
          'following': following,
          'newFollowers': newFollowers,
          'newFollowing': newFollowing,
          'usersCollections': usersCollections,
          'removeFollowingOrFollowers': true,
        };

        for (var ids in followers) {
          if (ids == user.uid) {
            await UsersProvider._addOrRemoveFollowingAndFollowers(
              map: map,
              removeFollowingOrFollowers: true,
            );
            _addOrDeleteFriends(id, false);
            return;
          }
        }
        await UsersProvider._addOrRemoveFollowingAndFollowers(
          map: map,
          removeFollowingOrFollowers: false,
        );
        _addOrDeleteFriends(id, true);
      }
    }
  }

  Future<void> _addOrDeleteFriends(String id, bool isAdd) async {
    CollectionReference<Map<String, dynamic>> friendsCollection = firestore
        .collection('friends');
    CollectionReference<Map<String, dynamic>> usersCollection = firestore
        .collection('users');

    DocumentSnapshot<Map<String, dynamic>> get =
        await usersCollection.doc(id).get();

    Map<String, dynamic>? data = get.data();

    if (data != null) {
      if (isAdd) {
        await friendsCollection.doc(id).set({
          'name': data['name'],
          'followers': data['followers'],
          'following': data['following'],
          'photo': data['photo'],
          'uid': data['uid'],
        });
      } else {
        await friendsCollection.doc(id).delete();
      }
    }
  }

  //----------------------------------------------------//
  // stop Followers and Following ----------------------//
  //----------------------------------------------------//

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
          'followers': data['followers'] as List,
          'following': data['following'] as List,
        };
      }
    }

    return mapUser;
  }
}
