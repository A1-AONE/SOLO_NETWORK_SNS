

class FeedDto {
  String UID;
  String contents;
  String createdAt;
  String goods;
  String imgUrl;
  List<String> tag;

  FeedDto({
    required this.UID,
    required this.contents,
    required this.createdAt,
    required this.goods,
    required this.imgUrl,
    required this.tag,
  });

  FeedDto.fromJson(Map<String, dynamic> json)
    : this (
      UID: json['UID'],
      contents: json['contents'],
      createdAt:  json['createdAt'],
      goods: json['goods'],
      imgUrl: json['imgUrl'],
      tag: json['tag'],
    );

  Map<String, dynamic> toJson(){
    return{
      'UID': UID,
      'contents': contents,
      'createdAt': createdAt,
      'goods': goods,
      'imgUrl': imgUrl,
      'tag': tag,
    };
  }

  FeedDto copyWith({
    String? UID,
    String? contents,
    String? createdAt,
    String? goods,
    String? imgUrl,
    List<String>? tag,
  }) =>
      FeedDto(
        UID: this.UID,
        contents: this.contents,
        createdAt: this.createdAt,
        goods: this.goods,
        imgUrl: this.imgUrl,
        tag: this.tag,
      );




}
