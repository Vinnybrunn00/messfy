

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/constants/constants_value.dart';
import 'package:messfy/home/home_page.dart';
import 'package:messfy/pages/auth_page.dart';
import 'package:messfy/styles/style_app.dart';

class Utils {
  static StreamBuilder chooseRoute(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        }
        return AuthPage();
      },
    );
  }

  static String? showFormError(String? value, String controller) {
    String stringTrim = controller.toLowerCase().trim();

    if (value != null) {
      if (value.isEmpty) {
        return 'Campo $controller está vazio';
      }
      switch (stringTrim) {
        case 'email':
          if (!emailRegex.hasMatch(value)) {
            return 'Por favor, insira um e-mail válido';
          }
        case 'password':
          if (value.length <= 7) {
            return 'Use uma senha mais forte';
          }
        case 'name':
          if (value.length <= 3) {
            return 'Nome muito curto, tente outro';
          } else if (value.length >= 20) {
            return 'Nome muito longo, tente outro';
          }
      }
    }
    return null;
  }

  static String capitalize(String string) {
    String r = '';
    List<String> split = string.split(' ');
    for (var item in split) {
      r = '$r ${item[0].toUpperCase() + item.substring(1, item.length)}';
    }
    return r;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  buttonSheetOptions(BuildContext context, {void Function()? onVisible}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(0),
        onVisible: onVisible,
        duration: Duration(minutes: 5),
        content: Container(
          decoration: BoxDecoration(
            color: AppColors.foo,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.1),
          ),
          child: Column(
            children:
                _setListTiles(context)
                    .map(
                      (Map<String, dynamic> e) => ListTile(
                        leading: Icon(
                          e['icon'],
                          color: AppColors.whiteColor,
                          size: 23,
                        ),
                        title: Text(
                          e['title'],
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          e['subtitle'],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyColor,
                          ),
                        ),

                        onTap: e['onTap'],
                      ),
                    )
                    .toList(),
          ),
        ),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }

  static void goNamedRoute(BuildContext context, {required String route}) {
    Navigator.of(context).pushNamed(route);
  }

  //static void routeScreen(BuildContext context, {required Widget route}) {
  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => route));
  //}

  static String get time {
    DateTime dateTime = DateTime.now();
    String dateFormat = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    return dateFormat;
  }

  static ScaffoldFeatureController showErrorMessageFloating({
    required BuildContext context,
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: MediaQuery.of(context).size.width * .6,
        backgroundColor: Colors.transparent,

        content: Container(
          height: 55,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF34384F),
            borderRadius: AppStyle.borderRadius12,
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.clip,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
  }

  static Map<String, dynamic> firebaseAuthException(String code) {
    switch (code) {
      case 'invalid-email':
        return {
          'imageError': Icons.error,
          'error': 'Invalid email, please try again',
        };
      case 'user-disabled':
        return {
          'imageError': Icons.error,
          'error': 'User disabled, try other credentials.',
        };
      case 'user-not-found':
        return {
          'imageError': Icons.error,
          'Error': 'User not found, try again or try another user',
        };
      case 'wrong-password':
        return {
          'imageError': Icons.error,
          'error': 'Incorrect password, try again.',
        };
      case 'too-many-requests':
        return {
          'imageError': Icons.error,
          'error': 'Too many requests, try again later!',
        };
      case 'user-token-expired':
        return {'imageError': Icons.error, 'error': 'expired token'};
      case 'network-request-failed':
        return {
          'imageError': Icons.error,
          'error':
              'connection error, it looks bad, wait a while and try again later',
        };
      case 'invalid-credential':
        return {
          'imageError': Icons.error,
          'error': 'Invalid credentials, try again later',
        };
      case 'operation-not-allowed':
        return {'imageError': Icons.error, 'error': 'Unauthorized operation'};
      case 'email-already-in-use':
        return {
          'imageError': Icons.error,
          'error':
              'This email is already being used, try creating an account using another email',
        };
      case 'weak-password':
        return {
          'imageError': Icons.error,
          'error':
              'Very weak password, for security reasons, try creating a stronger password.',
        };
      default:
        return {'imageError': Icons.error, 'error': 'Erro desconhecido'};
    }
  }

  static List<Map<String, dynamic>> _setListTiles(BuildContext context) {
    return [
      {
        'icon': OctIcons.person,
        'title': 'Perfil',
        'subtitle': 'Altere seu nome ou mude a foto de perfil',
        'onTap': () {},
      },
      {
        'icon': Icons.add_reaction_outlined,
        'title': 'Novos',
        'subtitle': 'Contas recem criadas no Messfy',
        'onTap': () {},
      },
      {
        'icon': EvaIcons.people_outline,
        'title': 'Comunidades',
        'subtitle': 'Diversas comunidade para conversar',
        'onTap': () {},
      },
      {
        'icon': FontAwesome.bug_solid,
        'title': 'Bugs',
        'subtitle': 'Relate algum bug encontrado no Messfy',
        'onTap': () {},
      },
    ];
  }
}
