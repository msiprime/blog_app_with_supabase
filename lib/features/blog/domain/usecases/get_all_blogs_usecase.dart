import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:capestone_test/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCase<List<BlogEntity>, NoParams> {
  BlogRepository blogRepository;

  GetAllBlogsUseCase({required this.blogRepository});

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    final result = await blogRepository.getAllBlogs();
    return result;
  }
}
