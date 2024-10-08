import 'package:capestone_test/core/common/bloc/base_bloc.dart';
import 'package:capestone_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:capestone_test/di/init_dependencies.dart';
import 'package:capestone_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:capestone_test/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc_testground/hydrated_bloc_testground.dart';

class GlobalBlocProviders {
  GlobalBlocProviders._privateInstance();

  static final GlobalBlocProviders _instance =
      GlobalBlocProviders._privateInstance();

  factory GlobalBlocProviders() => _instance;

  static dynamic getProviders() {
    dynamic providers = [
      BlocProvider<HydratedThemeBloc>(
        create: (context) => serviceLocator<HydratedThemeBloc>(),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider<BaseBloc>(
        create: (context) => serviceLocator<BaseBloc>(),
      ),
      BlocProvider<BlogBloc>(
        create: (context) => serviceLocator<BlogBloc>(),
      ),
      BlocProvider<AppUserCubit>(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
    ];
    return providers;
  }
}
