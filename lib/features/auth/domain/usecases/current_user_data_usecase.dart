import 'package:capestone_test/core/common/entities/profile_entity.dart';
import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUsecase implements UseCase<ProfileEntity, NoParams> {
  final AuthRepository repository;

  CurrentUserUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    final result = await repository.currentUser();
    return result;
  }
}
