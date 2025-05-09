import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/styles/style_app.dart';

class CompInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String labelText;

  const CompInput({
    super.key,
    this.controller,
    this.validator,
    required this.labelText,
  });

  @override
  State<CompInput> createState() => _CompInputState();
}

class _CompInputState extends State<CompInput> {
  bool isVisibily = false;

  bool get containsPassword {
    return widget.labelText.toLowerCase().contains('password');
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.all(20),
      controller: widget.controller,
      validator: widget.validator,
      cursorColor: AppColors.whiteColor,
      style: TextStyle(color: AppColors.whiteColor),
      cursorWidth: 1,

      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 12.5,
          color: AppColors.cyanColor,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyle.borderRadius12,
          borderSide: BorderSide(color: AppColors.greyColor, width: .8),
        ),
        border: OutlineInputBorder(borderRadius: AppStyle.borderRadius12),
        suffixIcon:
            containsPassword
                ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isVisibily = !isVisibily;
                    });
                  },
                  child: Icon(
                    isVisibily ? EvaIcons.eye : EvaIcons.eye_off,
                    color: AppColors.whiteColor,
                    size: 21,
                  ),
                )
                : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.cyanColor),
          borderRadius: AppStyle.borderRadius12,
        ),
      ),
      obscureText: containsPassword ? !isVisibily : false,
    );
  }
}
