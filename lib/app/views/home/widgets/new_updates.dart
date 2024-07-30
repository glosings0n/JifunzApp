import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../controllers/controllers.dart';

class NewUpdates extends StatelessWidget {
  final MainController controller;
  final UserDataController user;
  const NewUpdates({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final firstName = user.name!.split(' ')[0];
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.75,
            decoration: BoxDecoration(
              color: theme.highlightColor,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(width * 0.05),
            child: DefaultTextStyle(
              style: GoogleFonts.raleway(
                color: theme.primaryColorLight,
                fontSize: width * 0.03,
                letterSpacing: 1,
                height: 1.5,
              ),
              child: Column(
                children: [
                  Text(
                    'Nouvelle Mise en jour !'.tr(),
                    style: GoogleFonts.raleway(
                      color: theme.primaryColorLight,
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.03,
                      letterSpacing: 1,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(width * 0.02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Salut,'.tr(),
                          style: theme.textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: " $firstName !",
                          style: GoogleFonts.raleway(
                            color: theme.primaryColorLight,
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.03,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Ravi de te revoir une fois de plus.'.tr(),
                    style: theme.textTheme.bodySmall,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sais-tu que'.tr(),
                          style: theme.textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: " Jifunz'App ",
                          style: GoogleFonts.raleway(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.03,
                            letterSpacing: 1,
                          ),
                        ),
                        TextSpan(
                          text:
                              "a une nouvelle mise en jour ! N'hésite pas à la mettre en jour pour profiter des dernières fonctionnalités !"
                                  .tr(),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Gap(width * 0.03),
                  bottomButtonView(width, theme, controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Row bottomButtonView(double width, ThemeData theme, MainController controller) {
  void launchApp(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () => controller.updateCount = 0,
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
            'Ignorer'.tr(),
            style: TextStyle(fontSize: width * 0.02),
          ),
        ),
      ),
      Gap(width * 0.02),
      GestureDetector(
        onTap: () {
          const url = 'https://g-losingson.github.io/JifunzApp/';
          launchApp(url);
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: width * 0.02,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.primaryColorDark,
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            'Mettre en jour'.tr(),
            style: TextStyle(fontSize: width * 0.02),
          ),
        ),
      ),
    ],
  );
}
