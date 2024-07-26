import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../../data/data.dart';
import '../../../../shared/shared.dart';

class FoundView extends StatelessWidget {
  final UserDataController user;

  const FoundView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    user.courses!.sort((a, b) => a.compareTo(b));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.custom(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: width * 0.02,
                mainAxisSpacing: width * 0.02,
                mainAxisExtent: width * 0.08,
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: user.courses!.length,
                (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: theme.primaryColorDark,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(width * 0.02),
                      child: Text(
                        user.courses![index],
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontSize: width * 0.025),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Text(
            "Avez-vous des choses à signaler par rapport aux cours de votre promotion, n'hésitez pas à laisser un mail à cette addresse : "
                .tr(),
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () async {
              await launchUrl(
                Uri(scheme: 'mailto', path: 'jifunzapp@gmail.com'),
              );
            },
            child: Text(
              "jifunzapp@gmail.com",
              style: TextStyle(
                color: Colors.blue,
                fontSize: width * 0.028,
                height: 2.5,
              ),
            ),
          ),
          Text(
            "ou cliquer sur l'icône en bas pour le contact WhatsApp :".tr(),
            style: theme.textTheme.bodySmall!,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          GestureDetector(
            onTap: () async {
              const url = 'https://wa.me/243813445417';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              }
            },
            child: Icon(
              Bootstrap.whatsapp,
              color: theme.primaryColorLight,
              size: width * 0.05,
            ),
          ),
          const Gap(20),
          user.isRegisterUser
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: width * 0.05),
                  height: width * 0.12,
                  child: CircularProgressIndicator(
                    color: theme.primaryColorLight,
                    strokeWidth: 1.5,
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    await user.registerUser(
                      UserModel(
                        name: user.name,
                        email: user.email,
                        imgUrl: user.imgUrl,
                        univ: user.univ,
                        fac: user.fac,
                        promo: user.promo,
                        fCMToken: user.fcmToken,
                        courses: user.courses!,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: bottomButton(
                      'Confirmer',
                      txtColor: theme.primaryColorLight,
                      color: theme.primaryColor,
                      width: width,
                      icon: null,
                    ),
                  ),
                ),
          const CustomFooter(),
        ],
      ),
    );
  }
}
