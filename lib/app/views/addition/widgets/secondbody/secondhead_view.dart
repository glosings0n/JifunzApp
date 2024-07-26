import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondBodyHeadView extends StatelessWidget {
  const SecondBodyHeadView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.1,
        right: width * 0.1,
        bottom: width * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Détails".tr(),
            style: GoogleFonts.raleway(
              fontSize: width * 0.04,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pop(context);
          //     cubit.facValue = null;
          //     cubit.yearValue = null;
          //     cubit.promoValue = null;
          //     cubit.titleValue = null;
          //     cubit.serieValue = null;
          //     cubit.suiteValue = null;
          //     cubit.sessionValue = null;
          //     cubit.sessionValue = null;
          //     cubit.isUploading = false;
          //     showModalBottomSheet(
          //       context: context,
          //       builder: (context) => modalBottomView(
          //         width: width,
          //         context: context,
          //       ),
          //     );
          //   },
          //   child: Icon(
          //     Iconsax.gallery_edit_outline,
          //     color: Theme.of(context).primaryColorLight,
          //     size: width * 0.06,
          //   ),
          // ),
        ],
      ),
    );
  }
}
