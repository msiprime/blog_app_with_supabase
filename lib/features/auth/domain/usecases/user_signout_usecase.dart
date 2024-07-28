import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOutUseCase implements UseCase<void, void> {
  final AuthRepository authRepository;

  UserSignOutUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(_) async {
    return await authRepository.signOut();
  }
}
