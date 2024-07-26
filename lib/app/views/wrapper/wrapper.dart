import 'package:flutter/material.dart';

import '../../../controllers/controllers.dart';
import '../../shared/shared.dart';
import '../views.dart';

class Wrapper extends StatelessWidget {
  final MainController mainController;
  final UserDataController userData;
  final TuyauController tuyau;
  const Wrapper({
    super.key,
    required this.tuyau,
    required this.userData,
    required this.mainController,
  });

  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome(context, mainController);
    final width = MediaQuery.sizeOf(context).width;
    List selectedIcons = [AppIcons.gridviewB, AppIcons.accountB];
    List unselectedIcons = [AppIcons.gridview, AppIcons.account];
    List screens = [
      HomePage(
        user: userData,
        controller: mainController,
      ),
      ProfilePage(
        user: userData,
        controller: mainController,
      ),
    ];
    final controller = mainController;
    return Scaffold(
      body: screens[controller.index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) => CustomBottomModalView(
          //     tuyau: tuyau,
          //     user: userData,
          //   ),
          // );
          tuyau.loadFaculties(
            context: context,
            univID: userData.univ,
          );
          tuyau.pickImgFromGallery(context, userData);
        },
        shape: const CircleBorder(),
        elevation: 0,
        foregroundColor: Colors.black,
        child: Icon(AppIcons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).highlightColor,
        notchMargin: width * 0.025,
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.15),
        height: width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(selectedIcons.length, (index) {
            return GestureDetector(
              onTap: () => controller.navigationController(index),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: EdgeInsets.all(width * 0.05),
                child: Icon(
                  controller.index == index
                      ? selectedIcons[index]
                      : unselectedIcons[index],
                  color: controller.index == index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  size: controller.index == index ? width * 0.06 : width * 0.04,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
