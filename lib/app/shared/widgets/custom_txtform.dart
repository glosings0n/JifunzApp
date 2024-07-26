import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../shared.dart';

class CustomTextFormField extends StatelessWidget {
  final dynamic infos, i;
  final bool isAccount;
  const CustomTextFormField({
    super.key,
    required this.infos,
    required this.i,
    required this.isAccount,
  });

  @override
  Widget build(BuildContext context) {
    dynamic width = MediaQuery.sizeOf(context).width;
    return TextFormField(
      initialValue: infos[i],
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontSize: width * 0.025),
      enabled: false,
      cursorColor: Theme.of(context).primaryColorLight,
      decoration: InputDecoration(
        icon: Icon(
          AppVar.icons[i],
          size: width * 0.05,
        ),
        iconColor: AppColors.tdYellow,
        labelText: AppVar.title[i].tr(),
        labelStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AppColors.tdYellow),
        border: isAccount
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  style: BorderStyle.solid,
                  width: 1,
                ),
              ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorLight,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorLight,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.tdRed,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
    );
  }
}
