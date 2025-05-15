import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/styles/style_app.dart';

class BoxEditProfile extends StatefulWidget {
  final Widget? widget;
  final String? content;

  const BoxEditProfile({super.key, this.content, this.widget});

  @override
  State<BoxEditProfile> createState() => _BoxEditProfileState();
}

class _BoxEditProfileState extends State<BoxEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Material(
        color: const Color.fromARGB(255, 57, 84, 116),
        borderRadius: AppStyle.borderRadius12,
        elevation: 5,
        child: ListTile(
          trailing: widget.widget,
          title: Text(
            widget.content ?? '-',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
