import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import '../pages/confidentiality/confidentiality.dart';
import 'about_dialog_body.dart';

class ProfileBottomView extends StatelessWidget {
  final MainController controller;
  final UserDataController user;
  const ProfileBottomView({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    List<String> titles = [
      'Termes & Conditions',
      'Aide & Feedback',
      'A propos',
    ];
    List icons = [
      AppIcons.privacy,
      AppIcons.help,
      AppIcons.about,
    ];
    List iconsSuff = [
      Iconsax.arrow_right_3_outline,
      Iconsax.message_question_outline,
      Clarity.devices_line,
    ];
    dynamic content;
    final bool french;
    (EasyLocalization.of(context)!.locale == const Locale('fr', 'FR'))
        ? french = true
        : french = false;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      decoration: BoxDecoration(
        color: theme.highlightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(width * 0.05),
          for (int i = 0; i < titles.length; i++) ...{
            GestureDetector(
              onTap: () {
                if (i == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfidentialityPage(),
                    ),
                  );
                } else if (i == 1) {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => customDialogView(
                      dialogContext,
                      title: 'Feedback',
                      hintText: 'Faites nous vos feedbacks ...',
                      onChanged: (value) {
                        content = value;
                      },
                      onTap: () {
                        controller.sendFeedback(
                          context: context,
                          content: content,
                          name: user.name,
                          email: user.email,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  );
                } else if (i == 2) {
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      alignment: Alignment.center,
                      backgroundColor: theme.highlightColor,
                      children: [aboutDialogBody(width, theme, context)],
                    ),
                  );
                } else {
                  myCustomSnackBar(
                    context: context,
                    text: 'Fonctionnalité non disponible',
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icons[i],
                          color: theme.primaryColor,
                          size: width * 0.05,
                        ),
                        Gap(width * 0.03),
                        Text(
                          titles[i].tr(),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: width * 0.025,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      iconsSuff[i],
                      color: theme.primaryColorLight,
                      size: width * 0.03,
                    ),
                  ],
                ),
              ),
            ),
            i == titles.length - 1 ? Gap(width * 0.035) : Gap(width * 0.05),
          },
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    AppIcons.langue,
                    color: theme.primaryColor,
                    size: width * 0.06,
                  ),
                  Gap(width * 0.03),
                  Text(
                    'Langue'.tr(),
                    style: TextStyle(fontSize: width * 0.025),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => controller.changeLanguages(context),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(width * 0.02),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text(
                        french ? 'Français' : 'English',
                        style: TextStyle(fontSize: width * 0.025),
                      ),
                      Gap(width * 0.03),
                      Flag(
                        french ? AppIcons.french : AppIcons.english,
                        size: width * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Gap(width * 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    AppIcons.darkMode,
                    color: theme.primaryColor,
                  ),
                  Gap(width * 0.03),
                  Text(
                    'Thème sombre'.tr(),
                    style: TextStyle(fontSize: width * 0.025),
                  ),
                ],
              ),
              Switch(
                value: controller.isDark,
                activeColor: theme.primaryColor,
                inactiveThumbColor: theme.primaryColor,
                inactiveTrackColor: theme.primaryColor.withOpacity(0.5),
                onChanged: (value) => controller.changeThemeMode(),
              ),
            ],
          ),
          Gap(width * 0.05),
        ],
      ),
    );
  }
}
