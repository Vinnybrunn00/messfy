

import 'package:flutter/material.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/constants/constants_value.dart';
import 'package:messfy/screens/chats_screen.dart';
import 'package:messfy/screens/friends_screen.dart';
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

  bool onVisible = false;

  late PageController pageController = PageController(initialPage: page);

  bool selectedd = false;

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
        actions: [BoxPhoto()],
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
                setState(() {
                  onVisible = false;
                });
              });
            } else {
              _switch();
              Utils.buttonSheetOptions(
                context,
                onVisible: () {
                  setState(() {
                    onVisible = true;
                  });
                },
              ).closed.then((SnackBarClosedReason event) {
                if (event.name == 'swipe') {
                  setState(() {
                    onVisible = false;
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
                      onVisible
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
