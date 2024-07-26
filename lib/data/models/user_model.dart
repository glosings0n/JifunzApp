class UserModel {
  String? name;
  String? email;
  String? imgUrl;
  String? univ;
  String? fac;
  String? promo;
  dynamic fCMToken;
  List courses;
  UserModel({
    this.name,
    this.email,
    this.imgUrl,
    this.univ,
    this.fac,
    this.promo,
    this.fCMToken,
    required this.courses,
  });
}
