import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Widget socialmediaView(
  double width,
  ThemeData theme,
  BuildContext context, {
  bool? isWhite = false,
}) {
  void launchApp(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Gap(width * 0.01),
      GestureDetector(
        onTap: () {
          const url = 'https://g.dev/georgesbyona';
          launchApp(url);
        },
        child: Icon(
          Bootstrap.google,
          color: isWhite! ? Colors.white : theme.primaryColorLight,
          size: width * 0.045,
        ),
      ),
      GestureDetector(
        onTap: () {
          const url = 'https://twitter.com/GeorgesByona23';
          launchApp(url);
        },
        child: Icon(
          Bootstrap.twitter_x,
          color: isWhite ? Colors.white : theme.primaryColorLight,
          size: width * 0.045,
        ),
      ),
      GestureDetector(
        onTap: () {
          const url = 'https://www.linkedin.com/in/georgesbyona';
          launchApp(url);
        },
        child: Icon(
          Bootstrap.linkedin,
          color: isWhite ? Colors.white : theme.primaryColorLight,
          size: width * 0.045,
        ),
      ),
      GestureDetector(
        onTap: () {
          const url = 'https://www.instagram.com/georgesbyona';
          launchApp(url);
        },
        child: Icon(
          Bootstrap.instagram,
          color: isWhite ? Colors.white : theme.primaryColorLight,
          size: width * 0.045,
        ),
      ),
      GestureDetector(
        onTap: () {
          const url = 'https://github.com/G-Losingson';
          launchApp(url);
        },
        child: Icon(
          Bootstrap.github,
          color: isWhite ? Colors.white : theme.primaryColorLight,
          size: width * 0.045,
        ),
      ),
      GestureDetector(
        onTap: () {
          const url = 'https://medium.com/@georgesbyona';
          launchApp(url);
        },
        child: Icon(
          Bootstrap.medium,
          color: isWhite ? Colors.white : theme.primaryColorLight,
          size: width * 0.045,
        ),
      ),
      Gap(width * 0.01),
    ],
  );
}
