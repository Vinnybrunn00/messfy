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

  UsersProvider users = UsersProvider();

  String uid = '';

  bool isFollower = false;

  List<Map<String, dynamic>> items = [];

  Future<void> refresh() async {
    users.currentUser().then((currentUser) {
      setState(() {
        uid = currentUser['uid'];
      });
    });

    List<Map<String, dynamic>> itemsTemp = [];
    var get = await firestore.collection('users').get();

    for (var item in get.docs) {
      itemsTemp.add(item.data());
    }

    setState(() {
      items = itemsTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
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
        child: RefreshIndicator(
          onRefresh: () async {
            await refresh();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  clipBehavior: Clip.antiAlias,
                  itemBuilder: (context, index) {
                    return uid != items[index]['uid']
                        ? BoxNewUser(
                          uid: uid,
                          id: items[index]['uid'],
                          name: items[index]['name'],
                        )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
