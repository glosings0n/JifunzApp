import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';

class HomeCustomAppbar extends StatelessWidget {
  final MainController controller;
  final List courses;
  const HomeCustomAppbar({
    super.key,
    required this.courses,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Container(
      color: Theme.of(context).highlightColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAppbarIcon(
                icon: controller.isDark ? AppIcons.libB : AppIcons.lib,
                isNotifIcon: false,
                homeView: true,
              ),
            ],
          ),
          Container(
            width: width,
            height: width * 0.21,
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jifunz'App",
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontSize: width * 0.06,
                  ),
                ),
                Gap(width * 0.03),
                SizedBox(
                  width: width,
                  height: width * 0.065,
                  child: ListView.builder(
                    itemCount: courses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () => controller.filterCourses(i),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: controller.filter == i
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColorDark,
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.025),
                          margin: EdgeInsets.only(
                              right:
                                  i == courses.length - 1 ? 0 : width * 0.025),
                          child: Row(
                            children: [
                              if (controller.filter == i) ...{
                                Icon(
                                  AppIcons.validate,
                                  size: width * 0.03,
                                ),
                                Gap(width * 0.01),
                              },
                              Text(
                                courses.isEmpty ? '' : courses[i],
                                style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: width * 0.025,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
