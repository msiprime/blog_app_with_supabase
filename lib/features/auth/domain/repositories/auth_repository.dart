import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/common/entities/profile_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, ProfileEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, ProfileEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> signOut();

  Future<Either<Failure, ProfileEntity>> currentUser();
}
