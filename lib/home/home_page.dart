import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/constants/constants_value.dart';
import 'package:messfy/screens/chats_screen.dart';
import 'package:messfy/screens/friends_screen.dart';
import 'package:messfy/utils/routers.dart';
import 'package:messfy/utils/utils.dart';
import 'package:messfy/widgets/box_photo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isAuth = true;
  int page = 0;

  late PageController pageController = PageController(initialPage: page);

  bool selectedd = false;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buttonSheetOptions(
    BuildContext context, {
    void Function()? onVisible,
    void Function()? onTap,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(0),
        onVisible: onVisible,
        duration: Duration(hours: 2),
        content: Container(
          decoration: BoxDecoration(
            color: AppColors.foo,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.1),
          ),
          child: Column(
            children:
                Utils.setListTiles(context)
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
                        onTap: () {
                          setState(() {
                            onVisibled.value = false;
                          });
                          switch (e['title'].toLowerCase()) {
                            case 'perfil':
                              Utils.hidenSnackBar(context);
                              Utils.goNamedRoute(
                                context,
                                route: AppRoute.profile,
                              );
                            case 'comunidades':
                              Utils.hidenSnackBar(context);
                              Utils.goNamedRoute(
                                context,
                                route: AppRoute.community,
                              );
                            case 'bugs':
                              Utils.hidenSnackBar(context);
                              Utils.goNamedRoute(
                                context,
                                route: AppRoute.reportBug,
                              );
                          }
                        },
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

  void _switch() {
    setState(() {
      event.value = !event.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 10),
        elevation: 2,
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'Messfy',
          style: TextStyle(color: AppColors.cyanColor, fontSize: 16),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: BoxPhoto(),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: PageView(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              page = value;
            });
          },
          children: [ChatsScreen(), FriendsScreen()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 40,
        iconSize: 21,
        selectedIconTheme: IconThemeData(
          size: 23,
          color: AppColors.cyanColor,
          grade: 5,
        ),
        selectedItemColor: AppColors.cyanColor,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        currentIndex: page,
        onTap: (pages) {
          if (pages == 2) {
            if (selectedd) {
              _switch();
              ScaffoldMessenger.of(
                context,
              ).hideCurrentSnackBar(reason: SnackBarClosedReason.timeout);
              setState(() {
                onVisibled.value = false;
              });
            } else {
              _switch();
              buttonSheetOptions(
                context,
                onVisible: () {
                  setState(() {
                    onVisibled.value = true;
                  });
                },
              ).closed.then((SnackBarClosedReason event) {
                if (event.name == 'swipe') {
                  setState(() {
                    onVisibled.value = false;
                  });
                }
              });
            }
          }
          if (pages != 2) {
            pageController.animateToPage(
              pages,
              duration: Duration(milliseconds: 550),
              curve: Curves.ease,
            );
          }
        },
        backgroundColor: Color(0x00ffffff),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.message_circle_outline),
            label: 'Conversas',
            tooltip: 'Conversas',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.person_outline),
            label: 'Amigos',
            tooltip: 'Amigos',
          ),
          BottomNavigationBarItem(
            icon: ValueListenableBuilder(
              valueListenable: event,
              builder: (BuildContext context, selected, _) {
                selectedd = selected;
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child:
                      onVisibled.value
                          ? Icon(Iconsax.add_bulk, key: ValueKey('a'))
                          : Icon(TeenyIcons.add, key: ValueKey('b')),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return ScaleTransition(
                      scale: animation,
                      filterQuality: FilterQuality.high,
                      child: child,
                    );
                  },
                );
              },
            ),
            label: 'Mais',
            tooltip: 'Mais',
          ),
        ],
      ),
    );
  }
}
