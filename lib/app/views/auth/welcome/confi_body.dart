import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../shared/shared.dart';

class ConfiBody extends StatelessWidget {
  const ConfiBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final themeS = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Les présentes Conditions Générales d'Utilisation (dit \"CGU\") s'appliquent à l'application \"Jifunz'App\" et à tous les services accessibles via l'Application."
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.03),
        Text(
          "En utilisant l'Application, vous acceptez sans réserve les présentes CGU."
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.03),
        titleText("Accès à l'Application", width, context),
        Gap(width * 0.03),
        Text(
          "L'accès à l'Application est gratuit.\nPour utiliser l'Application, vous devez vous connecter via votre compte Google. L'Application collectera les données suivantes de votre compte Google :"
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.02),
        pointText('Votre nom', width, context),
        pointText('Votre adresse mail', width, context),
        pointText('Votre photo de profil', width, context),
        Gap(width * 0.03),
        Text(
          "Pour maximiser l'expérience avec l'Application, elle vous proposera ensuite de créer un profil utilisateur en complétant les informations suivantes :"
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.02),
        pointText('Votre université', width, context),
        pointText('Votre faculté', width, context),
        pointText('Votre promotion', width, context),
        pointText(
          'Vos cours préférés au-delà de ceux de votre promotion',
          width,
          context,
        ),
        Gap(width * 0.03),
        titleText("Utilisation de l'Application", width, context),
        Gap(width * 0.03),
        Text(
          "L'Application vous permet de :".tr(),
          style: themeS,
        ),
        Gap(width * 0.02),
        pointText(
          "Accéder à une base de données des anciens questionnaires d'examens, d'interrogations, de TP, ...",
          width,
          context,
        ),
        pointText(
          "Rechercher des questionnaires par mot-clé, par matière, par niveau, ...",
          width,
          context,
        ),
        pointText(
          "Télécharger et consulter les questionnaires",
          width,
          context,
        ),
        pointText(
          "Déposer vos propres questionnaires",
          width,
          context,
        ),
        pointText(
          "Noter, commenter et signaler un questionnaire",
          width,
          context,
        ),
        Gap(width * 0.03),
        titleText("Propriété Intellectuelle", width, context),
        Gap(width * 0.03),
        Text(
          "Le contenu de l'Application, y compris les questionnaires, les textes, les images, les vidéos, ..., est protégé par le droit d'auteur et appartient à l'Editeur ou à ses tiers concédants (Université, Enseignant, Etudiant, ... )."
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.03),
        Text(
          "Vous ne pouvez pas reproduire, diffuser, modifier ou adapter le contenu de l'Application sans l'autorisation expresse de l'Editeur."
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.03),
        titleText("Données Personnelles", width, context),
        Gap(width * 0.03),
        Text(
          "L'Editeur s'engage à respecter la vie privée des utilisateurs de l'Application.\nLes données personnelles collectées par l'Editeur sont utilisées pour les finalités suivantes :"
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.02),
        pointText("Gérer votre compte utilisateur", width, context),
        pointText("Vous fournir les Services", width, context),
        pointText("Améliorer l'Application", width, context),
        pointText(
          "Vous adresser des informations importantes",
          width,
          context,
        ),
        Gap(width * 0.03),
        Text(
          "Vous disposez d'un droit d'accès, de rectification, de suppression et de portabilité de vos données personnelles."
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.03),
        titleText('Responsabilité', width, context),
        Gap(width * 0.03),
        Text(
          "L'Editeur s'engage à mettre en œuvre tous les moyens nécessaires pour garantir la sécurité de l'Application et des Services.\nCependant, l'Editeur ne peut pas garantir que l'Application et les Services seront exempts d'erreurs ou de dysfonctionnements.\nL'Editeur ne peut pas être tenu responsable des dommages directs ou indirects causés par l'utilisation de l'Application ou des Services."
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.03),
        titleText('Modification des CGU', width, context),
        Gap(width * 0.03),
        Text(
          "L'Editeur se réserve le droit de modifier les présentes CGU à tout moment.\nLes modifications apportées aux CGU seront applicables dès leur publication sur l'Application."
              .tr(),
          style: themeS,
        ),
        Gap(width * 0.03),
        titleText('Contact', width, context),
        Gap(width * 0.03),
        Text(
          "Pour toute question relative aux présentes CGU, vous pouvez contacter l'Editeur à l'adresse suivante :"
              .tr(),
          style: themeS,
        ),
        GestureDetector(
          onTap: launchMail,
          child: Text(
            "jifunzapp@gmail.com",
            style: TextStyle(
              color: Colors.blue,
              fontSize: width * 0.028,
              height: 2.5,
            ),
          ),
        ),
        Gap(width * 0.05),
        socialmediaView(
          width,
          Theme.of(context),
          context,
          isWhite: true,
        ),
        Gap(width * 0.03),
        const CustomFooter(isWhite: true),
      ],
    );
  }

  void launchMail() async {
    await launchUrl(Uri(scheme: 'mailto', path: 'jifunzapp@gmail.com'));
  }
}

Row titleText(String text, final width, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        text.tr(),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
    ],
  );
}

Widget pointText(String text, final width, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.center,
        width: width * 0.01,
        height: width * 0.01,
        margin: EdgeInsets.only(
          top: width * 0.015,
          right: width * 0.02,
          left: width * 0.05,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        child: Container(),
      ),
      Expanded(
        child: Text(
          text.tr(),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        ),
      ),
    ],
  );
}
