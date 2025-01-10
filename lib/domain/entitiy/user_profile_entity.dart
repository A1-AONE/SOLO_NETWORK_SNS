class UserProfileEntity {
  final List<String>? aiTag;
  final String? nickName;
  final String? profileUrl;
  final String? uid;
  final String? email;
  final bool? isCanSpying;

  const UserProfileEntity({
    required this.aiTag,
    required this.nickName,
    this.profileUrl,
    required this.uid,
    required this.email,
    required this.isCanSpying,
  });
  Map<String, dynamic> toJson() {
    return {
      'AITag': aiTag,
      'Nickname': nickName,
      'profileUrl': profileUrl,
      'uid': uid,
      'email': email,
      'isCanSpying': isCanSpying,
    };
  }
}
