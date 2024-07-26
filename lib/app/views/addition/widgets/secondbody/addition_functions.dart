import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../../data/data.dart';
import '../../../../shared/shared.dart';

Future<void> uploadFileToDB({
  context,
  bool? isPDF,
  String? fileSize,
  TuyauController? tuyau,
  UserDataController? user,
}) async {
  try {
    tuyau!.uploadTaskBehavior();
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].address.isNotEmpty) {
      final docID =
          "${tuyau.titleValue}${tuyau.yearValue}${tuyau.sessionValue}${tuyau.serieValue}${tuyau.suiteValue}";
      myCustomSnackBar(
        context: context,
        text: "Préparation...",
      );
      final docExist = await FireStoreServices().tuyauExists(
        univID: user!.univ,
        facID: tuyau.facValue,
        promoID: tuyau.promoValue,
        tuyauID: docID,
      );
      if (docExist) {
        myCustomSnackBar(
          context: context,
          text: "Document existant",
        );
      } else {
        try {
          myCustomSnackBar(
            context: context,
            text: "Début d'ajout... Veuillez patienter",
          );
          final docUrl = await FireStoreServices().uploadTuyauxFile(
            context: context,
            file: tuyau.selectedFile,
            isPDF: isPDF,
            fileID: docID,
            univID: user.univ,
            facID: tuyau.facValue,
            promoID: tuyau.promoValue,
          );
          await FireStoreServices().addTuyaux(
            TuyauxModel(
              tuyauID: docID,
              authorName: user.name!,
              authorEmail: user.email!,
              imgUrl: docUrl,
              univ: user.univ!,
              fac: tuyau.facValue,
              promo: tuyau.promoValue,
              title: tuyau.titleValue,
              academicyear: tuyau.yearValue,
              session: tuyau.sessionValue,
              serie: tuyau.serieValue,
              suite: tuyau.suiteValue,
              size: fileSize,
              isPDF: isPDF!,
            ),
          );
          if (tuyau.timeOut == true) {
            myCustomSnackBar(
              context: context,
              text: "Temps d'ajout épuisé!",
            );
            Future.delayed(const Duration(seconds: 30), () {
              myCustomSnackBar(
                context: context,
                text: "Veuillez vérifier votre connexion et réessayer",
              );
            });
            tuyau.facValue = null;
            tuyau.promoValue = null;
            tuyau.titleValue = null;
            tuyau.yearValue = null;
            tuyau.sessionValue = null;
            tuyau.serieValue = null;
            tuyau.suiteValue = null;
            Navigator.pop(context);
          } else {
            tuyau.facValue = null;
            tuyau.promoValue = null;
            tuyau.titleValue = null;
            tuyau.yearValue = null;
            tuyau.sessionValue = null;
            tuyau.serieValue = null;
            tuyau.suiteValue = null;
            myCustomSnackBar(
              context: context,
              text: "Merci pour l'ajout",
            );
            Navigator.pop(context);
          }
        } on FirebaseException catch (e) {
          debugPrint(e.toString());
          myCustomSnackBar(
            context: context,
            text: "Impossible d'ajouter l'image, réessayer plus tard",
          );
        }
      }
    }
    tuyau.uploadTaskBehavior();
  } on SocketException catch (_) {
    myCustomSnackBar(
      context: context,
      text: "Erreur... Vérifie ta connexion",
    );
    tuyau!.uploadTaskBehavior();
  }
}
