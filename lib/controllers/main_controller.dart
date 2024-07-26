import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

class MainController extends ChangeNotifier {
  bool _isDark = false;
  bool _isSignInLoading = false;
  Locale locale = const Locale('fr', 'FR');

  bool get isDark => _isDark;
  bool get isSignInLoading => _isSignInLoading;

  int index = 0;

  void navigationController(int i) {
    index = i;
    notifyListeners();
  }

  int maxColumnCount = 2;

  void gridDoubleTap() {
    if (maxColumnCount == 4) {
      maxColumnCount = 2;
    } else {
      maxColumnCount++;
    }
    notifyListeners();
  }

  void startSignIn() {
    _isSignInLoading = !_isSignInLoading;
    notifyListeners();
  }

  Future<void> sendFeedback({
    BuildContext? context,
    String? name,
    String? email,
    String? content,
  }) async {
    try {
      String? phoneInfo;
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        final deviceInfo = DeviceInfoPlugin();
        if (defaultTargetPlatform == TargetPlatform.android) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          phoneInfo = androidInfo.model;
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          phoneInfo = iosInfo.model;
        }
        await FireStoreServices().addFeedBack(
          FeedBackModel(
            userName: name!,
            userMail: email!,
            content: content,
            userPhoneType: phoneInfo,
          ),
        );
        myCustomSnackBar(
          context: context,
          text: 'Merci pour votre feedback',
        );
      }
    } on SocketException catch (_) {
      myCustomSnackBar(
        context: context,
        text: "Erreur... Vérifie ta connexion",
      );
    }
    notifyListeners();
  }

  void changeThemeMode({bool? darkMode}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (darkMode != null) {
      _isDark = darkMode;
    } else {
      _isDark = !isDark;
      sharedPreferences.setBool('isDark', isDark);
    }
    debugPrint('************ Theme = $_isDark');
    notifyListeners();
  }

  void changeLanguages(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('fr', 'FR')) {
      // ignore: deprecated_member_use
      context.locale = const Locale('en', 'US');
    } else {
      // ignore: deprecated_member_use
      context.locale = const Locale('fr', 'FR');
    }
    notifyListeners();
  }

  bool isConnected = false;

  Future<void> checkConnection(context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    notifyListeners();
  }

  int? _filter;
  int? get filter => _filter;

  void filterCourses(int i) {
    _filter != i ? _filter = i : _filter = null;
    notifyListeners();
  }

  DocumentSnapshot<Object?>? _lastDocument;
  bool streamError = false;
  bool docExist = true;

  Stream<QuerySnapshot<Map<String, dynamic>>> buildStream({
    String? userUniv,
    String? userFac,
    String? userPromo,
    List? courses,
  }) {
    final query = FirebaseFirestore.instance
        .collection('appdata')
        .doc('$userUniv')
        .collection('facs')
        .doc('$userFac')
        .collection('courses')
        .doc('$userPromo')
        .collection('tuyaux');
        
    if (_filter != null) {
      return _lastDocument == null
          ? query
              .where('title', isEqualTo: courses![_filter!])
              .orderBy('title')
              .limit(10)
              .snapshots()
          : query
              .where('title', isEqualTo: courses![_filter!])
              .orderBy('title')
              .startAfterDocument(_lastDocument!)
              .limit(10)
              .snapshots();
    } else {
      return _lastDocument == null
          ? query.orderBy('title').limit(10).snapshots()
          : query
              .orderBy('title')
              .startAfterDocument(_lastDocument!)
              .limit(10) // Limit to 10 documents per page
              .snapshots();
    }
  }

  bool? isLoading;

  void loadMore() {
    isLoading = true;
    buildStream().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      } else {
        // No more documents to load
      }
      isLoading = false;
    });
  }
}
