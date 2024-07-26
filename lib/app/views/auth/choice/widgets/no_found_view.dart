import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../shared/shared.dart';

class NoFoundView extends StatelessWidget {
  final String fac, promo;
  const NoFoundView({super.key, required this.fac, required this.promo});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Veuillez laisser un mail à l'adresse suivante : ".tr(),
                style: Theme.of(context).textTheme.bodyMedium,
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
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "ou cliquer sur l'icône en bas pour le contact WhatsApp :".tr(),
                style: Theme.of(context).textTheme.bodyMedium,
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
                  color: Theme.of(context).primaryColorLight,
                  size: width * 0.05,
                ),
              ),
            ],
          ),
          const CustomFooter(),
        ],
      ),
    );
  }
}
