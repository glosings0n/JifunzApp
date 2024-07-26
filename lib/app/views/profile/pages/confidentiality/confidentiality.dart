import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import 'widgets/conf_body.dart';

class ConfidentialityPage extends StatelessWidget {
  const ConfidentialityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final themeD = Theme.of(context)
        .textTheme
        .displaySmall!
        .copyWith(fontSize: width * 0.06);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        children: [
          SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.2,
                  height: width * 0.2,
                  child: Image.asset(AppImages.logo),
                ),
                Gap(width * 0.03),
                Text(
                  "Jifunz'App",
                  style: themeD,
                ),
              ],
            ),
          ),
          Gap(width * 0.03),
          const ConfBody(),
        ],
      ),
    );
  }
}
