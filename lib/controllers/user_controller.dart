import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/shared/shared.dart';
import '../data/data.dart';

class UserDataController extends ChangeNotifier {
  final _prefs = SharedPreferences.getInstance();

  String? _name;
  String? _email;
  String? _imgUrl;
  String? _univ;
  String? _fac;
  String? _promo;
  String? _fcmToken;
  List _courses = [];
  bool _isLoggedIn = false;
  bool _isRegister = false;

  // Getters
  String? get name => _name;
  String? get email => _email;
  String? get imgUrl => _imgUrl;
  String? get univ => _univ;
  String? get fac => _fac;
  String? get promo => _promo;
  String? get fcmToken => _fcmToken;
  List? get courses => _courses;
  bool get isLoggedIn => _isLoggedIn;
  bool get isRegister => _isRegister;

  Future<void> loadUserData() async {
    final prefs = await _prefs;
    _name = prefs.getString('userName');
    _email = prefs.getString('userEmail');
    _imgUrl = prefs.getString('userImgUrl');
    _univ = prefs.getString('userUniv');
    _fac = prefs.getString('userFac');
    _promo = prefs.getString('userPromo');
    _fcmToken = prefs.getString('userFCMToken');
    _courses = prefs.getStringList('userCourses') ?? [];
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _isRegister = prefs.getBool('isRegister') ?? false;
    debugPrint('======================= $_name succefully loading');
    notifyListeners();
  }

  Future<void> signInUser(context) async {
    try {
      checkConnection(context);
      if (isConnected) {
        final prefs = await _prefs;
        await AuthServices().signInWithGoogle();
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          loadUniversities();
          final oldEmail = prefs.getString('userEmail');
          prefs.setString('userName', user.displayName!);
          prefs.setString('userEmail', user.email!);
          prefs.setString('userImgUrl', user.photoURL!);
          prefs.setBool('isLoggedIn', true);
          _name = user.displayName;
          _email = user.email;
          _imgUrl = user.photoURL;
          _isLoggedIn = true;
          if (oldEmail != user.email) {
            prefs.remove('userUniv');
            prefs.remove('userFac');
            prefs.remove('userPromo');
            prefs.remove('userCourses');
            prefs.setBool('isRegister', false);
            _univ = null;
            _fac = null;
            _promo = null;
            _courses = [];
            _isRegister = false;
          }
          debugPrint('*********** User $_name loggedIn $_isLoggedIn');
        } else {
          myCustomSnackBar(
            context: context,
            text: 'Erreur... Veuillez réessayer',
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> signOutUser() async {
    final prefs = await _prefs;
    await AuthServices().signOut();
    prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    notifyListeners();
    debugPrint('*********** User is signOut $_isLoggedIn');
  }

  List universities = [];
  List facs = [];
  List promos = [];

  Future<void> loadUniversities() async {
    universities = await FireStoreServices().appDataStream(
      univID: 'univ',
      filter: 'universities',
    );
    notifyListeners();
  }

  bool emptyFacValue = false;
  bool emptyPromoValue = false;

  Future<void> onUnivValueSelected(value, context) async {
    _fac = null;
    _promo = null;
    _univ = value;
    await loadFaculties(
      univID: value,
      context: context,
    );
    notifyListeners();
  }

  Future<void> onFacValueSelected(value, context) async {
    _promo = null;
    _fac = value;
    await loadPromotions(
      facID: value,
      univID: _univ,
      context: context,
    );
    notifyListeners();
  }

  Future<void> onPromoValueSelected(value) async {
    _promo = value;
    notifyListeners();
  }

  Future<void> loadFaculties({univID, context}) async {
    try {
      facs = await FireStoreServices().appDataStream(
        univID: univID,
        filter: 'facs',
      );
      if (facs.isEmpty) emptyPromoValue = true;
    } catch (e) {
      _fac = null;
      emptyPromoValue = true;
      debugPrint(e.toString());
      myCustomSnackBar(
        context: context,
        text: 'Pas des données pour cette information',
      );
    }
    notifyListeners();
  }

  Future<void> loadPromotions({univID, facID, context}) async {
    try {
      promos = await FireStoreServices().appDataStream(
        univID: univID,
        facID: facID,
        filter: 'promos',
      );
    } catch (e) {
      _promo = null;
      debugPrint(e.toString());
      myCustomSnackBar(
        context: context,
        text: 'Pas des données pour cette information',
      );
    }
    notifyListeners();
  }

  bool coursesIsLoading = false;
  bool coursesError = false;

  Future<void> loadCoursesData({
    univID,
    facID,
    promoID,
    context,
  }) async {
    try {
      coursesIsLoading = true;
      coursesError = false;
      _courses = await FireStoreServices().coursesDataStream(
        univID: univID,
        facID: facID,
        promoID: promoID,
      );
      if (_courses.isEmpty) {
        myCustomSnackBar(
          context: context,
          text: 'Pas des données pour cette information',
        );
      }
      coursesIsLoading = false;
    } catch (e) {
      coursesIsLoading = false;
      coursesError = true;
      debugPrint(e.toString());
      myCustomSnackBar(
        context: context,
        text: 'Pas des données pour cette information',
      );
    }
    notifyListeners();
  }

  bool isRegisterUser = false;

  Future<void> registerUser(UserModel user) async {
    isRegisterUser = true;
    final stringList = user.courses.map((item) => item.toString()).toList();
    final prefs = await _prefs;
    await FireStoreServices().registerUser(user);
    prefs.setString('userUniv', user.univ!);
    prefs.setString('userFac', user.fac!);
    prefs.setString('userPromo', user.promo!);
    prefs.setStringList('userCourses', stringList);
    prefs.setBool('isRegister', true);
    _univ = user.univ;
    _fac = user.fac;
    _promo = user.promo;
    _courses = user.courses;
    _isRegister = true;
    await loadUserData();
    isRegisterUser = false;
    debugPrint('================== isRegister ? $_isRegister');
    notifyListeners();
  }

  Future<void> updatedUserInfo({
    context,
    userUniv,
    userFac,
    userPromo,
    List? userCourses,
  }) async {
    await checkConnection(context);
    if (isConnected) {
      try {
        isRegisterUser = true;
        final stringList = userCourses!.map((item) => item.toString()).toList();
        final prefs = await _prefs;
        await FireStoreServices().updateUserInfo(
          docID: email,
          userUniv: userUniv,
          userFac: userFac,
          userPromo: userPromo,
          userCourses: userCourses,
        );
        prefs.setString('userUniv', userUniv);
        prefs.setString('userFac', userFac);
        prefs.setString('userPromo', userPromo);
        prefs.setStringList('userCourses', stringList);
        _univ = userUniv;
        _fac = userFac;
        _promo = userPromo;
        _courses = stringList;
        await loadUserData();
        myCustomSnackBar(
          context: context,
          text: "Infos mises en jour avec succès",
        );
        Navigator.pop(context);
        isRegisterUser = false;
      } catch (e) {
        isRegisterUser = false;
        debugPrint(e.toString());
        myCustomSnackBar(
          context: context,
          text: "Erreur lors de mise en jour",
        );
      }
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
      myCustomSnackBar(
        context: context,
        text: "Erreur... Vérifie ta connexion",
      );
    }
    notifyListeners();
  }
}
