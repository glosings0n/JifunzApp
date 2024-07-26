import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

TextFormField txtFormView(BuildContext context, width) {
  return TextFormField(
    initialValue: 'Université Catholique de Bukavu'.tr(),
    style: Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(fontSize: width * 0.025),
    enabled: false,
    cursorColor: Theme.of(context).primaryColorLight,
    decoration: InputDecoration(
      icon: Icon(
        AppIcons.university,
        size: width * 0.05,
      ),
      iconColor: AppColors.tdYellow,
      labelText: 'Université'.tr(),
      labelStyle: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: AppColors.tdYellow),
      border: InputBorder.none,
    ),
  );
}
