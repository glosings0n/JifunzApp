import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../shared.dart';

void myCustomSnackBar({context, text}) {
  final overlay = Overlay.of(context);

  final overlayEntry = OverlayEntry(
    canSizeOverlay: true,
    builder: (context) => Align(
      alignment: Alignment.bottomCenter,
      child: mySnackBar(context, text),
    ),
  );
  overlay.insert(overlayEntry);

  Timer(const Duration(milliseconds: 2500), () {
    overlayEntry.remove();
  });
}

Widget mySnackBar(BuildContext context, String text) {
  return Container(
    padding: EdgeInsets.only(
      top: MediaQuery.sizeOf(context).width * 0.015,
      left: MediaQuery.sizeOf(context).width * 0.02,
      right: MediaQuery.sizeOf(context).width * 0.035,
      bottom: MediaQuery.sizeOf(context).width * 0.015,
    ),
    margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.025),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColorDark,
      borderRadius: BorderRadius.circular(25),
    ),
    child: SizedBox(
      height: MediaQuery.sizeOf(context).width * 0.065,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0.0,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).width * 0.06,
              width: MediaQuery.sizeOf(context).width * 0.06,
              child: Image.asset(AppImages.snacklogo),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width * 0.08,
            ),
            child: Text(
              text.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).highlightColor,
                    fontSize: MediaQuery.sizeOf(context).width * 0.025,
                  ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
