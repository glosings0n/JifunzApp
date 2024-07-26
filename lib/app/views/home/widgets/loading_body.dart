import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../shared/shared.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final highlightTheme = Theme.of(context).scaffoldBackgroundColor;
    final baseColorTheme = Theme.of(context).highlightColor;
    final width = MediaQuery.sizeOf(context).width;
    List boxes = [
      SizedBox(height: 400, width: width * 0.5),
      SizedBox(height: 200, width: width * 0.5),
      SizedBox(height: 300, width: width * 0.5),
      SizedBox(height: 150, width: width * 0.5),
      SizedBox(height: 400, width: width * 0.5),
      SizedBox(height: 200, width: width * 0.5),
      SizedBox(height: 350, width: width * 0.5),
      SizedBox(height: 200, width: width * 0.5),
    ];
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Shimmer.fromColors(
        baseColor: baseColorTheme,
        highlightColor: highlightTheme.withOpacity(0.5),
        enabled: true,
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: width * 0.02,
          crossAxisSpacing: width * 0.02,
          itemCount: boxes.length,
          itemBuilder: (context, index) => Container(
            color: AppColors.tdGrey,
            child: boxes[index],
          ),
        ),
      ),
    );
  }
}
