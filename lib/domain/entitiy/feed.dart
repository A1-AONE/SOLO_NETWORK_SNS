class Feed {
  String id;
  String UID;
  String contents;
  DateTime createdAt;
  int goods;
  String imageUrl;
  List<String> tag;
  String AI;

  Feed({
    required this.id,
    required this.UID,
    required this.contents,
    required this.createdAt,
    required this.goods,
    required this.imageUrl,
    required this.tag,
    required this.AI,
  });
}
