import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/constants/constants_value.dart';
import 'package:messfy/styles/style_app.dart';
import 'package:messfy/users/users_provider.dart';

class BoxNewUser extends StatefulWidget {
  final String? photo;
  final String name;
  final String id;
  final String uid;
  final bool isFriends;

  const BoxNewUser({
    super.key,
    this.photo,
    required this.name,
    required this.id,
    required this.uid,
    this.isFriends = false,
  });

  @override
  State<BoxNewUser> createState() => _BoxNewUserState();
}

class _BoxNewUserState extends State<BoxNewUser> {
  UsersProvider user = UsersProvider();

  bool? isFollower;

  void _isFollower() {
    user.currentFollowers(widget.id).then((isFollowers) {
      setState(() {
        isFollower = isFollowers;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _isFollower();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      height: isMobile.value ? size.height * .09 : size.height * .12,
      width: size.width,
      padding: EdgeInsets.only(top: 8),
      duration: Duration(milliseconds: 550),
      decoration: BoxDecoration(borderRadius: AppStyle.borderRadius12),
      child: Material(
        color: AppColors.foo,
        borderRadius: AppStyle.borderRadius12,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height:
                          isMobile.value ? size.width * .1 : size.width * .08,
                      width:
                          isMobile.value ? size.width * .1 : size.width * .08,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(
                          isMobile.value
                              ? size.width * .1
                              : size.width * .08 / 2,
                        ),
                      ),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height:
                      isMobile.value ? size.height * .032 : size.height * .04,
                  width: isMobile.value ? size.width * .17 : size.width * .14,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greenColor),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap:
                        widget.isFriends
                            ? () {}
                            : () async {
                              setState(() {
                                isFollower = !isFollower!;
                              });
                              await user.setFollowerUser(widget.id, widget.uid);

                              _isFollower();
                            },
                    child: Center(
                      child: Text(
                        widget.isFriends
                            ? 'Messages'
                            : isFollower != null
                            ? isFollower!
                                ? 'Seguindo'
                                : 'Seguir'
                            : '-',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
