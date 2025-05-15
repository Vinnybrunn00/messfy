import 'dart:io';

import 'package:flutter/material.dart';

ValueNotifier<bool> isMobile = ValueNotifier<bool>(Platform.isAndroid);

RegExp emailRegex = RegExp(r'^[\w-.]+@([\w-]+.)+[\w-]{2,}(?:\s+)?$');

ValueNotifier<bool> event = ValueNotifier<bool>(false);
ValueNotifier<bool> snackBarClose = ValueNotifier<bool>(true);

ValueNotifier<bool> onVisibled = ValueNotifier<bool>(false);
