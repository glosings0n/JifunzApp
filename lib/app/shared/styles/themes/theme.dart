import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors.dart';
import 'txttheme.dart';

class AppTheme {
  static dynamic lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.tdWhite,
      onPrimary: AppColors.tdWhiteO,
      secondary: AppColors.tdBlack,
      onSecondary: AppColors.tdBlackO,
      error: AppColors.tdRed,
      onError: AppColors.tdRed,
      surface: AppColors.tdWhiteO,
      onSurface: AppColors.tdWhite,
    ),
    primaryColor: AppColors.tdYellow,
    primaryColorDark: AppColors.tdBlackO,
    primaryColorLight: AppColors.tdBlack,
    highlightColor: AppColors.tdWhite,
    scaffoldBackgroundColor: AppColors.tdWhiteO,
    unselectedWidgetColor: AppColors.tdGrey,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: AppColors.tdBlack),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      foregroundColor: AppColors.tdBlack,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.tdWhiteO,
      ),
    ),
    textTheme: TxtTheme.lighttxtTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.tdYellow,
      enableFeedback: false,
      focusColor: AppColors.tdYellow.withOpacity(0.8),
      foregroundColor: AppColors.tdBlack,
      hoverColor: AppColors.tdYellow,
      splashColor: AppColors.tdYellow,
    ),
  );

  static dynamic darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.tdBlack,
      onPrimary: AppColors.tdBlackO,
      secondary: AppColors.tdWhite,
      onSecondary: AppColors.tdWhiteO,
      error: AppColors.tdRed,
      onError: AppColors.tdRed,
      surface: AppColors.tdBlackO,
      onSurface: AppColors.tdBlack,
    ),
    primaryColor: AppColors.tdYellow,
    primaryColorDark: AppColors.tdWhiteO,
    primaryColorLight: AppColors.tdWhite,
    highlightColor: Colors.black,
    scaffoldBackgroundColor: AppColors.tdBlackO,
    unselectedWidgetColor: AppColors.tdGrey,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: AppColors.tdWhite),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      foregroundColor: AppColors.tdWhite,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.tdBlackO,
      ),
    ),
    textTheme: TxtTheme.darktxtTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.tdYellow,
      enableFeedback: false,
      focusColor: AppColors.tdYellow.withOpacity(0.8),
      foregroundColor: AppColors.tdBlack,
      hoverColor: AppColors.tdYellow,
      splashColor: AppColors.tdYellow,
    ),
  );
}
