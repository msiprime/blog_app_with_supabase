import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage {
  final GoRouterState state;

  const ErrorPage({required this.state});

  Page<dynamic> get page {
    return errorPage();
  }

  Page<dynamic> errorPage() {
    return MaterialPage(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${state.error}'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
