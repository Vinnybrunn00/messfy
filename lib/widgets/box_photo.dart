import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';

class BoxPhoto extends StatefulWidget {
  final String? photo;
  const BoxPhoto({super.key, this.photo});

  @override
  State<BoxPhoto> createState() => _BoxPhotoState();
}

class _BoxPhotoState extends State<BoxPhoto> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 650),
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: AppColors.blackBlueColor,
        borderRadius: BorderRadius.circular(35 / 2),
      ),
      child: Icon(Icons.person, color: AppColors.whiteColor),
    );
  }
}
