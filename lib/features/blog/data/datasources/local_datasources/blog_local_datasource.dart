import 'package:capestone_test/features/blog/data/models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void cacheBlogs({required List<BlogModel> blogs});

  List<BlogModel> getCachedBlogs();
}
