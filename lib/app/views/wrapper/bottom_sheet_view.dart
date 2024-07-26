import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/controllers.dart';

class CustomBottomModalView extends StatelessWidget {
  final UserDataController user;
  final TuyauController tuyau;
  const CustomBottomModalView({
    super.key,
    required this.user,
    required this.tuyau,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.05,
        horizontal: width * 0.2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      height: width * 0.3,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              tuyau.loadFaculties(
                context: context,
                univID: user.univ,
              );
              tuyau.pickImgFromGallery(context, user);
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(width * 0.03),
              child: Column(
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: width * 0.065,
                  ),
                  Gap(width * 0.01),
                  Text(
                    'Image',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: width * 0.02),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              tuyau.loadFaculties(
                context: context,
                univID: user.univ,
              );
              tuyau.pickFile(context, user);
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(width * 0.03),
              child: Column(
                children: [
                  Icon(
                    Icons.upload_file_outlined,
                    size: width * 0.065,
                  ),
                  Gap(width * 0.01),
                  Text(
                    'PDF',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: width * 0.02),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
