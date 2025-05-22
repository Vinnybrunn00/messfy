import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/users/users_provider.dart';
import 'package:messfy/widgets/bubble_chat.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String id;
  final String chatId;

  const ChatPage({
    super.key,
    required this.name,
    required this.id,
    required this.chatId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  UsersProvider usersProvider = UsersProvider();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isType = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackBlueColor,
        title: Text(widget.name, style: TextStyle(color: AppColors.whiteColor)),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.only(top: 5, bottom: isKeyboard ? 0 : 10),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                    firestore
                        .collection('chat')
                        .doc(widget.chatId)
                        .collection('messages')
                        .orderBy("timestamp", descending: false)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text('no hasData');

                  var docs = snapshot.data!.docs;

                  return ListView.separated(
                    separatorBuilder: (context, _) {
                      return Container(height: 3);
                    },
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return BubbleChat(
                        message: docs[index]['message'],
                        isMe: usersProvider.isMe(docs[index]['uid'])!,
                        time: docs[index]['time'],
                      );
                    },
                  );
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 550),
                    curve: Easing.legacyAccelerate,
                    padding: EdgeInsets.only(top: 1, bottom: 1),
                    margin: EdgeInsets.only(left: 12, bottom: 5),
                    decoration: BoxDecoration(
                      color: AppColors.blackBlueColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            isType = false;
                          });
                        }

                        if (value.isNotEmpty) {
                          setState(() {
                            isType = true;
                          });
                        }
                      },

                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: AppColors.whiteColor,
                      cursorWidth: 1,
                      cursorHeight: 21,
                      style: TextStyle(color: AppColors.whiteColor),
                      decoration: InputDecoration(
                        hintText: 'Type message...',
                        hintStyle: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),

                AnimatedContainer(
                  duration: Duration(milliseconds: 550),
                  curve: Curves.ease,
                  margin: EdgeInsets.only(left: 5, right: 8),
                  height: isType ? 48 : 0,
                  width: isType ? 48 : 0,
                  decoration: BoxDecoration(
                    color: AppColors.blackBlueColor,
                    borderRadius: BorderRadius.circular(48 / 2),
                  ),
                  child:
                      isType
                          ? Icon(BoxIcons.bx_send, color: AppColors.greenColor)
                          : null,
                ),
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: InkWell(
            //     onTap: () async {
            //       await usersProvider.sendMessage(
            //         'Outra messagem de Vini para Lucas',
            //         widget.id,
            //         widget.name,
            //         widget.chatId,
            //       );
            //     },
            //     child: Text('Send Message'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
