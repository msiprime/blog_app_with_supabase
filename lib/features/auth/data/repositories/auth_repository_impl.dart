import 'dart:async' show Future, FutureOr;

import 'package:capestone_test/core/error/exceptions.dart';
import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/network/connection_checker.dart';
import 'package:capestone_test/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:capestone_test/features/auth/data/models/profile_model.dart';
import 'package:capestone_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDatasource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, ProfileModel>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentSessionKey;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(
          ProfileModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> signIn({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signIn(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, ProfileModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, ProfileModel>> _getUser(
    Future<ProfileModel> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        if (kDebugMode) {
          print('No internet connection');
        }
        return left(Failure('No internet connection'));
      }
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      FutureOr<void> response = remoteDataSource.signOut();
      return right('Sign out successful $response');
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    } on AuthException catch (e) {
      return left(
        Failure(e.message),
      );
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }
}
