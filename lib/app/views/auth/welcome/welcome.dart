import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import 'conf_welcome.dart';

class Welcome extends StatelessWidget {
  static const route = '/welcome';
  final UserDataController userProvider;
  final MainController mainProvider;
  const Welcome({
    super.key,
    required this.mainProvider,
    required this.userProvider,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight < constraints.maxWidth) {
          return WelcomeScreenLarge(
            userProvider: userProvider,
            mainProvider: mainProvider,
          );
        } else {
          return WelcomeScreenSmall(
            userProvider: userProvider,
            mainProvider: mainProvider,
          );
        }
      },
    );
  }
}

class WelcomeScreenLarge extends StatelessWidget {
  final MainController mainProvider;
  final UserDataController userProvider;
  const WelcomeScreenLarge({
    super.key,
    required this.mainProvider,
    required this.userProvider,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class WelcomeScreenSmall extends StatelessWidget {
  final MainController mainProvider;
  final UserDataController userProvider;
  const WelcomeScreenSmall({
    super.key,
    required this.mainProvider,
    required this.userProvider,
  });

  @override
  Widget build(BuildContext context) {
    welcomCustomSystemChrome();
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.tdBlack,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bckground),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            blurContainer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              color: Colors.transparent,
              height: height * 0.5,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BIENVENU.E DANS'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: width * 0.055),
                  ),
                  Row(
                    children: [
                      Text(
                        "Jifunz'App ",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: width * 0.08,
                                  height: 1.5,
                                ),
                      ),
                      Icon(
                        AppIcons.lib,
                        color: AppColors.tdYellow,
                      ),
                    ],
                  ),
                  Gap(width * 0.02),
                  Text(
                    "Optimise ta révision des notes -".tr(),
                    style: TextStyle(
                      fontSize: width * 0.03,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    "en retrouvant un ensemble des documents :\nanciens questionnaires d'examens, d'interrogations, des travaux pratiques, ..."
                        .tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: width * 0.025,
                          color: Colors.white,
                          height: 1.5,
                        ),
                  ),
                  GestureDetector(
                    onTap: mainProvider.isSignInLoading
                        ? null
                        : () async {
                            mainProvider.startSignIn();
                            await userProvider.signInUser(context);
                            mainProvider.startSignIn();
                          },
                    child: mainProvider.isSignInLoading
                        ? Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: width * 0.05),
                            height: width * 0.12,
                            child: CircularProgressIndicator(
                              color: AppColors.tdWhite,
                              strokeWidth: 1.5,
                            ),
                          )
                        : bottomButton(
                            'Connexion',
                            color: null,
                            width: width,
                            txtColor: AppColors.tdWhite,
                            icon: Brand(
                              AppIcons.googleLogo,
                              size: width * 0.06,
                            ),
                          ),
                  ),
                  Gap(width * 0.05),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Confidentiality(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Trouver '.tr(),
                            style: TextStyle(
                              fontSize: width * 0.025,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'les termes & conditions ici'.tr(),
                            style: TextStyle(
                              fontSize: width * 0.025,
                              color: Theme.of(context).primaryColor,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const CustomFooter(isWhite: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container blurContainer() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.tdBlack,
          Colors.transparent,
        ],
        stops: const [0.1, 0.8],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
    ),
  );
}
