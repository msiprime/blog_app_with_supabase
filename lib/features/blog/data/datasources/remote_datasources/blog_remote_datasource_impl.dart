import 'dart:io';

import 'package:capestone_test/core/error/exceptions.dart';
import 'package:capestone_test/features/blog/data/datasources/remote_datasources/blog_remote_datasource.dart';
import 'package:capestone_test/features/blog/data/models/blog_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final blogData =
          await supabaseClient.from('blogs2').insert(blog.toJson()).select('*');
      if (kDebugMode) {
        print(blogData.first);
      }
      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_image2').upload(
            blog.id,
            image,
          );

      return supabaseClient.storage.from('blog_image2').getPublicUrl(blog.id);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogData =
          await supabaseClient.from('blogs2').select('*, profiles (name)');
      if (kDebugMode) {
        print(blogData);
      }
      final response = blogData
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              posterName: blog['profiles']['name'],
            ),
          )
          .toList();
      return response;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
