class TuyauxModel {
  String authorName;
  String authorEmail;
  String tuyauID;
  String imgUrl;
  String univ;
  String fac;
  String promo;
  String title;
  String academicyear;
  String session;
  String serie;
  String suite;
  dynamic time;
  bool isPDF;
  dynamic size;
  TuyauxModel({
    required this.authorName,
    required this.authorEmail,
    required this.tuyauID,
    required this.imgUrl,
    required this.univ,
    required this.fac,
    required this.promo,
    required this.title,
    required this.academicyear,
    required this.session,
    required this.serie,
    required this.suite,
    required this.size,
    required this.isPDF,
    this.time,
  });
}
