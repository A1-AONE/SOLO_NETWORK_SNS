class AiEntity {
  final String ai;
  final String nickName;
  final String profileUrl;

  AiEntity({required this.ai, required this.nickName, required this.profileUrl});

  AiEntity.fromJson(Map<String, dynamic> json) : this (
    ai: json['AI'],
    nickName: json['Nickname'],
    profileUrl: json['profileUrl']
  );
}