import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';

import '../shared.dart';

class CustomDropDownMenu extends StatelessWidget {
  final List data;
  final int index;
  final dynamic displayValue;
  final Function(String?)? onTap;
  const CustomDropDownMenu({
    super.key,
    required this.data,
    required this.index,
    required this.onTap,
    required this.displayValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      children: [
        Icon(
          AppVar.icons[index],
          color: theme.primaryColor,
        ),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: displayValue,
              hint: Text(
                AppVar.title[index].tr(),
                style: theme.textTheme.bodySmall!
                    .copyWith(color: AppColors.tdYellow),
              ),
              onChanged: onTap,
              style: theme.textTheme.bodySmall,
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                overlayColor: WidgetStateColor.transparent,
                width: width,
                height: 50,
              ),
              iconStyleData: IconStyleData(
                iconSize: width * 0.06,
                iconEnabledColor: theme.primaryColorLight,
                iconDisabledColor: Colors.transparent,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                openMenuIcon: const Icon(Icons.arrow_drop_up_rounded),
              ),
              dropdownStyleData: DropdownStyleData(
                elevation: 2,
                maxHeight: width * 0.8,
                decoration: BoxDecoration(
                  color: theme.highlightColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStatePropertyAll(
                    theme.primaryColorLight,
                  ),
                  radius: const Radius.circular(25),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                overlayColor: WidgetStateColor.transparent,
                height: 40,
              ),
              items: List.generate(
                data.length,
                (index) => DropdownMenuItem<String>(
                  value: data[index],
                  child: Text(data[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
