import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/controllers.dart';
import 'app/shared/shared.dart';
import 'firebase_options.dart';
import 'app/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isDark = sharedPreferences.getBool('isDark') ?? false;
  await EasyLocalization.ensureInitialized();
  initializeDateFormatting('en_US', null);
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      fallbackLocale: const Locale('fr', 'FR'),
      child: JifunzApp(isDark: isDark),
    ),
  );
}

class JifunzApp extends StatelessWidget {
  final bool isDark;
  const JifunzApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataController()..loadUserData(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainController()
            ..changeThemeMode(darkMode: isDark)
            ..checkConnection(context),
        ),
        ChangeNotifierProvider(
          create: (context) => TuyauController(),
        ),
      ],
      child: Consumer<MainController>(
        builder: (context, mainController, state) {
          return Consumer<UserDataController>(
            builder: (context, userData, child) {
              lightCustomSystemChrome(context, mainController);
              return Consumer<TuyauController>(
                builder: (context, tuyau, child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    title: "Jifunz'App",
                    themeAnimationCurve: Curves.easeInOut,
                    themeAnimationDuration: (const Duration(milliseconds: 500)),
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: mainController.isDark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    home: userData.isLoggedIn
                        ? userData.isRegister
                            ? Wrapper(
                                userData: userData,
                                mainController: mainController,
                                tuyau: tuyau,
                              )
                            : RegisterScreen(
                                userProvider: userData,
                                mainController: mainController,
                              )
                        : Welcome(
                            userProvider: userData,
                            mainProvider: mainController,
                          ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
