import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/create_page/create_page.dart';
import 'package:solo_network_sns/presentation/ui/detail/detail.dart';
import 'package:solo_network_sns/presentation/ui/feed/feed_page.dart';
import 'package:solo_network_sns/presentation/ui/home_tap/home_tap.dart';
import 'package:solo_network_sns/presentation/ui/login/login_page.dart';
import 'package:solo_network_sns/presentation/ui/setpage/setpage.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(
          path: 'set',
          builder: (context, state) => Setpage(),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeTap(),
      routes: [
        GoRoute(
          path: 'feed',
          builder: (context, state) => Detail(),
        ),
        GoRoute(
          path: 'create',
          builder: (context, state) => CreatePage(),
        ),
      ],
    ),
  ],
);
