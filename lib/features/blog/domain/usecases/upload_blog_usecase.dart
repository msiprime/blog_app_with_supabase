import 'dart:io';

import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:capestone_test/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements UseCase<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUseCase({required this.blogRepository});

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      posterId: params.posterId,
      title: params.title,
      content: params.content,
      image: params.image,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
