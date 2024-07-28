import 'dart:io';

import 'package:capestone_test/core/error/exceptions.dart';
import 'package:capestone_test/core/error/failures.dart';
import 'package:capestone_test/core/network/connection_checker.dart';
import 'package:capestone_test/features/blog/data/datasources/local_datasources/blog_local_datasource.dart';
import 'package:capestone_test/features/blog/data/datasources/remote_datasources/blog_remote_datasource.dart';
import 'package:capestone_test/features/blog/data/models/blog_model.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:capestone_test/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl({
    required this.connectionChecker,
    required this.blogLocalDataSource,
    required this.blogRemoteDataSource,
  });

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure('No internet connection'));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v4(),
        posterId: posterId,
        title: title,
        content: content,
        topics: topics,
        imageUrl: '',
        updatedAt: DateTime.now(),
      );
      final finalBlogModel = await blogRemoteDataSource
          .uploadBlogImage(blog: blogModel, image: image)
          .then((imageUrl) => blogModel.copyWith(imageUrl: imageUrl))
          .then(
            (blogModel) => blogRemoteDataSource.uploadBlog(blog: blogModel),
          );
      return right(finalBlogModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final cachedBlogs = blogLocalDataSource.getCachedBlogs();
        return Right(cachedBlogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();

      blogLocalDataSource.cacheBlogs(blogs: blogs);

      return Right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
