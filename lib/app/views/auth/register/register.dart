import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import '../../profile/pages/confidentiality/confidentiality.dart';
import 'widgets/form_view.dart';
import 'widgets/head_view.dart';

class RegisterScreen extends StatelessWidget {
  final MainController mainController;
  final UserDataController userProvider;
  const RegisterScreen({
    super.key,
    required this.userProvider,
    required this.mainController,
  });

  @override
  Widget build(BuildContext context) {
    String firstName = userProvider.name!.split(" ")[0];
    final width = MediaQuery.sizeOf(context).width;
    oCustomSystemChrome(context, mainController);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: width * 0.1,
            left: width * 0.1,
            right: width * 0.1,
          ),
          child: Column(
            children: [
              HeadView(firstName: firstName),
              const Gap(15),
              Expanded(
                child: FormView(
                  user: userProvider,
                  mainController: mainController,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfidentialityPage(),
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
                          color: Theme.of(context).primaryColorLight,
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
              const CustomFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
