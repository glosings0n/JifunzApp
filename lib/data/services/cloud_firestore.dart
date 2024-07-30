// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../controllers/controllers.dart';
import '../data.dart';

class FireStoreServices {
  final _users = FirebaseFirestore.instance.collection('users');
  final _appdata = FirebaseFirestore.instance.collection('appdata');
  final _reports = FirebaseFirestore.instance.collection('reports');
  final _feedbacks = FirebaseFirestore.instance.collection('feedbacks');

  Future<dynamic> appDataStream({univID, facID, filter}) async {
    final appDataDoc = facID != null
        ? _appdata.doc("$univID").collection("facs").doc("$facID")
        : _appdata.doc("$univID");
    final doc = await appDataDoc.get();
    Map<String, dynamic> data = doc.data()!;
    print('********** data ${data["$filter"]} success loading');
    return data['$filter'];
  }

  Future<dynamic> coursesDataStream({univID, facID, promoID}) async {
    final docRef = _appdata
        .doc('$univID')
        .collection("facs")
        .doc("$facID")
        .collection("courses")
        .doc("$promoID");
    final doc = await docRef.get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data['courses'];
  }

  Future<void> registerUser(UserModel user) async {
    await _users.doc(user.email).set({
      "userName": user.name,
      "userEmail": user.email,
      "userImgUrl": user.imgUrl,
      "userUniv": user.univ,
      "userFac": user.fac,
      "userPromo": user.promo,
      "userFCMToken": user.fCMToken,
      "userCourses": user.courses,
      "time": FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserInfo({
    docID,
    userUniv,
    userFac,
    userPromo,
    userCourses,
  }) {
    return _users.doc(docID).update({
      "userUniv": userUniv,
      "userFac": userFac,
      "userPromo": userPromo,
      "userCourses": userCourses,
      "time": FieldValue.serverTimestamp(),
    });
  }

  Future deleteUser(docID) async {
    return await _users.doc(docID).delete();
  }

  Future<String> uploadTuyauxFile({
    context,
    file,
    bool? isPDF,
    String? fileID,
    String? univID,
    String? facID,
    String? promoID,
  }) async {
    final storage = FirebaseStorage.instance;
    Reference reference = isPDF!
        ? storage.ref().child(
            '$univID tuyauxPDF/$facID/$promoID/$fileID ${DateTime.now().millisecondsSinceEpoch}')
        : storage.ref().child(
            '$univID tuyauxImg/$facID/$promoID/$fileID ${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = reference.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  Future addTuyaux(TuyauxModel tuyauxModel, {TuyauController? tuyau}) async {
    await _appdata
        .doc(tuyauxModel.univ)
        .collection("facs")
        .doc(tuyauxModel.fac)
        .collection("courses")
        .doc(tuyauxModel.promo)
        .collection("tuyaux")
        .doc(tuyauxModel.tuyauID)
        .set({
          "tuyauID": tuyauxModel.tuyauID,
          "authorName": tuyauxModel.authorName,
          "authorEmail": tuyauxModel.authorEmail,
          "imgUrl": tuyauxModel.imgUrl,
          "univ": tuyauxModel.univ,
          "fac": tuyauxModel.fac,
          "promo": tuyauxModel.promo,
          "title": tuyauxModel.title,
          "academicyear": tuyauxModel.academicyear,
          "session": tuyauxModel.session,
          "serie": tuyauxModel.serie,
          "size": tuyauxModel.size,
          "suite": tuyauxModel.suite,
          "isPDF": tuyauxModel.isPDF,
          "time": FieldValue.serverTimestamp(),
        })
        .timeout(
          const Duration(seconds: 15),
          onTimeout: () => tuyau!.timeIsOut(),
        )
        .then((value) => tuyau!.timeIsOut())
        .onError((error, stackTrace) => tuyau!.timeIsOut())
        .catchError((_) {
          return null;
        }, test: (error) => true);
  }

  Future<void> deleteTuyau({String? docID, univID, facID, promoID}) async {
    return await _appdata
        .doc("$univID")
        .collection("facs")
        .doc("$facID")
        .collection("courses")
        .doc('$promoID')
        .collection("tuyaux")
        .doc(docID)
        .delete();
  }

  Future<bool> tuyauExists({univID, facID, promoID, tuyauID}) async {
    final query = _appdata
        .doc("$univID")
        .collection("facs")
        .doc("$facID")
        .collection("courses")
        .doc('$promoID')
        .collection("tuyaux")
        .where('tuyauID', isEqualTo: tuyauID);
    final snapshot = await query.get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> addFeedBack(FeedBackModel feedBack) async {
    await _feedbacks.add({
      "userName": feedBack.userName,
      "userMail": feedBack.userMail,
      "content": feedBack.content,
      "userPhoneType": feedBack.userPhoneType,
      "time": FieldValue.serverTimestamp(),
    });
  }

  Future<void> addReport(ReportModel reportModel) async {
    final now = DateTime.now();
    final day = now.day;
    final month = now.month;
    final hour = now.hour;
    final sec = now.second;
    final docID = "${reportModel.tuyauID} $day$month-$hour$sec";
    await _reports.doc(docID).set({
      "authorName": reportModel.authorName,
      "authorEmail": reportModel.authorEmail,
      "reporterName": reportModel.reporterName,
      "reporterEmail": reportModel.reporterEmail,
      "reportContent": reportModel.reportContent,
      "tuyauID": reportModel.tuyauID,
      "time": FieldValue.serverTimestamp(),
    });
  }
}
