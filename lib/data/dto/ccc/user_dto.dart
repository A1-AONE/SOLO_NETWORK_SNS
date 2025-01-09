import 'package:solo_network_sns/domain/entitiy/ccc/user_entity.dart';

class UserDto {
  final List<String> aiTag;
  final String nickName;
  final String email;
  final bool isCanSpying;
  final String? profileUrl; // nullable로 변경
  final String uid;

  UserDto({
    required this.aiTag,
    required this.nickName,
    required this.email,
    required this.isCanSpying,
    this.profileUrl, // nullable 필드
    required this.uid,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      aiTag: (json['AITag'] as List).map((item) => item as String).toList(),
      nickName: json['Nickname'],
      email: json['email'],
      isCanSpying: json['isCanSpying'],
      profileUrl: json['profileUrl'], // nullable 처리 (기본값 없음)
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AITag': aiTag,
      'Nickname': nickName,
      'email': email,
      'isCanSpying': isCanSpying,
      'profileUrl': profileUrl ?? '', // null인 경우 빈 문자열 전송
      'uid': uid,
    };
  }

  // DTO에서 Entity로 변환
  UserEntity toEntity() {
    return UserEntity(
      aiTag: aiTag,
      nickName: nickName,
      email: email,
      isCanSpying: isCanSpying,
      profileUrl: profileUrl ?? '', // null인 경우 빈 문자열로 변환
      uid: uid,
    );
  }

  // Entity에서 DTO로 변환
  factory UserDto.fromEntity(UserEntity entity) {
    return UserDto(
      aiTag: entity.aiTag,
      nickName: entity.nickName,
      email: entity.email,
      isCanSpying: entity.isCanSpying,
      profileUrl: entity.profileUrl.isNotEmpty
          ? entity.profileUrl
          : null, // 빈 문자열을 null로 처리
      uid: entity.uid,
    );
  }
}
