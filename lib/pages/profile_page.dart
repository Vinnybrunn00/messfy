import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/constants/constants_value.dart';
import 'package:messfy/users/users_provider.dart';
import 'package:messfy/utils/utils.dart';
import 'package:messfy/widgets/box_edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name, email, time;

  List followers = [];
  List following = [];

  late TextEditingController nameController;
  late TextEditingController emailController;

  UsersProvider usersProvider = UsersProvider();

  @override
  void initState() {
    super.initState();

    usersProvider.currentUser().then((value) {
      setState(() {
        name = value['name'];
        email = value['email'];
        time = value['time'];
        followers = value['followers'];
        following = value['following'];
      });
    });
    nameController = TextEditingController(text: name);
    emailController = TextEditingController(text: email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.cyanColor, elevation: 0),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                AppColors.cyanColor,
                AppColors.blackBlueColor,
                AppColors.blackBlueColor,
              ],
            ),
          ),
          child:
              name != null
                  ? Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height:
                                    isMobile.value
                                        ? size.width * .2
                                        : size.width * .15,
                                width:
                                    isMobile.value
                                        ? size.width * .2
                                        : size.width * .15,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                    size.width * 2 / 2,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 1,
                                right: 1,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(25 / 2),
                                  ),
                                  child: Icon(EvaIcons.edit, size: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    name ?? '-',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('${followers.length} Seguidores'),
                                  SizedBox(width: 5),
                                  Text('${following.length} Seguindo'),
                                ],
                              ),
                              Text(
                                'Conta criada em ${time ?? '-'}',
                                style: TextStyle(
                                  color: const Color(0xCDFFFF00),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      BoxEditProfile(
                        content: name,
                        widget: InkWell(
                          onTap: () {
                            Utils.showModal(context, size);
                          },
                          child: Icon(
                            Icons.edit,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                      BoxEditProfile(content: email),
                    ],
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.greenColor,
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
