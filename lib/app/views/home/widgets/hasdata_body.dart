import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';
import '../../../../data/data.dart';
import '../pages/detail/detail_page.dart';

class HasDataBody extends StatelessWidget {
  final MainController controller;
  final List<TuyauxModel> tuyaux;
  const HasDataBody({
    super.key,
    required this.tuyaux,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: GestureDetector(
        onDoubleTap: controller.gridDoubleTap,
        child: MasonryGridView.count(
          crossAxisCount: controller.maxColumnCount,
          mainAxisSpacing: width * 0.02,
          crossAxisSpacing: width * 0.02,
          scrollDirection: Axis.vertical,
          itemCount: tuyaux.length,
          itemBuilder: (context, index) {
            final tuyau = tuyaux[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    index: index,
                    tuyau: tuyau,
                  ),
                ),
              ),
              child: Hero(
                tag: 'Image $index',
                child: tuyau.isPDF
                    ? Container(
                        color: AppColors.tdGrey,
                        height: controller.maxColumnCount == 2
                            ? controller.maxColumnCount * 150.0
                            : controller.maxColumnCount == 3
                                ? controller.maxColumnCount * 60.0
                                : controller.maxColumnCount * 35.0,
                        child: Container(),
                      )
                    : CachedNetworkImage(
                        imageUrl: tuyau.imgUrl,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Container(
                            alignment: Alignment.center,
                            width: 15,
                            height: 15,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(100),
                              backgroundColor: theme.highlightColor,
                              color: theme.primaryColor,
                              value: progress.progress,
                              minHeight: 2,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => Container(),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
