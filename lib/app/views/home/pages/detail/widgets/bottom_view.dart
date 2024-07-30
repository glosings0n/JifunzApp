import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../../../../controllers/controllers.dart';
import '../../../../../../data/data.dart';
import '../../../../../shared/shared.dart';

class BottomView extends StatelessWidget {
  final int index;
  final String userName;
  final String userEmail;
  final TuyauxModel tuyauModel;
  final ScrollController scrollController;
  const BottomView({
    super.key,
    required this.index,
    required this.userName,
    required this.userEmail,
    required this.tuyauModel,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final tuyau = Provider.of<TuyauController>(context);
    List icons = [
      Clarity.share_line,
      Clarity.download_line,
      Iconsax.warning_2_outline,
    ];

    List<String> legendes = [
      "Partager",
      "Télécharger",
      "Signaler",
    ];

    dynamic reportContent;
    final ref = FirebaseStorage.instance.refFromURL(tuyauModel.imgUrl);
    return SizedBox(
      height: width * 0.15,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          icons.length,
          (index) => GestureDetector(
            onTap: () {
              index == 0
                  ? shareFile(
                      context,
                      ref: ref,
                      tuyauID: tuyauModel.tuyauID,
                      isPDF: tuyauModel.isPDF,
                    )
                  : index == 1
                      ? downLoadFile(
                          context,
                          ref: ref,
                          tuyauID: tuyauModel.tuyauID,
                          isPDF: tuyauModel.isPDF,
                        )
                      : index == 2
                          ? showDialog(
                              context: context,
                              builder: (dialogContext) => customDialogView(
                                dialogContext,
                                title: 'Signaler',
                                hintText:
                                    'Faites nous savoir les soucis du doc ...',
                                onChanged: (value) => reportContent = value,
                                onTap: () {
                                  tuyau.sendReport(
                                    context: context,
                                    authorName: tuyauModel.authorName,
                                    authorEmail: tuyauModel.authorEmail,
                                    reporterName: userName,
                                    reporterEmail: userEmail,
                                    reportContent: reportContent,
                                    tuyauID: tuyauModel.tuyauID,
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          : myCustomSnackBar(
                              context: context,
                              text: 'Fonctionnalité non disponible',
                            );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icons[index]),
                  Text(
                    legendes[index].tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: width * 0.02,
                          height: 2.5,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> downLoadFile(
    context, {
    Reference? ref,
    String? tuyauID,
    bool? isPDF,
  }) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        try {
          myCustomSnackBar(context: context, text: 'Téléchargement ...');
          final directory = await getDownloadsDirectory();
          final url = await ref!.getDownloadURL();
          final response = await http.readBytes(Uri.parse(url));
          isPDF!
              ? await FilePicker.platform.saveFile(
                  allowedExtensions: ['pdf'],
                  bytes: response,
                  fileName: tuyauID,
                  initialDirectory: '${directory!.path}/$tuyauID.pdf',
                  type: FileType.any,
                )
              : await ImageGallerySaver.saveImage(
                  response,
                  quality: 60,
                  name: tuyauID,
                );
          myCustomSnackBar(context: context, text: 'Téléchargé avec succès');
        } on FirebaseException catch (_) {
          myCustomSnackBar(
            context: context,
            text: "Impossible de télécharger l'image pour l'instant",
          );
        }
      }
    } on SocketException catch (_) {
      myCustomSnackBar(
        context: context,
        text: "Erreur... Vérifie ta connexion",
      );
    }
  }

  Future<void> shareFile(
    context, {
    Reference? ref,
    String? tuyauID,
    bool? isPDF,
  }) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        try {
          try {
            myCustomSnackBar(context: context, text: 'Partage ...');
            final url = await ref!.getDownloadURL();
            final directory = (await getApplicationDocumentsDirectory()).path;
            final response = await http.readBytes(Uri.parse(url));
            final file = isPDF!
                ? await File('$directory/$tuyauID.pdf').create()
                : await File('$directory/$tuyauID.png').create();
            file.writeAsBytes(response);
            try {
              final result = await Share.shareXFiles(
                [XFile(file.path)],
                text: isPDF
                    ? "Je te partage ce doc pour ton apprentissage depuis Jifunz'App"
                        .tr()
                    : "Je te partage cette image pour ton apprentissage depuis Jifunz'App"
                        .tr(),
              );
              if (result.status == ShareResultStatus.success) {
              } else if (result.status == ShareResultStatus.dismissed) {}
            } catch (e) {
              debugPrint('Erreur lors de partage : $e');
            }
          } catch (e) {
            debugPrint('Erreur lors de partage : $e');
          }
        } on FirebaseException catch (_) {
          myCustomSnackBar(
            context: context,
            text: isPDF!
                ? "Impossible de partager le doc pour l'instant"
                : "Impossible de partager l'image pour l'instant",
          );
        }
      }
    } on SocketException catch (_) {
      myCustomSnackBar(
        context: context,
        text: "Erreur... Vérifie ta connexion",
      );
    }
  }
}
