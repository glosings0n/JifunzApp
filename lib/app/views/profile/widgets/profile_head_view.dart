import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import '../pages/edit/edit_profile.dart';

class ProfileHeadView extends StatelessWidget {
  final MainController controller;
  final UserDataController user;
  const ProfileHeadView({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    controller.checkConnection(context);
    final userName = getNomCourt(user.name!);
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Container(
            width: width,
            height: width * 0.2,
            decoration: BoxDecoration(
              color: theme.highlightColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                width: width * 0.25,
                height: width * 0.25,
                margin: EdgeInsets.only(top: width * 0.05),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: width * 0.25,
                      height: width * 0.25,
                      decoration: BoxDecoration(
                        color: AppColors.tdGrey,
                        shape: BoxShape.circle,
                        image: controller.isConnected
                            ? DecorationImage(
                                image: NetworkImage(user.imgUrl!),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: AssetImage(AppImages.user),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        user.facs = [];
                        user.promos = [];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(
                              user: user,
                              controller: controller,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(width * 0.02),
                        margin: EdgeInsets.only(right: width * 0.01),
                        child: Icon(
                          Clarity.edit_solid,
                          size: width * 0.03,
                          color: AppColors.tdBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(width * 0.05),
              Text(
                userName,
                style: theme.textTheme.displaySmall!.copyWith(
                  fontSize: width * 0.035,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(width * 0.01),
              Text(
                user.email!,
                style: TextStyle(
                  color: theme.primaryColorDark.withOpacity(0.8),
                  fontSize: width * 0.025,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getNomCourt(String nomComplet) {
    List<String> prenoms = nomComplet.split(' ');
    if (prenoms.length <= 2) {
      return nomComplet;
    } else {
      return prenoms[0] + ' ' + prenoms[1];
    }
  }
}
