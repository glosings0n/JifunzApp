import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../controllers/controllers.dart';
import '../../../../shared/shared.dart';
import 'txtform_view.dart';

class SecondMainBodyView extends StatelessWidget {
  final TuyauController tuyau;
  const SecondMainBodyView({super.key, required this.tuyau});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataController>(context);
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.12,
        right: width * 0.12,
        bottom: width * 0.02,
      ),
      child: Column(
        children: [
          txtFormView(context, width),
          const Gap(5),
          CustomDropDownMenu(
            index: 3,
            data: tuyau.facs,
            displayValue: tuyau.facValue,
            onTap: (String? value) async {
              tuyau.onFacValueChanged(
                user: user,
                value: value,
                context: context,
              );
            },
          ),
          const Gap(5),
          CustomDropDownMenu(
            index: 4,
            data: tuyau.promos,
            displayValue: tuyau.promoValue,
            onTap: tuyau.facValue == null
                ? null
                : (String? value) async {
                    tuyau.onPromoValueChanged(
                      user: user,
                      value: value,
                      context: context,
                    );
                  },
          ),
          const Gap(5),
          CustomDropDownMenu(
              index: 5,
              data: tuyau.coursesData,
              displayValue: tuyau.titleValue,
              onTap: tuyau.promoValue == null
                  ? null
                  : (String? value) {
                      tuyau.onTitleValueChanged(value);
                    }),
          const Gap(5),
          CustomDropDownMenu(
              index: 6,
              data: AppVar.annees,
              displayValue: tuyau.yearValue,
              onTap: tuyau.titleValue == null
                  ? null
                  : (String? value) {
                      tuyau.onYearValueChanged(value);
                    }),
          const Gap(5),
          CustomDropDownMenu(
              index: 7,
              data: AppVar.sessions,
              displayValue: tuyau.sessionValue,
              onTap: tuyau.yearValue == null
                  ? null
                  : (String? value) {
                      tuyau.onSessionValueChanged(value);
                    }),
          const Gap(5),
          CustomDropDownMenu(
              index: 8,
              data: AppVar.series,
              displayValue: tuyau.serieValue,
              onTap: tuyau.sessionValue == null
                  ? null
                  : (String? value) {
                      tuyau.onSerieValueChanged(value);
                    }),
          const Gap(5),
          CustomDropDownMenu(
              index: 9,
              data: AppVar.suite,
              displayValue: tuyau.suiteValue,
              onTap: tuyau.serieValue == null
                  ? null
                  : (String? value) {
                      tuyau.onSuiteValueChanged(value);
                    }),
        ],
      ),
    );
  }
}
