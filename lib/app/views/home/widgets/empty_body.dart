import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/shared.dart';

class EmptyBody extends StatelessWidget {
  final String? cours;
  const EmptyBody({super.key, this.cours});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool french;
    (EasyLocalization.of(context)!.locale == const Locale('fr', 'FR'))
        ? french = true
        : french = false;
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          left: width * 0.2,
          right: width * 0.2,
          bottom: width * 0.15,
        ),
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              AppIcons.file,
              size: width * 0.1,
            ),
            Gap(width * 0.03),
            cours == null
                ? Text(
                    'Aucun document trouvé !'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  )
                : Text(
                    french
                        ? 'Aucun document de $cours trouvé !'
                        : 'No $cours document found!',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
            Gap(width * 0.05),
            Text(
              'Pour ajouter un document,\nveuillez cliquer sur le bouton (+)\nen bas au centre.'
                  .tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
