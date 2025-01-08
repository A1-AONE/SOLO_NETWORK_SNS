class FeedDto {
  // String id;
  String UID;
  String contents;
  DateTime createdAt;
  int goods;
  String imageUrl;
  List<String> tag;
  String AI;

  FeedDto({
    // required this.id,
    required this.UID,
    required this.contents,
    required this.createdAt,
    required this.goods,
    required this.imageUrl,
    required this.tag,
    required this.AI,
  });

  FeedDto.fromJson(Map<String, dynamic> json)
      : this(
          // id: json['id'],
          UID: json['UID'],
          contents: json['contents'] ?? '',
          createdAt: json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime(1970),
          goods: json['goods'] ?? 0,
          imageUrl: json['imageUrl'] ?? '',
          tag: json['tag'] ?? [],
          AI: json['AI'] ?? [],
        );

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'UID': UID,
      'contents': contents,
      'createdAt': createdAt.toIso8601String(),
      'goods': goods,
      'imageUrl': imageUrl,
      'tag': tag,
      'AI': AI,
    };
  }

  FeedDto copyWith({
    // String? id,
    String? UID,
    String? contents,
    String? createdAt,
    int? goods,
    String? imageUrl,
    List<String>? tag,
    String? AI,
  }) =>
      FeedDto(
        // id: this.id,
        UID: this.UID,
        contents: this.contents,
        createdAt: this.createdAt,
        goods: this.goods,
        imageUrl: this.imageUrl,
        tag: this.tag,
        AI: this.AI,
      );
}
