import 'package:capestone_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:capestone_test/core/theme/theme.dart';
import 'package:capestone_test/di/global_bloc_providers.dart';
import 'package:capestone_test/di/init_dependencies.dart';
import 'package:capestone_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/route_generator_config.dart';

void main() async {
  await initDependencies();
  Animate.restartOnHotReload = true;
  runApp(
    MultiBlocProvider(
      providers: GlobalBlocProviders.getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(const AuthIsUserLoggedInEvent());
    print('triggeringgggggg Auth Is User Logged In Event');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.darkThemeMode,
          routerConfig: AppRouter(isUserLoggedIn: state).routingMethod(),
        );
      },
    );
  }
}

//   home: BlocSelector<AppUserCubit, AppUserState, bool>(
//         selector: (state) {
//           return state is AppUserLoggedIn;
//         },
//         builder: (context, isUserLoggedIn) {
//           return isUserLoggedIn ? const BlogPage() : const LoginPage();
//         },
//       ),
