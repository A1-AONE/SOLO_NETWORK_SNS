class CommentDto {
  final String comment;
  final String createdAt;
  final String feed_id;
  final String goods;
  final String user_id;

  CommentDto({
    required this.comment,
    required this.createdAt,
    required this.feed_id,
    required this.goods,
    required this.user_id,
  });

  CommentDto.fromJson(Map<String, dynamic> json)
      : this(
          comment: json['comment'],
          createdAt: json['createdAt'],
          feed_id: json['feed_id'],
          goods: json['goods'],
          user_id: json['user_id'],
        );

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'createdAt': createdAt,
      'feed_id': feed_id,
      'goods': goods,
      'user_id': user_id,
    };
  }

  CommentDto copyWith({
    String? comment,
    String? createdAt,
    String? feed_id,
    String? goods,
    String? user_id,
  }) =>
      CommentDto(
        comment: this.comment,
        createdAt: this.createdAt,
        feed_id: this.feed_id,
        goods: this.goods,
        user_id: this.user_id,
      );
}
