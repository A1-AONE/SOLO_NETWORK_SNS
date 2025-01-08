import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/create_page/create_page.dart';
import 'package:solo_network_sns/presentation/ui/detail/detail.dart';
import 'package:solo_network_sns/presentation/ui/feed/feed_page.dart';
import 'package:solo_network_sns/presentation/ui/home_tap/home_tap.dart';
import 'package:solo_network_sns/presentation/ui/login/login_page.dart';
import 'package:solo_network_sns/presentation/ui/my_page/my_page.dart';
import 'package:solo_network_sns/presentation/ui/setpage/setpage.dart';
import 'package:solo_network_sns/presentation/ui/splash/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(path: 'set', builder: (context, state) => SetPage()),
      ],
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeTap(),
      routes: [
        GoRoute(
          path: 'feed/:feedId',
          builder: (context, state) {
            final FeedId = state.pathParameters['feedId'];
            return Detail(feedId: FeedId!);
          },
        ),
        GoRoute(
          path: 'create',
          builder: (context, state) => CreatePage(),
        ),
        GoRoute(
          path: 'mypage',
          builder: (context, state) => MyPage(),
        )
      ],
    ),
  ],
);
