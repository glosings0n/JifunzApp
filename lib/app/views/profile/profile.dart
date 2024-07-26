import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../controllers/controllers.dart';
import 'widgets/profile_bottom_view.dart';
import 'widgets/profile_custom_appbar.dart';
import 'widgets/profile_head_view.dart';
import 'widgets/profile_info_view.dart';

class ProfilePage extends StatelessWidget {
  final MainController controller;
  final UserDataController user;
  const ProfilePage({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        children: [
          ProfileCustomAppBar(
            user: user,
            controller: controller,
          ),
          ProfileHeadView(
            user: user,
            controller: controller,
          ),
          Gap(width * 0.05),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              scrollDirection: Axis.vertical,
              children: [
                ProfileInfoView(user: user),
                Gap(width * 0.07),
                ProfileBottomView(
                  user: user,
                  controller: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
