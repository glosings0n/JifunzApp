import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

AppBar headView1(
    {width, fac, promo, BuildContext? context, String? firstName}) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: Size(
        width,
        width * 0.3,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: width * 0.1,
          right: width * 0.1,
          bottom: width * 0.05,
        ),
        child: Column(
          children: [
            Text(
              'Bienvenu.e encore'.tr(),
              style: Theme.of(context!)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: width * 0.03),
            ),
            Text(
              firstName!,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: width * 0.05),
            ),
            Gap(width * 0.02),
            Text(
              "Voici les cours de la faculté de ".tr() +
                  fac +
                  ", nous avons choisi pour vous les cours de ".tr() +
                  promo +
                  ' ' +
                  fac +
                  '.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: width * 0.025),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

AppBar headView2(
    {width, fac, promo, BuildContext? context, String? firstName}) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: Size(
        width,
        width * 0.4,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: width * 0.1,
          right: width * 0.1,
          bottom: width * 0.05,
        ),
        child: Column(
          children: [
            Text(
              'Bienvenu.e encore'.tr(),
              style: Theme.of(context!)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: width * 0.03),
            ),
            Text(
              firstName!,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: width * 0.05),
            ),
            Gap(width * 0.02),
            Text(
              "Désolé mais il semble que nous n'avons pas trouvé les cours de "
                      .tr() +
                  promo +
                  " " +
                  fac +
                  ". Pouvez-vous aider le concepteur en signalant l'incident et apporter votre aide au projet !"
                      .tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: width * 0.025),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
