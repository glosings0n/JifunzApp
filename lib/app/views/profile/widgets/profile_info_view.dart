import 'package:flutter/material.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';

class ProfileInfoView extends StatelessWidget {
  final UserDataController user;
  const ProfileInfoView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    List infos = [
      user.name,
      user.email,
      user.univ,
      user.fac,
      user.promo,
    ];
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.05,
        horizontal: width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 2; i < 5; i++) ...{
            CustomTextFormField(
              i: i,
              infos: infos,
              isAccount: true,
            )
          },
        ],
      ),
    );
  }
}
