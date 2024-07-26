import 'package:flutter/material.dart';

import '../../../../controllers/controllers.dart';
import 'widgets/choice_appbar.dart';
import 'widgets/no_found_view.dart';
import 'widgets/found_view.dart';

class ChoicePage extends StatelessWidget {
  final MainController mainController;
  final UserDataController user;
  const ChoicePage({
    super.key,
    required this.user,
    required this.mainController,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    String firstName = user.name!.split(' ')[0];
    return Scaffold(
      appBar: user.courses!.isEmpty
          ? headView2(
              width: width,
              promo: user.promo,
              fac: user.fac,
              context: context,
              firstName: firstName,
            )
          : headView1(
              width: width,
              promo: user.promo,
              fac: user.fac,
              context: context,
              firstName: firstName,
            ),
      body: user.courses!.isEmpty
          ? NoFoundView(
              fac: user.fac!,
              promo: user.promo!,
            )
          : FoundView(user: user),
    );
  }
}
