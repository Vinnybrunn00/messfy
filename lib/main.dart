import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messfy/constants/constants_colors.dart';
import 'package:messfy/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messfy/utils/utils.dart';
import 'package:window_manager/window_manager.dart';
import 'firebase_options.dart';
import 'utils/routers.dart';

void main() async {
  if (!Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.windows);
    await windowManager.ensureInitialized();

    Size size = Size(700, 700);

    WindowOptions windowOptions = WindowOptions(
      center: true,
      minimumSize: size,
      maximumSize: size,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    runApp(const MyApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.blackBlueColor,
      ), // const Color(0x13D2D2D2),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messfy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoute.node,
      routes: {
        AppRoute.node: (context) => Utils.chooseRoute(context),
        AppRoute.home: (context) => HomePage(),
      },
    );
  }
}
