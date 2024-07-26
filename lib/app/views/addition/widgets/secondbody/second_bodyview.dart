import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import 'secondmainbody_view.dart';
import 'secondbottom_view.dart';
import 'secondhead_view.dart';

class SecondBodyView extends StatelessWidget {
  final UserDataController user;
  final TuyauController tuyau;
  final String fileSize;
  final bool isPDF;
  const SecondBodyView({
    super.key,
    required this.user,
    required this.isPDF,
    required this.tuyau,
    required this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return DraggableScrollableSheet(
      snap: true,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      initialChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: ListView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: width * 0.01,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    margin: EdgeInsets.only(bottom: width * 0.03),
                  ),
                ],
              ),
              const SecondBodyHeadView(),
              SecondMainBodyView(tuyau: tuyau),
              SecondBodyBottomView(
                user: user,
                isPDF: isPDF,
                tuyau: tuyau,
                fileSize: fileSize,
              ),
            ],
          ),
        );
      },
    );
  }
}
