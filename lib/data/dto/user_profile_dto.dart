import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';

class UserProfileDto {
  final List<String>? aiTag;
  final String? nickName;
  final String? email;
  final bool? isCanSpying;
  final String? profileUrl; // nullable로 변경
  final String? uid;

  UserProfileDto({
    required this.aiTag,
    required this.nickName,
    required this.email,
    required this.isCanSpying,
    required this.profileUrl, // nullable 필드
    required this.uid,
  });

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return UserProfileDto(
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
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      aiTag: aiTag,
      nickName: nickName,
      profileUrl: profileUrl ?? '', // null인 경우 빈 문자열로 변환
      uid: uid,
      email: email,
      isCanSpying: isCanSpying,
    );
  }

  // Entity에서 DTO로 변환
  factory UserProfileDto.fromEntity(UserProfileEntity entity) {
    return UserProfileDto(
      aiTag: entity.aiTag,
      nickName: entity.nickName,
      profileUrl: entity.profileUrl,
      uid: entity.uid,
      email: entity.email,
      isCanSpying: entity.isCanSpying,
    );
  }
}
