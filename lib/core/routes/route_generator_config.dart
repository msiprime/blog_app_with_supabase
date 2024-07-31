import 'package:capestone_test/core/routes/app_routes.dart';
import 'package:capestone_test/core/routes/error_page.dart';
import 'package:capestone_test/features/auth/presentation/pages/login_page.dart';
import 'package:capestone_test/features/auth/presentation/pages/signup_page.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:capestone_test/features/blog/presentation/pages/add_blog_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:capestone_test/features/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._privateConstructor();

  static final AppRouter _instance = AppRouter._privateConstructor();

  factory AppRouter() => _instance;

  GoRoute _transitionThemedGoRoute({
    required String name,
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    List<RouteBase> routes = const [],
  }) =>
      GoRoute(
        routes: routes,
        name: name,
        path: path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: builder(context, state),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          ),
        ),
      );

  GoRouter get router => GoRouter(
        // debugLogDiagnostics: true,
        errorPageBuilder: (context, state) => ErrorPage(state: state).page,
        routes: [
          _transitionThemedGoRoute(
            name: AppRoutes.landing,
            path: AppRoutes.landing,
            builder: (context, state) => const LandingPage(),
          ),
          _transitionThemedGoRoute(
            name: AppRoutes.blogPage,
            path: AppRoutes.blogPage,
            builder: (context, state) => const BlogPage(),
            routes: [
              _transitionThemedGoRoute(
                name: AppRoutes.addBlog,
                path: AppRoutes.addBlog,
                builder: (context, state) => const AddBlogPage(),
              ),
              _transitionThemedGoRoute(
                name: AppRoutes.blogDetails,
                path: AppRoutes.blogDetails,
                builder: (context, state) =>
                    BlogViewerPage(blog: state.extra as BlogEntity),
              ),
            ],
          ),
          _transitionThemedGoRoute(
            path: AppRoutes.signUp,
            name: AppRoutes.signUp,
            builder: (context, state) => const SignUpPage(),
          ),
          _transitionThemedGoRoute(
            path: AppRoutes.login,
            name: AppRoutes.login,
            builder: (context, state) => const LoginPage(),
          ),
        ],
      );
}
