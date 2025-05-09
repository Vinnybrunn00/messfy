import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';

class BoxAuth extends StatefulWidget {
  final List<Widget> children;
  final bool isLogin;

  const BoxAuth({super.key, required this.children, required this.isLogin});

  @override
  State<BoxAuth> createState() => _BoxAuthState();
}

class _BoxAuthState extends State<BoxAuth> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      animationDuration: Duration(milliseconds: 650),
      elevation: 4,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        padding: EdgeInsets.only(left: 15, right: 15),
        duration: Duration(milliseconds: 650),
        height: size.height * (widget.isLogin ? .52 : .6),
        width: size.width * .8,
        decoration: BoxDecoration(
          color: AppColors.blackBlueColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widget.children,
        ),
      ),
    );
  }
}
