import 'package:capestone_test/features/auth/presentation/pages/login_page.dart';
import 'package:capestone_test/features/auth/presentation/pages/signup_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/add_blog_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:capestone_test/features/landing/landing_page.dart';
import 'package:go_router/go_router.dart';

import 'error_page.dart';

class AppRouter {
  AppRouter._privateConstructor();

  static final AppRouter _instance = AppRouter._privateConstructor();

  factory AppRouter() => _instance;

  GoRouter get router => GoRouter(
        debugLogDiagnostics: true,
        errorPageBuilder: (context, state) => ErrorPage(state: state).page,
        routes: [
          GoRoute(
            name: '/',
            path: '/',
            builder: (context, state) => const LandingPage(),
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
          GoRoute(
            name: 'login',
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
        ],
      );
}
