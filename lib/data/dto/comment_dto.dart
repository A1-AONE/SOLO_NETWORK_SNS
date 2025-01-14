class CommentDto {
  final String ai;
  final String comment;
  final String createdAt;
  final String feedId;
  final String goods;
  final String userId;

  CommentDto({
    required this.ai,
    required this.comment,
    required this.createdAt,
    required this.feedId,
    required this.goods,
    required this.userId,
  });

  CommentDto.fromJson(Map<String, dynamic> json)
      : this(
          ai: json['AI'],
          comment: json['comment'],
          createdAt: json['createdAt'],
          feedId: json['feed_id'],
          goods: json['goods'],
          userId: json['user_id'],
        );

  Map<String, dynamic> toJson() {
    return {
      'AI': ai,
      'comment': comment,
      'createdAt': createdAt,
      'feed_id': feedId,
      'goods': goods,
      'user_id': userId,
    };
  }

  CommentDto copyWith({
    String? ai,
    String? comment,
    String? createdAt,
    String? feedId,
    String? goods,
    String? userId,
  }) =>
      CommentDto(
        ai: this.ai,
        comment: this.comment,
        createdAt: this.createdAt,
        feedId: this.feedId,
        goods: this.goods,
        userId: this.userId,
      );
}
