import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';
import 'addition_functions.dart';

class SecondBodyBottomView extends StatelessWidget {
  final UserDataController user;
  final TuyauController tuyau;
  final String fileSize;
  final bool isPDF;
  const SecondBodyBottomView({
    super.key,
    required this.user,
    required this.tuyau,
    required this.isPDF,
    required this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(
        top: width * 0.05,
        left: width * 0.1,
        right: width * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Note :',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: width * 0.03),
              ),
              Gap(width * 0.01),
              Expanded(
                child: Text(
                  "Si aucun cours n'est retrouvé pour une promotion ce qu'il n'y a pas encore des données de cette faculté et promotion.\nMerci de contacter le concepteur pour plus d'infos."
                      .tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: width * 0.025),
                ),
              ),
              Gap(width * 0.15),
            ],
          ),
          Gap(width * 0.03),
          GestureDetector(
            onTap: () async {
              if (tuyau.facValue != null &&
                  tuyau.promoValue != null &&
                  tuyau.titleValue != null &&
                  tuyau.yearValue != null &&
                  tuyau.sessionValue != null &&
                  tuyau.serieValue != null &&
                  tuyau.suiteValue != null) {
                await uploadFileToDB(
                  user: user,
                  tuyau: tuyau,
                  isPDF: isPDF,
                  context: context,
                  fileSize: fileSize,
                );
              } else {
                myCustomSnackBar(
                  context: context,
                  text: "Veuillez compléter toutes les infos",
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: tuyau.isUploading
                  ? SizedBox(
                      width: width * 0.05,
                      height: width * 0.05,
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        ),
                        backgroundColor: Colors.transparent,
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 1,
                      ),
                    )
                  : Icon(
                      AppIcons.upload,
                      color: AppColors.tdBlack,
                      size: width * 0.04,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
