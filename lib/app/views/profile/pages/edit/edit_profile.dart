import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';

class EditProfilePage extends StatefulWidget {
  final MainController controller;
  final UserDataController user;
  const EditProfilePage({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    final user = widget.user;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(AppIcons.closeX),
        ),
        title: Text("Modification du profil".tr()),
        titleTextStyle: GoogleFonts.raleway(
          fontSize: width * 0.04,
          color: Theme.of(context).primaryColorLight,
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (user.univ != null && user.fac != null && user.promo != null) {
                await user.loadCoursesData(
                  context: context,
                  facID: user.fac,
                  univID: user.univ,
                  promoID: user.promo,
                );
                if (user.courses!.isNotEmpty && !user.coursesError) {
                  await user.updatedUserInfo(
                    context: context,
                    userUniv: user.univ,
                    userFac: user.fac,
                    userPromo: user.promo,
                    userCourses: user.courses,
                  );
                  widget.controller.index = 0;
                }
              } else {
                myCustomSnackBar(
                  context: context,
                  text: 'Veuillez compléter tous les champs',
                );
              }
            },
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: width * 0.05),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                  style: BorderStyle.solid,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: user.coursesIsLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.check_rounded),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: width * 0.25,
                  height: width * 0.25,
                  margin: EdgeInsets.only(top: width * 0.05),
                  decoration: BoxDecoration(
                    color: AppColors.tdGrey,
                    shape: BoxShape.circle,
                    image: widget.controller.isConnected
                        ? DecorationImage(
                            image: NetworkImage(user.imgUrl!),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: AssetImage(AppImages.user),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Gap(width * 0.05),
                Text(
                  user.name!,
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontSize: width * 0.03,
                  ),
                ),
                Gap(width * 0.01),
                Text(
                  user.email!,
                  style: TextStyle(
                    color: theme.primaryColorDark.withOpacity(0.8),
                    fontSize: width * 0.02,
                  ),
                ),
                Gap(width * 0.05),
                Text(
                  "Vous êtes sur le point de modifier votre compte utilisateur. Cela changera les données de l'App relativement à ces inforamtions modifiées."
                      .tr(),
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: width * 0.025,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(width * 0.02),
                Text(
                  "Ici, vous ne pouvez modifier que les infos supplémentaires donc votre faculté et votre promotion car nous ne sommes que dans une seule Université pour l'instant."
                      .tr(),
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: width * 0.025,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(width * 0.02),
                Text(
                  "Si vous comptez changer de compte, veuillez vous déconnecter puis vous reconnecter avec un autre."
                      .tr(),
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontSize: width * 0.025,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(width * 0.02),
                CustomDropDownMenu(
                  index: 3,
                  data: user.facs,
                  displayValue: user.fac,
                  onTap: user.facs.isEmpty
                      ? null
                      : (String? data) =>
                          user.onFacValueSelected(data, context),
                ),
                CustomDropDownMenu(
                  index: 4,
                  data: user.promos,
                  displayValue: user.promo,
                  onTap: user.promos.isEmpty
                      ? null
                      : (String? data) => user.onPromoValueSelected(data),
                ),
              ],
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    await widget.user.loadFaculties(
      context: context,
      univID: widget.user.univ,
    );
    await widget.user.loadPromotions(
      context: context,
      facID: widget.user.fac,
      univID: widget.user.univ,
    );
  }
}
