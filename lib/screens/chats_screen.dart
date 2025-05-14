import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
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
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Text('Chat Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
