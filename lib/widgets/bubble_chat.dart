import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';

class BubbleChat extends StatefulWidget {
  final bool isMe;
  final String message;
  final String time;

  const BubbleChat({
    super.key,
    required this.isMe,
    required this.message,
    required this.time,
  });

  @override
  State<BubbleChat> createState() => _BubbleChatState();
}

class _BubbleChatState extends State<BubbleChat> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment:
          widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 10, right: 10),
          duration: Duration(milliseconds: 550),
          width: size.width * .8,
          decoration: BoxDecoration(
            color: widget.isMe ? AppColors.cyanColor : AppColors.blackBlueColor,

            borderRadius: BorderRadius.only(
              topLeft: widget.isMe ? Radius.circular(8) : Radius.zero,
              bottomLeft: Radius.circular(8),
              topRight: widget.isMe ? Radius.zero : Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.time,
                      style: TextStyle(
                        color:
                            widget.isMe
                                ? AppColors.whiteColor
                                : AppColors.greyColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
