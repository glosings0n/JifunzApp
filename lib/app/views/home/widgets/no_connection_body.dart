import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../shared/shared.dart';

class NoConnectionBody extends StatelessWidget {
  const NoConnectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Expanded(
      child: Center(
        child: Container(
          width: width,
          padding: EdgeInsets.only(
            left: width * 0.2,
            right: width * 0.2,
            bottom: width * 0.15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                AppIcons.noConnection,
                size: width * 0.1,
              ),
              const Gap(10),
              Text('Oops !', style: theme.textTheme.bodyMedium),
              Text('Pas de connection'.tr(), style: theme.textTheme.bodySmall),
              // const Gap(30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () => Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => MainWrapper(
              //             account: AccountModel(
              //               userName: user.name,
              //               userEmail: user.email,
              //               userImgUrl: user.imgUrl,
              //               userUniv: user.univ,
              //               userFac: user.fac,
              //               userPromo: user.promo,
              //               userCourses: user.courses!,
              //             ),
              //           ),
              //         ),
              //       ),
              //       child: Container(
              //         alignment: Alignment.center,
              //         padding: EdgeInsets.all(width * 0.025),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: theme.primaryColorDark,
              //             style: BorderStyle.solid,
              //             width: 1,
              //           ),
              //           borderRadius: BorderRadius.circular(50),
              //         ),
              //         child: Text(
              //           "Réessayer".tr(),
              //           style: theme.textTheme.bodySmall!.copyWith(
              //             fontSize: width * 0.025,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
