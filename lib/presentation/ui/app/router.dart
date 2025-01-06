import 'package:go_router/go_router.dart';
import 'package:solo_network_sns/presentation/ui/login/login_page.dart';
import 'package:solo_network_sns/presentation/ui/setpage/setpage.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(
          path: 'set',
          builder: (context, state) => Setpage(),
        )
      ]
    ),
    /*GoRoute(
      path: '/',
      // builder: (context, state) => ,
      // routes: []
    )*/
  ]
);
