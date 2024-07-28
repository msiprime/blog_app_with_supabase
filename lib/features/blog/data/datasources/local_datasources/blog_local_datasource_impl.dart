import 'package:capestone_test/features/blog/data/datasources/local_datasources/blog_local_datasource.dart';
import 'package:capestone_test/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  Box box;

  BlogLocalDataSourceImpl({
    required this.box,
  });

  @override
  void cacheBlogs({required List<BlogModel> blogs}) {
    box.clear();

    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }

  @override
  List<BlogModel> getCachedBlogs() {
    final List<BlogModel> blogs = [];

    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });

    return blogs;
  }
}
