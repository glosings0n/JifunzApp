import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget cancelDialogView(context, width) {
  return SimpleDialog(
    alignment: Alignment.center,
    backgroundColor: Theme.of(context).highlightColor,
    contentPadding: EdgeInsets.all(width * 0.05),
    children: [
      Text(
        'Traitement en cours ...'.tr(),
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontSize: width * 0.025),
        textAlign: TextAlign.center,
      ),
      Gap(width * 0.03),
      Text(
        "Veux-tu annuler l'ajout du document ?".tr(),
        style: TextStyle(fontSize: width * 0.03),
        textAlign: TextAlign.center,
      ),
      Gap(width * 0.03),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context, false),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.025,
                vertical: width * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Annuler'.tr(),
                style: TextStyle(fontSize: width * 0.02),
              ),
            ),
          ),
          Gap(width * 0.02),
          GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.025,
                vertical: width * 0.02,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                  style: BorderStyle.solid,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Confirmer'.tr(),
                style: TextStyle(fontSize: width * 0.02),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
