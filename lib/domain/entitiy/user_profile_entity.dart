class UserProfileEntity {
  final List<String> aiTag;
  final String nickName;
  final String? profileUrl;
  final String uid;

  const UserProfileEntity({
    required this.aiTag,
    required this.nickName,
    this.profileUrl,
    required this.uid,
  });
  Map<String, dynamic> toJson() {
    return {
      'AITag': aiTag,
      'Nickname': nickName,
      'profileUrl': profileUrl,
      'uid': uid,
    };
  }
}
