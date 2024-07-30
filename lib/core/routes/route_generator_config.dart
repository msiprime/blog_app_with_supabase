import 'package:capestone_test/features/auth/presentation/pages/login_page.dart';
import 'package:capestone_test/features/auth/presentation/pages/signup_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:go_router/go_router.dart';

import 'error_page.dart';

class AppRouter {
  final bool isUserLoggedIn;

  const AppRouter({required this.isUserLoggedIn});

  GoRouter routingMethod() {
    final router = GoRouter(
      errorPageBuilder: (context, state) => ErrorPage(state: state).page,
      redirect: (context, state) {
        if (!isUserLoggedIn) {
          return '/';
        } else if (isUserLoggedIn) {
          return '/home';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => BlogPage(),
          routes: [],
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => SignUpPage(),
        ),
      ],
    );

    return router;
  }
}
