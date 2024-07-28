import 'dart:async';
import 'dart:io';

import 'package:capestone_test/core/error/exceptions.dart';
import 'package:capestone_test/core/usecase/usecase.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:capestone_test/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:capestone_test/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;

  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
    required GetAllBlogsUseCase getAllBlogsUseCase,
  })  : _uploadBlogUseCase = uploadBlogUseCase,
        _getAllBlogsUseCase = getAllBlogsUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogEvent>(_onUploadBlogEvent);
    on<GetAllBlogsEvent>(_onGetAllBlogsEvent);
  }

  FutureOr<void> _onUploadBlogEvent(
    UploadBlogEvent event,
    Emitter<BlogState> emit,
  ) async {
    final params = UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    );

    try {
      final result = await _uploadBlogUseCase(params);
      result.fold(
        (failure) => emit(BlogFailure(message: failure.message)),
        (blogEntity) => emit(UploadBlogSuccess()),
      );
    } on ServerException catch (e) {
      emit(BlogFailure(message: e.message));
    } catch (e) {
      emit(BlogFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onGetAllBlogsEvent(
    GetAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    try {
      final response = await _getAllBlogsUseCase.call(NoParams());

      response.fold(
        (left) => emit(BlogFailure(message: left.message)),
        (right) => emit(FetchBlogSuccess(allBlogs: right)),
      );
    } on ServerException catch (e) {
      emit(BlogFailure(message: e.message));
    } catch (e) {
      emit(BlogFailure(message: e.toString()));
    }
  }
}
