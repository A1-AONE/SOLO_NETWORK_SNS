class Feed {
  String id;
  String uid;
  String contents;
  DateTime createdAt;
  int goods;
  String imageUrl;
  List<String> tag;
  String ai;

  Feed({
    required this.id,
    required this.uid,
    required this.contents,
    required this.createdAt,
    required this.goods,
    required this.imageUrl,
    required this.tag,
    required this.ai,
  });
}
