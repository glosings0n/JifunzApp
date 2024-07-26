import 'package:flutter/material.dart';

class CustomAppbarIcon extends StatelessWidget {
  final IconData icon;
  final bool isNotifIcon, homeView;
  final VoidCallback? onTap;
  const CustomAppbarIcon({
    super.key,
    required this.icon,
    required this.isNotifIcon,
    required this.homeView,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        padding: EdgeInsets.all(width * 0.04),
        child: isNotifIcon
            ? Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(
                    icon,
                    size: width * 0.05,
                    color: theme.primaryColorLight,
                  ),
                  Container(
                    height: width * 0.015,
                    width: width * 0.015,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              )
            : Icon(
                icon,
                size: width * 0.05,
                color: homeView ? theme.primaryColor : theme.primaryColorLight,
              ),
      ),
    );
  }
}
