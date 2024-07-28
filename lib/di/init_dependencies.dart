import 'package:capestone_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:capestone_test/core/network/connection_checker.dart';
import 'package:capestone_test/core/secret/app_secrets.dart';
import 'package:capestone_test/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:capestone_test/features/auth/data/datasources/auth_supabase_datasource_impl.dart';
import 'package:capestone_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:capestone_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:capestone_test/features/auth/domain/usecases/current_user_data_usecase.dart';
import 'package:capestone_test/features/auth/domain/usecases/user_signin_usecase.dart';
import 'package:capestone_test/features/auth/domain/usecases/user_signout_usecase.dart';
import 'package:capestone_test/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:capestone_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:capestone_test/features/blog/data/datasources/local_datasources/blog_local_datasource.dart';
import 'package:capestone_test/features/blog/data/datasources/local_datasources/blog_local_datasource_impl.dart';
import 'package:capestone_test/features/blog/data/datasources/remote_datasources/blog_remote_datasource.dart';
import 'package:capestone_test/features/blog/data/datasources/remote_datasources/blog_remote_datasource_impl.dart';
import 'package:capestone_test/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:capestone_test/features/blog/domain/repositories/blog_repository.dart';
import 'package:capestone_test/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:capestone_test/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:capestone_test/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final supaBase = await Supabase.initialize(
    url: AppSecrets.supaBaseUrl,
    anonKey: AppSecrets.supaAnonKey,
  );

  serviceLocator.registerLazySingleton(
    () => supaBase.client,
  );

  // Core
  serviceLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );

  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );

  serviceLocator
      .registerFactory<InternetConnection>(() => InternetConnection());

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blog'));
  _initAuth();
  _initBlog();
}

void _initAuth() {
  serviceLocator.registerLazySingleton<AuthSupabaseDatasource>(
    () => AuthSupabaseDatasourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
  );

  // UseCases
  // UserSignUpUseCase
  serviceLocator.registerLazySingleton(
    () => UserSignUpUseCase(
      authRepository: serviceLocator(),
    ),
  );
  // UserSignInUseCase
  serviceLocator.registerLazySingleton(
    () => UserSignInUseCase(
      authRepository: serviceLocator(),
    ),
  );
  // UserSignOutUseCase
  serviceLocator.registerLazySingleton(
    () => UserSignOutUseCase(
      authRepository: serviceLocator(),
    ),
  );
  // CurrentUserDataUsecase
  serviceLocator.registerLazySingleton(
    () => CurrentUserUsecase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => AuthBloc(
      userSignUpUseCase: serviceLocator(),
      userSignInUseCase: serviceLocator(),
      userSignOutUseCase: serviceLocator(),
      currentUserDataUsecase: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  // Blog
  serviceLocator.registerLazySingleton<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );

  // local DataSource

  serviceLocator.registerLazySingleton<BlogLocalDataSource>(
    () => BlogLocalDataSourceImpl(
      box: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<BlogRepository>(
    () => BlogRepositoryImpl(
      blogLocalDataSource: serviceLocator(),
      connectionChecker: serviceLocator(),
      blogRemoteDataSource: serviceLocator(),
    ),
  );

  // UseCases
  // UploadBlogUseCase
  serviceLocator.registerLazySingleton(
    () => UploadBlogUseCase(
      blogRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetAllBlogsUseCase(
      blogRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => BlogBloc(
      uploadBlogUseCase: serviceLocator(),
      getAllBlogsUseCase: serviceLocator(),
    ),
  );
}
