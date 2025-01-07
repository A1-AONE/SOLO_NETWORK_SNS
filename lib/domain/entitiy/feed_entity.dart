class FeedEntity {
  final String UID; // 게시글 고유 ID
  final String contents; // 게시글 내용
  final List<String> tags; // 태그 리스트
  final String? imagUrl; // Firebase Storage에 저장된 이미지 URL
  final String? createdAt; //feed 저장날짜
  final int? goods; //좋아요 갯수

  FeedEntity({
    required this.UID,
    required this.contents,
    required this.tags,
    this.imagUrl,
    required this.createdAt,
    required this.goods,
  });
}
