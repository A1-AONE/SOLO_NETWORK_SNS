class UserProfileEntity {
  final List<String> aiTag;
  final String nickName;
  final String email;
  final bool isCanSpying;
  final String profileUrl;
  final String uid;

  const UserProfileEntity({
    required this.aiTag,
    required this.nickName,
    required this.email,
    required this.isCanSpying,
    required this.profileUrl,
    required this.uid,
  });
}
