class FeedDto {
  String UID;
  String contents;
  String createdAt;
  String goods;
  String imgUrl;
  List<String> tag;
  String AI;

  FeedDto({
    required this.UID,
    required this.contents,
    required this.createdAt,
    required this.goods,
    required this.imgUrl,
    required this.tag,
    required this.AI,
  });

  FeedDto.fromJson(Map<String, dynamic> json)
      : this(
          UID: json['UID'],
          contents: json['contents'],
          createdAt: json['createdAt'],
          goods: json['goods'],
          imgUrl: json['imgUrl'],
          tag: json['tag'],
          AI: json['AI'],
        );

  Map<String, dynamic> toJson() {
    return {
      'UID': UID,
      'contents': contents,
      'createdAt': createdAt,
      'goods': goods,
      'imgUrl': imgUrl,
      'tag': tag,
      'AI': AI,
    };
  }

  FeedDto copyWith({
    String? UID,
    String? contents,
    String? createdAt,
    String? goods,
    String? imgUrl,
    List<String>? tag,
    String? AI,
  }) =>
      FeedDto(
        UID: this.UID,
        contents: this.contents,
        createdAt: this.createdAt,
        goods: this.goods,
        imgUrl: this.imgUrl,
        tag: this.tag,
        AI: this.AI,
      );
}
