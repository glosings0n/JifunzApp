import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget customDialogView(
  context, {
  dynamic title,
  hintText,
  onTap,
  onChanged,
}) {
  return SimpleDialog(
    alignment: Alignment.center,
    backgroundColor: Theme.of(context).highlightColor,
    children: [
      Padding(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.04),
        child: Column(
          children: [
            Text("$title".tr()),
            TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: MediaQuery.sizeOf(context).width * 0.025),
              cursorColor: Theme.of(context).primaryColorDark,
              cursorWidth: 1,
              maxLines: null,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "$hintText".tr(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                    style: BorderStyle.solid,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            Gap(MediaQuery.sizeOf(context).width * 0.03),
            bottomDialogButtonView(
              context: context,
              onTap: onTap,
              confirmText: 'Envoyer',
            ),
          ],
        ),
      ),
    ],
  );
}

Row bottomDialogButtonView({context, onTap, confirmText}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.025,
            vertical: MediaQuery.sizeOf(context).width * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            'Annuler'.tr(),
            style: TextStyle(fontSize: MediaQuery.sizeOf(context).width * 0.02),
          ),
        ),
      ),
      Gap(MediaQuery.sizeOf(context).width * 0.02),
      GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).width * 0.02,
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
            '$confirmText'.tr(),
            style: TextStyle(fontSize: MediaQuery.sizeOf(context).width * 0.02),
          ),
        ),
      ),
    ],
  );
}
