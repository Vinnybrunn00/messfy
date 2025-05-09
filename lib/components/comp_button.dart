import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:messfy/constants/constants_colors.dart';

class CompButton extends StatefulWidget {
  final void Function()? onTap;
  final String title;

  const CompButton({super.key, required this.onTap, required this.title});

  @override
  State<CompButton> createState() => _CompButtonState();
}

class _CompButtonState extends State<CompButton> {
  bool get containsPass {
    return widget.title.contains('password');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment:
            containsPass ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          containsPass
              ? Icon(
                containsPass ? EvaIcons.arrow_back : EvaIcons.arrow_forward,
                color: AppColors.greenColor,
                size: 18,
              )
              : Container(),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.greenColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          containsPass
              ? Container()
              : Icon(
                EvaIcons.arrow_forward,
                color: AppColors.greenColor,
                size: 18,
              ),
        ],
      ),
    );
  }
}
