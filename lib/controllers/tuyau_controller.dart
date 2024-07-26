import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../app/shared/shared.dart';
import '../app/views/views.dart';
import '../data/data.dart';
import 'controllers.dart';

class TuyauController extends ChangeNotifier {
  dynamic facValue,
      promoValue,
      titleValue,
      yearValue,
      sessionValue,
      serieValue,
      suiteValue;

  List facs = [];
  List promos = [];
  List coursesData = [];

  Future<void> onFacValueChanged({
    context,
    value,
    UserDataController? user,
  }) async {
    promoValue = null;
    titleValue = null;
    yearValue = null;
    sessionValue = null;
    serieValue = null;
    suiteValue = null;
    facValue = value;
    await loadPromotions(
      facID: value,
      univID: user!.univ,
      context: context,
    );
    notifyListeners();
  }

  Future<void> onPromoValueChanged({
    context,
    value,
    UserDataController? user,
  }) async {
    titleValue = null;
    yearValue = null;
    sessionValue = null;
    serieValue = null;
    suiteValue = null;
    promoValue = value;
    await loadCoursesData(
      univID: user!.univ,
      facID: facValue,
      promoID: value,
      context: context,
    );
    notifyListeners();
  }

  void onTitleValueChanged(value) {
    titleValue = value;
    notifyListeners();
  }

  void onYearValueChanged(value) {
    yearValue = value;
    notifyListeners();
  }

  void onSessionValueChanged(value) {
    sessionValue = value;
    notifyListeners();
  }

  void onSerieValueChanged(value) {
    serieValue = value;
    notifyListeners();
  }

  void onSuiteValueChanged(value) {
    suiteValue = value;
    notifyListeners();
  }

  bool isUploading = false;
  void uploadTaskBehavior() {
    isUploading = !isUploading;
    notifyListeners();
  }

  double progressValue = 5.0;
  uploadTaskProgress(double progress) {
    progressValue = progress;
    notifyListeners();
  }

  bool timeOut = false;
  void timeIsOut() {
    timeOut = !timeOut;
    notifyListeners();
  }

  Future<void> loadFaculties({univID, context}) async {
    try {
      facs = await FireStoreServices().appDataStream(
        univID: univID,
        filter: 'facs',
      );
    } catch (e) {
      facValue = null;
      debugPrint(e.toString());
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
      promoValue = null;
      debugPrint(e.toString());
      myCustomSnackBar(
        context: context,
        text: 'Pas des données pour cette information',
      );
    }
    notifyListeners();
  }

  bool coursesError = false;

  Future<void> loadCoursesData({
    univID,
    facID,
    promoID,
    context,
  }) async {
    try {
      coursesData = await FireStoreServices().coursesDataStream(
        univID: univID,
        facID: facID,
        promoID: promoID,
      );
      if (coursesData.isEmpty) {
        myCustomSnackBar(
          context: context,
          text: 'Pas des données pour cette information',
        );
      }
    } catch (e) {
      coursesError = true;
      debugPrint(e.toString());
      myCustomSnackBar(
        context: context,
        text: 'Pas des données pour cette information',
      );
    }
    notifyListeners();
  }

  void sendReport(
      {context,
      reporterName,
      reporterEmail,
      authorName,
      authorEmail,
      reportContent,
      tuyauID,
      tuyauInfo}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        await FireStoreServices().addReport(
          ReportModel(
            reporterName: reporterName,
            reporterEmail: reporterEmail,
            authorName: authorName,
            authorEmail: authorEmail,
            reportContent: reportContent,
            tuyauID: tuyauID,
          ),
        );

        myCustomSnackBar(
          context: context,
          text: 'Merci pour le signal',
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

  File? selectedFile;

  Future pickImgFromGallery(context, UserDataController user) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.media);
      if (result != null) {
        final size = result.files.first.size;
        final fileName = result.files.first.name;
        final value = size / 1024;
        String fixedValue = value.toStringAsFixed(1);
        final extension = result.files.first.extension;
        if (extension == 'png' || extension == 'jpg' || extension == 'jpeg') {
          if (size > 2500000) {
            myCustomSnackBar(
              context: context,
              text: "Fichier volumineux > 2Mb",
            );
            Navigator.pop(context);
          } else {
            try {
              final file = result.files.first;
              selectedFile = File(file.path!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdditionPage(
                    user: user,
                    isPDF: false,
                    fileName: fileName,
                    fileSize: fixedValue,
                  ),
                ),
              );
            } catch (e) {
              await FilePicker.platform.clearTemporaryFiles();
              myCustomSnackBar(
                context: context,
                text: "Impossible d'ajouter l'image, réessayer plus tard",
              );
            }
          }
        } else {
          myCustomSnackBar(
            context: context,
            text: "Veuillez sélectionner une image (jpg, jpeg ou png)",
          );
        }
      }
    } catch (e) {
      myCustomSnackBar(
        context: context,
        text: "Impossible d'ajouter l'image, veuillez réessayer",
      );
      await FilePicker.platform.clearTemporaryFiles();
      Navigator.pop(context);
    }
    notifyListeners();
  }

  Future pickFile(context, UserDataController user) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null) {
        final size = result.files.first.size;
        final fileName = result.files.first.name;
        final value = size / 1024;
        String fixedValue = value.toStringAsFixed(1);
        final extension = result.files.first.extension;
        if (extension == 'pdf') {
          if (size > 2500000) {
            myCustomSnackBar(
              context: context,
              text: "Fichier volumineux > 2Mb",
            );
            Navigator.pop(context);
          } else {
            try {
              final file = result.files.first;
              selectedFile = File(file.path!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdditionPage(
                    user: user,
                    isPDF: true,
                    fileName: fileName,
                    fileSize: fixedValue,
                  ),
                ),
              );
            } catch (e) {
              myCustomSnackBar(
                context: context,
                text: "Impossible d'ajouter le doc, réessayer plus tard",
              );
            }
          }
        } else {
          myCustomSnackBar(
            context: context,
            text: "Veuillez sélectionner un fichier pdf",
          );
        }
      }
    } catch (e) {
      myCustomSnackBar(
        context: context,
        text: "Impossible d'ajouter le doc, veuillez réessayer",
      );
      await FilePicker.platform.clearTemporaryFiles();
      Navigator.pop(context);
    }
    notifyListeners();
  }
}
