import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/users/users_provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String uid = '';

  UsersProvider usersProvider = UsersProvider();

  void update() {
    usersProvider.currentUser().then((user) {
      setState(() {
        uid = user['uid'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firestore.collection('chat').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var docs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return Text('data');
                      },
                    );
                  }
                  return Text('data');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
