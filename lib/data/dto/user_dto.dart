class UserDto {
  List<String> aiTag;
  String nickName;
  bool isCanSpying;
  String profileUrl;
  String uid;

  UserDto({required this.aiTag, required this.nickName, required this.isCanSpying, required this.profileUrl, required this.uid});

  UserDto.fromJson(Map<String,dynamic> json) : this(
    aiTag: (json['AITag'] as List).map((item) => item as String).toList(),
    nickName: json['Nickname'],
    isCanSpying: json['isCanSpying'],
    profileUrl: json['profileUrl'],
    uid: json['uid'],
  );
}