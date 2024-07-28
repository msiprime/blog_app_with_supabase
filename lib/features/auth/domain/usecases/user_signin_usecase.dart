import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/core/common/entities/profile_entity.dart';
import 'package:capestone_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignInUseCase implements UseCase<ProfileEntity, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignInUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, ProfileEntity>> call(params) async {
    return await authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
// Don't forget to do await here.
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
