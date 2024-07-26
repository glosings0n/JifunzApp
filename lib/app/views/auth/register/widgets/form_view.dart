import 'package:flutter/material.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';
import '../../choice/choice.dart';

class FormView extends StatefulWidget {
  final MainController mainController;
  final UserDataController user;
  const FormView({
    super.key,
    required this.user,
    required this.mainController,
  });

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    final value = widget.user;
    value.loadUniversities();
    List infos = [widget.user.name!, widget.user.email!];
    return ListView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      children: [
        for (int i = 0; i < 2; i++) ...{
          CustomTextFormField(
            i: i,
            infos: infos,
            isAccount: false,
          ),
        },
        CustomDropDownMenu(
          index: 2,
          data: value.universities,
          displayValue: value.univ,
          onTap: (String? data) => value.onUnivValueSelected(data, context),
        ),
        CustomDropDownMenu(
          index: 3,
          data: value.facs,
          displayValue: value.fac,
          onTap: value.univ == null
              ? null
              : (String? data) => value.onFacValueSelected(data, context),
        ),
        CustomDropDownMenu(
          index: 4,
          data: value.promos,
          displayValue: value.promo,
          onTap: value.fac == null
              ? null
              : (String? data) => value.onPromoValueSelected(data),
        ),
        value.coursesIsLoading
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: width * 0.05),
                height: width * 0.12,
                child: CircularProgressIndicator(
                  color: theme.primaryColorLight,
                  strokeWidth: 1.5,
                ),
              )
            : GestureDetector(
                onTap: () async {
                  if (value.univ != null &&
                      value.fac != null &&
                      value.promo != null) {
                    await value.loadCoursesData(
                      context: context,
                      univID: value.univ,
                      facID: value.fac,
                      promoID: value.promo,
                    );
                    if (value.courses!.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChoicePage(
                            user: widget.user,
                            mainController: widget.mainController,
                          ),
                        ),
                      );
                    }
                  } else {
                    myCustomSnackBar(
                      context: context,
                      text: 'Veuillez compléter tous les champs',
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: bottomButton(
                    'Continuer',
                    txtColor: theme.primaryColorLight,
                    color: theme.primaryColor,
                    width: width,
                    icon: null,
                  ),
                ),
              ),
      ],
    );
  }
}
