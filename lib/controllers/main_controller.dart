import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

class MainController extends ChangeNotifier {
  int updateCount = 0;
  Future<void> checkUpdates() async {
    final query = await FirebaseFirestore.instance
        .collection('appdata')
        .doc('update')
        .get();
    final doc = query.data();
    doc != null ? updateCount = doc['count'] : updateCount = 0;
  }

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
    String? phoneInfo;
    checkConnection(context);
    if (isConnected) {
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

  int? _filter;
  int? get filter => _filter;
  bool filterEmpty = false;

  Future<void> filterCourses({
    int? i,
    String? userUniv,
    userFac,
    userPromo,
  }) async {
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
              .orderBy('time', descending: true)
              .limit(30)
              .snapshots()
          : query
              .where('title', isEqualTo: courses![_filter!])
              .orderBy('time', descending: true)
              .limit(30)
              .snapshots();
      // .startAfterDocument(_lastDocument!)
    } else {
      return _lastDocument == null
          ? query.orderBy('time', descending: true).limit(30).snapshots()
          : query.orderBy('time', descending: true).limit(30).snapshots();
      // .startAfterDocument(_lastDocument!)
    }
  }

  bool isLoading = false;

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

  bool isConnected = false;

  Future<void> checkConnection(context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      myCustomSnackBar(
        context: context,
        text: "Erreur... Vérifie ta connexion",
      );
    }
    notifyListeners();
  }
}
