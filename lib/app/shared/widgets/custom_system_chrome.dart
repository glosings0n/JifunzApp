import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controllers/controllers.dart';
import '../shared.dart';

oCustomSystemChrome(context, MainController mainController) {
  return SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          mainController.isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          mainController.isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          mainController.isDark ? AppColors.tdBlackO : AppColors.tdWhiteO,
    ),
  );
}

lightCustomSystemChrome(context, MainController mainController) {
  return SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: mainController.isDark ? Colors.black : AppColors.tdWhite,
      statusBarIconBrightness:
          mainController.isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          mainController.isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          mainController.isDark ? Colors.black : AppColors.tdWhite,
    ),
  );
}

welcomCustomSystemChrome() {
  return SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.tdBlack,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.tdBlack,
    ),
  );
}
