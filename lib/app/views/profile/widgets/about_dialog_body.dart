import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/shared.dart';

Widget aboutDialogBody(double width, ThemeData theme, BuildContext context) {
  Map infos = {
    "Version de l'App : ".tr(): "0.1.0",
    "Version d'Android : ".tr(): "11+",
    'Dernière Mise en jour : '.tr(): "31 Juillet 2024".tr(),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    info,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: width * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    infos[info],
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: width * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Gap(width * 0.01),
            },
          ],
        ),
      ),
      Gap(width * 0.04),
      Text(
        "Pour plus de détails, visitez :".tr(),
        style: theme.textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
      Gap(width * 0.01),
      GestureDetector(
        onTap: () async {
          const url = 'https://g-losingson.github.io/JifunzApp/';
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          }
        },
        child: Text(
          "jifunzapp.com",
          style: theme.textTheme.bodySmall!.copyWith(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Gap(width * 0.05),
      socialmediaView(width, theme, context),
      const CustomFooter(),
    ],
  );
}
