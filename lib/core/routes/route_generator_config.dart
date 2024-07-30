import 'package:capestone_test/features/auth/presentation/pages/login_page.dart';
import 'package:capestone_test/features/auth/presentation/pages/signup_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/add_blog_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:go_router/go_router.dart';

import 'error_page.dart';

class AppRouter {
  bool _isUserLoggedIn;

  AppRouter._privateConstructor(this._isUserLoggedIn);

  static final AppRouter _instance = AppRouter._privateConstructor(false);

  factory AppRouter() => _instance;

  void updateLoginStatus(bool isUserLoggedIn) {
    _isUserLoggedIn = isUserLoggedIn;
  }

  GoRouter get router => GoRouter(
        errorPageBuilder: (context, state) => ErrorPage(state: state).page,
        redirect: (context, state) {
          if (!_isUserLoggedIn) {
            return '/';
          } else if (_isUserLoggedIn) {
            return '/home';
          }
          return null;
        },
        routes: [
          GoRoute(
            name: 'login',
            path: '/',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            name: 'home',
            path: '/home',
            builder: (context, state) => const BlogPage(),
            routes: [
              GoRoute(
                name: 'addBlog',
                path: 'addBlog',
                builder: (context, state) => const AddBlogPage(),
              ),
            ],
          ),
          GoRoute(
            name: 'signup',
            path: '/signup',
            builder: (context, state) => const SignUpPage(),
          ),
        ],
      );
}
