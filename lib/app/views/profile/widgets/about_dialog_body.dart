import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../shared/shared.dart';

Widget aboutDialogBody(double width, ThemeData theme, BuildContext context) {
  Map infos = {
    "Version de l'App : ".tr(): "1.0.1",
    "Version d'Android : ".tr(): "11+",
    'Dernière Mise en jour : '.tr(): "23 Juillet 2024".tr(),
  };
  return Column(
    children: [
      Gap(width * 0.05),
      SizedBox(
        width: width * 0.2,
        height: width * 0.2,
        child: Image.asset(AppImages.logo),
      ),
      Gap(width * 0.02),
      Text(
        "Jifunz'App",
        style: theme.textTheme.displaySmall!.copyWith(fontSize: width * 0.04),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(width * 0.03),
            Text(
              "Une app conçue dans l'idée d'aider les collègues étudiants à optimiser leurs études, révisions, exercices, ...\nEn regroupant un ensemble des anciens questionnaires d'examens, d'interrogations, de TP, ..."
                  .tr(),
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            Gap(width * 0.05),
            for (String info in infos.keys) ...{
              Row(
                children: [
                  Text(
                    info,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: width * 0.02,
                    ),
                  ),
                  Text(
                    infos[info],
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: width * 0.02,
                    ),
                  ),
                ],
              ),
              Gap(width * 0.01),
            },
          ],
        ),
      ),
      const CustomFooter(),
      socialmediaView(width, theme, context),
      Gap(width * 0.05),
    ],
  );
}
