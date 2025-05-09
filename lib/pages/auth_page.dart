import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:messfy/components/box_auth.dart';
import 'package:messfy/components/comp_button.dart';
import 'package:messfy/components/component_input.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/constants/constants_value.dart';
import 'package:messfy/styles/style_app.dart';
import 'package:messfy/widgets/event_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit(BuildContext context) {
    setState(() => isLoading = !isLoading);
    bool validate = _formKey.currentState?.validate() ?? false;

    if (!validate) return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [AppColors.blackBlueColor, AppColors.cyanColor],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxAuth(
              isLogin: isLogin,
              children: [
                Center(
                  child: Text(
                    '${isLogin ? "Log in" : "Register in"} App',
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 19),
                  ),
                ),
                SizedBox(height: 15),
                AnimatedContainer(
                  duration: Duration(milliseconds: 650),
                  height:
                      size.height *
                      (isLogin ? .2 : .3), //(validFormKey.value ? .3 : .4),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          isLogin
                              ? Container()
                              : CompInput(
                                labelText: 'Name',
                                controller: nameController,
                                validator: (name) {
                                  if (name != null) {
                                    if (name.isEmpty) {
                                      return 'Nome está vazio';
                                    }
                                  }
                                  return null;
                                },
                              ),
                          SizedBox(height: 10),
                          CompInput(
                            labelText: 'Email',
                            controller: emailController,
                            validator: (email) {
                              if (email != null) {
                                if (email.isEmpty) {
                                  return 'Nome está vazio';
                                }
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CompInput(
                            labelText: 'Password',
                            controller: passwdController,
                            validator: (passwd) {
                              if (passwd != null) {
                                if (passwd.isEmpty) {
                                  return 'Nome está vazio';
                                }
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          isLogin
                              ? Container()
                              : CompInput(
                                labelText: 'Confirm Password',
                                controller: passwdController,
                                validator: (passwd1) {
                                  if (passwd1 != null) {
                                    if (passwd1.isEmpty) {
                                      return 'Nome está vazio';
                                    }
                                  }
                                  return null;
                                },
                              ),
                          isLogin
                              ? CompButton(
                                onTap: () {
                                  setState(() => isLogin = !isLogin);
                                },
                                title: 'Forget a password?',
                              )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                EventButton(
                  isLoading: isLoading,
                  title: isLogin ? 'Sign In' : 'Sign Up',
                  onTap: () {},
                ),
                CompButton(
                  onTap: () {
                    setState(() => isLogin = !isLogin);
                  },
                  title: isLogin ? 'Sign Up' : 'Login',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
