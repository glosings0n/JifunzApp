import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';
import 'confi_body.dart';

class Confidentiality extends StatelessWidget {
  const Confidentiality({super.key});

  @override
  Widget build(BuildContext context) {
    welcomCustomSystemChrome();
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.tdBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.only(
                        top: width * 0.03,
                        right: width * 0.03,
                        bottom: width * 0.03,
                      ),
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
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
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: width * 0.06),
                          ),
                        ],
                      ),
                    ),
                    Gap(width * 0.03),
                    const ConfiBody(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
