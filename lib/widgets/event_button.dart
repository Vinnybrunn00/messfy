import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/styles/style_app.dart';

class EventButton extends StatefulWidget {
  final void Function()? onTap;
  final String title;
  final bool isLoading;

  const EventButton({
    super.key,
    this.onTap,
    required this.title,
    required this.isLoading,
  });

  @override
  State<EventButton> createState() => _EventButtonState();
}

class _EventButtonState extends State<EventButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      borderRadius: AppStyle.borderRadius12,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 650),
        height: 45,
        width: size.width,
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onTap,
          borderRadius: AppStyle.borderRadius12,
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.cyanColor,
              borderRadius: AppStyle.borderRadius12,
            ),
            child: Center(
              child:
                  widget.isLoading
                      ? CircularProgressIndicator(
                        color: AppColors.whiteColor,
                        strokeWidth: 2,
                      )
                      : Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
