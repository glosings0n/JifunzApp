import 'package:flutter/material.dart';

import '../../../../controllers/controllers.dart';
import '../../../shared/shared.dart';

class AdditionCustomAppbar extends StatelessWidget {
  final TuyauController tuyau;
  final String fileName;
  const AdditionCustomAppbar({
    super.key,
    required this.tuyau,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Container(
        color: Theme.of(context).highlightColor,
        padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.04,
          bottom: width * 0.03,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (tuyau.isUploading) {
                  myCustomSnackBar(
                    context: context,
                    text: 'Traitement en cours ... Veuillez patienter',
                  );
                } else {
                  Navigator.pop(context);
                  tuyau.facValue = null;
                  tuyau.promoValue = null;
                  tuyau.facValue = null;
                  tuyau.yearValue = null;
                  tuyau.promoValue = null;
                  tuyau.titleValue = null;
                  tuyau.serieValue = null;
                  tuyau.suiteValue = null;
                  tuyau.sessionValue = null;
                  tuyau.sessionValue = null;
                  tuyau.selectedFile = null;
                  tuyau.isUploading = false;
                }
              },
              child: Container(
                padding: EdgeInsets.all(width * 0.02),
                color: Colors.transparent,
                child: Icon(
                  AppIcons.closeX,
                  size: width * 0.05,
                ),
              ),
            ),
            Expanded(
              child: Text(
                fileName,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
