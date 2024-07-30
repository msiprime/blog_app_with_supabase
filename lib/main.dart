import 'package:capestone_test/core/theme/theme.dart';
import 'package:capestone_test/di/global_bloc_providers.dart';
import 'package:capestone_test/di/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/bloc_observer.dart';
import 'core/routes/route_generator_config.dart';

void main() async {
  await initDependencies();

  Bloc.observer = GlobalBlocObserver();
  Animate.restartOnHotReload = true;
  runApp(
    MultiBlocProvider(
      providers: GlobalBlocProviders.getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      routerConfig: AppRouter().router,
    );
  }
}
