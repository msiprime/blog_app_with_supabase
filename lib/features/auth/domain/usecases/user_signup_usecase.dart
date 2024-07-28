import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/core/common/entities/profile_entity.dart';
import 'package:capestone_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUseCase implements UseCase<ProfileEntity, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUpUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, ProfileEntity>> call(params) async {
    return await authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
  // Don't forget to do await here.
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
