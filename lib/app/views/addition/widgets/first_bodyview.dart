import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FirstBodyView extends StatefulWidget {
  final File? selectedFile;
  final bool isPDF;
  const FirstBodyView({
    super.key,
    required this.isPDF,
    required this.selectedFile,
  });

  @override
  State<FirstBodyView> createState() => _FirstBodyViewState();
}

class _FirstBodyViewState extends State<FirstBodyView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        if (widget.selectedFile != null)
          Expanded(
            child: widget.isPDF
                ? SizedBox(
                    width: width,
                    child: SfPdfViewer.file(
                      widget.selectedFile!,
                      scrollDirection: PdfScrollDirection.horizontal,
                      enableTextSelection: false,
                    ),
                  )
                : InteractiveViewer(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: width,
                      child: Image.file(widget.selectedFile!),
                    ),
                  ),
          ),
        SizedBox(
          width: width,
          height: height * 0.25,
          child: Container(),
        ),
      ],
    );
  }
}
