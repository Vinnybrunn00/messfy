import 'package:flutter/material.dart';
import 'package:messfy/components/box_auth.dart';
import 'package:messfy/components/comp_button.dart';
import 'package:messfy/components/component_input.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/constants/constants_value.dart';

import 'package:messfy/services/auth_services.dart';
import 'package:messfy/utils/routers.dart';

import 'package:messfy/utils/utils.dart';
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
  TextEditingController confirmPasswdController = TextEditingController();

  bool isAuth = true;
  bool isLogin = true;
  bool isLoading = false;
  bool onTapEnabled = false;

  final _formKey = GlobalKey<FormState>();

  AuthServices auth = AuthServices();

  void _onSubmit(BuildContext context) {
    setState(() => isLoading = !isLoading);
    bool validate = _formKey.currentState?.validate() ?? false;

    if (!validate) {
      setState(() => isLoading = !isLoading);
      return;
    }

    Map<String, dynamic> mapCredentials = {
      'isLogin': isLogin,
      'name': nameController.text,
      'email': emailController.text,
      'password': passwdController.text,
    };

    auth.signInAndSignUp(mapCredential: mapCredentials).then((event) {
      if (event != null && context.mounted) {
        Utils.showErrorMessageFloating(
          context: context,
          message: event['error'],
        );
        setState(() => isLoading = !isLoading);
        return;
      }

      if (!context.mounted) return;
      Utils.goNamedRoute(context, route: AppRoute.home);
      setState(() => isLoading = !isLoading);
    });
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwdController.clear();
    confirmPasswdController.clear();
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
                      (isMobile.value
                          ? (isLogin ? .2 : .3)
                          : (isLogin ? .25 : .35)),
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
                                  return Utils.showFormError(name, 'name');
                                },
                              ),
                          SizedBox(height: 10),
                          CompInput(
                            labelText: 'Email',
                            controller: emailController,
                            validator: (email) {
                              return Utils.showFormError(email, 'email');
                            },
                          ),
                          SizedBox(height: 10),
                          CompInput(
                            labelText: 'Password',
                            controller: passwdController,
                            onChanged: (value) {
                              if (value == confirmPasswdController.text) {
                                setState(() {
                                  onTapEnabled = true;
                                });
                              } else {
                                setState(() {
                                  onTapEnabled = false;
                                });
                              }
                            },
                            validator: (passwd) {
                              return Utils.showFormError(passwd, 'password');
                            },
                          ),
                          SizedBox(height: 10),
                          isLogin
                              ? Container()
                              : CompInput(
                                labelText: 'Confirm Password',
                                controller: confirmPasswdController,
                                onChanged: (value) {
                                  if (value == passwdController.text) {
                                    setState(() {
                                      onTapEnabled = true;
                                    });
                                  } else {
                                    setState(() {
                                      onTapEnabled = false;
                                    });
                                  }
                                },
                                validator: (pass1) {
                                  return Utils.showFormError(pass1, 'password');
                                },
                              ),
                          isLogin
                              ? CompButton(
                                onTap: () {
                                  //setState(() => isLogin = !isLogin);
                                },
                                title: 'Forget a Password?',
                              )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                EventButton(
                  onTapEnabled: isLogin ? null : onTapEnabled,
                  isLoading: isLoading,
                  title: isLogin ? 'Sign In' : 'Sign Up',
                  onTap:
                      isLogin
                          ? () {
                            _onSubmit(context);
                          }
                          : onTapEnabled && !isLoading
                          ? () {
                            _onSubmit(context);
                          }
                          : null,
                ),
                CompButton(
                  onTap: () {
                    setState(() => isLogin = !isLogin);
                    _clearControllers();
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
