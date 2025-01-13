class UserDto {
  List<String> aiTag;
  String nickName;
  String email;
  bool isCanSpying;
  String profileUrl;
  String uid;

  UserDto({
    required this.aiTag,
    required this.nickName,
    required this.email,
    required this.isCanSpying,
    required this.profileUrl,
    required this.uid,
  });

  UserDto.fromJson(Map<String,dynamic> json) : this(
    aiTag: (json['AITag'] as List).map((item) => item as String).toList(),
    nickName: json['Nickname'],
    email: json['email'],
    isCanSpying: json['isCanSpying'],
    profileUrl: json['profileUrl'],
    uid: json['uid'],
  );

  Map<String, dynamic> toJson() {
    return {
      'aiTag': aiTag,
      'nickName': nickName,
      'email': email,
      'isCanSpying': isCanSpying,
      'profileUrl': profileUrl,
      'uid': uid,
    };
  }
}
