part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class FetchBlogSuccess extends BlogState {
  final List<BlogEntity> allBlogs;

  FetchBlogSuccess({required this.allBlogs});
}

final class UploadBlogSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}
