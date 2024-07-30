import 'package:capestone_test/core/routes/app_routes.dart';
import 'package:capestone_test/features/auth/presentation/pages/login_page.dart';
import 'package:capestone_test/features/auth/presentation/pages/signup_page.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:capestone_test/features/blog/presentation/pages/add_blog_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:capestone_test/features/landing/landing_page.dart';
import 'package:go_router/go_router.dart';

import 'error_page.dart';

class AppRouter {
  AppRouter._privateConstructor();

  static final AppRouter _instance = AppRouter._privateConstructor();

  factory AppRouter() => _instance;

  GoRouter get router => GoRouter(
        // debugLogDiagnostics: true,
        errorPageBuilder: (context, state) => ErrorPage(state: state).page,
        routes: [
          GoRoute(
            name: AppRoutes.landing,
            path: AppRoutes.landing,
            builder: (context, state) => const LandingPage(),
          ),
          GoRoute(
            name: AppRoutes.blogPage,
            path: AppRoutes.blogPage,
            builder: (context, state) => const BlogPage(),
            routes: [
              GoRoute(
                name: AppRoutes.addBlog,
                path: AppRoutes.addBlog,
                builder: (context, state) => const AddBlogPage(),
              ),
              GoRoute(
                name: AppRoutes.blogDetails,
                path: AppRoutes.blogDetails,
                builder: (context, state) =>
                    BlogViewerPage(blog: state.extra as BlogEntity),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.signUp,
            path: AppRoutes.signUp,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            name: AppRoutes.login,
            path: AppRoutes.login,
            builder: (context, state) => const LoginPage(),
          ),
        ],
      );
}
