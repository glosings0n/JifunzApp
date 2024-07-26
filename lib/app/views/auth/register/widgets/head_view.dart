import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HeadView extends StatelessWidget {
  final String firstName;
  const HeadView({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Salut,".tr(),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: width * 0.05,
              letterSpacing: 2.0,
            ),
          ),
          Text(
            firstName,
            style: theme.textTheme.displaySmall!.copyWith(
              fontSize: width * 0.07,
              height: 1.5,
            ),
          ),
          Gap(width * 0.02),
          Text(
            "Pour une meilleure expérience avec Jifunz'App, veuillez compléter les infos ci-après :"
                .tr(),
            style: theme.textTheme.bodySmall!.copyWith(
              fontSize: width * 0.03,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
