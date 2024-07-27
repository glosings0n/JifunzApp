import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../../data/data.dart';
import '../../../../shared/shared.dart';
import 'widgets/infodialog_view.dart';

class DetailsPage extends StatelessWidget {
  final TuyauxModel tuyau;
  final int index;
  const DetailsPage({
    super.key,
    required this.index,
    required this.tuyau,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataController>(context);
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.highlightColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          tuyau.tuyauID,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
        actions: [
          if (user.email == 'georgesbyona@gmail.com') ...{
            GestureDetector(
              onTap: () async {
                try {
                  mySnackBar(
                    context,
                    "Suppression commencée",
                  );
                  final storage = FirebaseStorage.instance;
                  await storage.refFromURL(tuyau.imgUrl).delete();
                  await FireStoreServices().deleteTuyau(
                    docID: tuyau.tuyauID,
                    univID: tuyau.univ,
                    facID: tuyau.fac,
                    promoID: tuyau.promo,
                  );
                  mySnackBar(
                    context,
                    "Fichier supprimé avec succès",
                  );
                } catch (e) {
                  mySnackBar(
                    context,
                    "Erreur patiente...",
                  );
                }
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(width * 0.02),
                child: Icon(
                  AppIcons.delete,
                  color: AppColors.tdRed,
                ),
              ),
            ),
          },
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => infoBottomView(
                width: width,
                index: index,
                context: context,
                tuyauModel: tuyau,
                userName: user.name,
                userEmail: user.email,
              ),
            ),
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(width * 0.03),
              child: const Icon(Icons.more_vert_outlined),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: width * 0.2),
            child: tuyau.isPDF
                ? Hero(
                    tag: 'Image $index',
                    child: Container(),
                  )
                : InteractiveViewer(
                    child: Hero(
                      tag: 'Image $index',
                      child: Center(
                        child: SizedBox(
                          width: width,
                          child: CachedNetworkImage(
                            imageUrl: tuyau.imgUrl,
                            progressIndicatorBuilder: (context, url, progress) {
                              return Container(
                                alignment: Alignment.center,
                                width: 15,
                                height: 15,
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(100),
                                  backgroundColor: theme.highlightColor,
                                  color: theme.primaryColor,
                                  value: progress.progress,
                                  minHeight: 2,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) => Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          BottomInfoView(
            index: index,
            tuyauModel: tuyau,
            userName: user.name!,
            userEmail: user.email!,
          ),
        ],
      ),
    );
  }
}
