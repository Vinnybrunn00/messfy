

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messfy/chat/chat_page.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/users/users_provider.dart';
import 'package:messfy/utils/utils.dart';

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
                        String chatId = docs[index].id;

                        if (chatId.contains(uid)) {
                          List listUsers = docs[index]['listUsers'];
                          for (var user in listUsers) {
                            if (!user['id'].contains(uid)) {
                              return ListTile(
                                onTap: () {
                                  Utils.routeScreen(
                                    context,
                                    route: ChatPage(
                                      name: user['name'],
                                      id: user['id'],
                                      chatId: chatId,
                                    ),
                                  );
                                },
                                title: Text(
                                  '${user['name']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'Click for see the messages',
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                            }
                          }
                        }
                        return Container();
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
