class FeedDto {
  String id;
  String uid;
  String contents;
  DateTime createdAt;
  int goods;
  String imageUrl;
  List<String> tag;
  String ai;

  FeedDto({
    required this.id,
    required this.uid,
    required this.contents,
    required this.createdAt,
    required this.goods,
    required this.imageUrl,
    required this.tag,
    required this.ai,
  });

  FeedDto.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          uid: json['UID'],
          contents: json['contents'] ?? '',
          createdAt: json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime(1970),
          goods: json['goods'] ?? 0,
          imageUrl: json['imageUrl'] ?? '',
          tag: json['tag'] ?? [],
          ai: json['AI'] ?? [],
        );

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'UID': uid,
      'contents': contents,
      'createdAt': createdAt.toIso8601String(),
      'goods': goods,
      'imageUrl': imageUrl,
      'tag': tag,
      'AI': ai,
    };
  }

  FeedDto copyWith({
    String? id,
    String? uid,
    String? contents,
    String? createdAt,
    int? goods,
    String? imageUrl,
    List<String>? tag,
    String? ai,
  }) =>
      FeedDto(
        id: this.id,
        uid: this.uid,
        contents: this.contents,
        createdAt: this.createdAt,
        goods: this.goods,
        imageUrl: this.imageUrl,
        tag: this.tag,
        ai: this.ai,
      );
}
