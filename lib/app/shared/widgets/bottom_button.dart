import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../shared.dart';

Container bottomButton(String text, {width, color, txtColor, icon}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: width * 0.05),
    height: width * 0.12,
    width: width,
    decoration: color != null
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: color,
          )
        : BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppColors.tdWhiteO,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
    child: icon == null
        ? Text(
            text.tr(),
            style: TextStyle(
              color: txtColor,
              fontSize: width * 0.025,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Gap(width * 0.02),
              Text(
                text.tr(),
                style: TextStyle(
                  color: txtColor,
                  fontSize: width * 0.025,
                ),
              ),
            ],
          ),
  );
}
