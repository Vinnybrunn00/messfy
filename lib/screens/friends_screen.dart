import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/users/users_provider.dart';
import 'package:messfy/widgets/box_new_user.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String uid = '';

  UsersProvider users = UsersProvider();

  void update() {
    users.currentUser().then((currentUser) {
      setState(() {
        uid = currentUser['uid'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firestore.collection('friends').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var docs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return BoxNewUser(
                          name: docs[index]['name'],
                          id: docs[index]['uid'],
                          uid: uid,
                          isFriends: true,
                        );
                      },
                    );
                  }
                  return Text('error');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
