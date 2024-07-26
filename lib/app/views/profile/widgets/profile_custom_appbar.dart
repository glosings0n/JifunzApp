// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';

class ProfileCustomAppBar extends StatelessWidget {
  final UserDataController user;
  final MainController controller;
  const ProfileCustomAppBar({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Container(
        color: Theme.of(context).highlightColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomAppbarIcon(
              icon: AppIcons.logout,
              isNotifIcon: false,
              homeView: false,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => SimpleDialog(
                    backgroundColor: AppColors.tdRed,
                    alignment: Alignment.center,
                    contentPadding: EdgeInsets.all(width * 0.05),
                    children: [
                      SizedBox(
                        width: width * 0.2,
                        height: width * 0.2,
                        child: Image.asset(AppImages.emoji),
                      ),
                      Gap(width * 0.03),
                      Text(
                        'Veux-tu te déconnecter ?'.tr(),
                        style: TextStyle(fontSize: width * 0.03),
                        textAlign: TextAlign.center,
                      ),
                      Gap(width * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(dialogContext),
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
                            onTap: () async {
                              await user.signOutUser();
                              controller.index = 0;
                              Navigator.pop(dialogContext);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.025,
                                vertical: width * 0.02,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(dialogContext).primaryColorDark,
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
