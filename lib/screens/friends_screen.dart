import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(children: [Text('Friends Screen')]),
      ),
    );
  }
}
