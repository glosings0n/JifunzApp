import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../data/data.dart';
import '../../../../../shared/shared.dart';
import 'bottom_view.dart';

Widget infoBottomView({
  context,
  width,
  int? index,
  String? userName,
  String? userEmail,
  TuyauxModel? tuyauModel,
}) {
  List<String> infos = [
    tuyauModel!.title,
    tuyauModel.univ,
    tuyauModel.fac,
    tuyauModel.promo,
    tuyauModel.academicyear,
    tuyauModel.session,
    tuyauModel.serie,
    if (userEmail == 'georgesbyona@gmail.com') ...{
      tuyauModel.authorName,
      tuyauModel.authorEmail,
    }
  ];

  List icons = [
    tuyauModel.isPDF ? AppIcons.file : AppIcons.galleryPhoto,
    AppIcons.university,
    AppIcons.fac,
    AppIcons.promo,
    AppIcons.date,
    AppIcons.session,
    AppIcons.serie,
    if (userEmail == 'georgesbyona@gmail.com') ...{
      AppIcons.avatar,
      AppIcons.mail,
    }
  ];

  List<String> titles = [
    '',
    'Université',
    'Faculté',
    'Promotion',
    'Année Académique',
    'Session',
    'Série',
    if (userEmail == 'georgesbyona@gmail.com') ...{
      "Nom de l'Auteur",
      "Email de l'Auteur",
    }
  ];

  return bottomBodyView(
    context: context,
    icons: icons,
    index: index,
    infos: infos,
    titles: titles,
    width: width,
    userName: userName,
    userEmail: userEmail,
    tuyauModel: tuyauModel,
    scrollController: ScrollController(),
  );
}

class BottomInfoView extends StatefulWidget {
  final TuyauxModel tuyauModel;
  final String userEmail;
  final String userName;
  final int index;
  const BottomInfoView({
    super.key,
    required this.index,
    required this.userName,
    required this.userEmail,
    required this.tuyauModel,
  });

  @override
  State<BottomInfoView> createState() => _BottomInfoViewState();
}

class _BottomInfoViewState extends State<BottomInfoView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    List<String> infos = [
      widget.tuyauModel.title,
      widget.tuyauModel.univ,
      widget.tuyauModel.fac,
      widget.tuyauModel.promo,
      widget.tuyauModel.academicyear,
      widget.tuyauModel.session,
      widget.tuyauModel.serie,
      if (widget.userEmail == 'georgesbyona@gmail.com') ...{
        widget.tuyauModel.authorName,
        widget.tuyauModel.authorEmail,
      }
    ];

    List icons = [
      widget.tuyauModel.isPDF ? AppIcons.file : AppIcons.galleryPhoto,
      AppIcons.university,
      AppIcons.fac,
      AppIcons.promo,
      AppIcons.date,
      AppIcons.session,
      AppIcons.serie,
      if (widget.userEmail == 'georgesbyona@gmail.com') ...{
        AppIcons.avatar,
        AppIcons.mail,
      }
    ];

    List<String> titles = [
      '',
      'Université',
      'Faculté',
      'Promotion',
      'Année Académique',
      'Session',
      'Série',
      if (widget.userEmail == 'georgesbyona@gmail.com') ...{
        "Nom de l'Auteur",
        "Email de l'Auteur",
      }
    ];

    return DraggableScrollableSheet(
      initialChildSize: 0.12,
      minChildSize: 0.12,
      maxChildSize: 0.6,
      snap: true,
      builder: (context, scrollController) {
        return bottomBodyView(
          width: width,
          infos: infos,
          icons: icons,
          titles: titles,
          context: context,
          index: widget.index,
          userName: widget.userName,
          userEmail: widget.userEmail,
          tuyauModel: widget.tuyauModel,
          scrollController: scrollController,
        );
      },
    );
  }
}

Container bottomBodyView({
  context,
  width,
  index,
  List? infos,
  List? icons,
  List? titles,
  String? userName,
  String? userEmail,
  TuyauxModel? tuyauModel,
  ScrollController? scrollController,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    width: width,
    height: MediaQuery.sizeOf(context).height * 0.55,
    padding: EdgeInsets.symmetric(
      vertical: width * 0.04,
      horizontal: width * 0.1,
    ),
    child: ListView(
      controller: scrollController,
      children: [
        BottomView(
          index: index,
          tuyauModel: tuyauModel!,
          userEmail: userEmail!,
          userName: userName!,
          scrollController: scrollController!,
        ),
        Divider(
          color: Theme.of(context).primaryColorDark.withOpacity(0.5),
        ),
        Text(
          "Détails".tr(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 3),
        ),
        Column(
          children: [
            for (int i = 0; i < infos!.length; i++) ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        icons![i],
                        size: width * 0.06,
                      ),
                      Gap(width * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (i != 0) ...{
                            Text(
                              "${titles![i]}".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: width * 0.02, height: 2),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          },
                          Text(
                            infos[i],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: width * 0.025),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (i == 0) ...{
                    Text(
                      "${tuyauModel.size} kb",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: width * 0.02, height: 2),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  },
                ],
              ),
              Gap(width * 0.03),
            }
          ],
        ),
      ],
    ),
  );
}
