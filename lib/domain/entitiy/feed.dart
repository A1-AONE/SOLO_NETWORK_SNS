import 'package:solo_network_sns/presentation/ui/feed/widgets/feed.dart';

class Feed {
  String UID;
  String contents;
  String createdAt;
  String goods;
  String imgUrl;
  List<String> tag;

  Feed({
    required this.UID,
    required this.contents,
    required this.createdAt,
    required this.goods,
    required this.imgUrl,
    required this.tag,
  });
}
