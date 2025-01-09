class UserEntity {
  List<String> aiTag;
  String nickName;
  String email;
  bool isCanSpying;
  String profileUrl;
  String uid;

  UserEntity({
    required this.aiTag,
    required this.nickName,
    required this.email,
    required this.isCanSpying,
    required this.profileUrl,
    required this.uid,
  });
}