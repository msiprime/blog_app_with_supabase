import 'dart:io';

import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  });

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();



}
