class AiDto {
  final String ai;
  final String nickName;
  final String profileUrl;

  AiDto({required this.ai, required this.nickName, required this.profileUrl});

  AiDto.fromJson(Map<String, dynamic> json) : this (
    ai: json['AI'],
    nickName: json['Nickname'],
    profileUrl: json['profileUrl']
  );
}