import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/controllers.dart';
import 'widgets/addition_custom_appbar.dart';
import 'widgets/first_bodyview.dart';
import 'widgets/secondbody/second_bodyview.dart';

class AdditionPage extends StatelessWidget {
  final String fileSize, fileName;
  final UserDataController user;
  final bool isPDF;
  const AdditionPage({
    super.key,
    required this.user,
    required this.isPDF,
    required this.fileName,
    required this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    final tuyau = Provider.of<TuyauController>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: tuyau.selectedFile == null
            ? Theme.of(context).highlightColor
            : Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            AdditionCustomAppbar(
              tuyau: tuyau,
              fileName: fileName,
            ),
            Expanded(
              child: Stack(
                children: [
                  FirstBodyView(
                    isPDF: isPDF,
                    selectedFile: tuyau.selectedFile,
                  ),
                  SecondBodyView(
                    user: user,
                    tuyau: tuyau,
                    isPDF: isPDF,
                    fileSize: fileSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
