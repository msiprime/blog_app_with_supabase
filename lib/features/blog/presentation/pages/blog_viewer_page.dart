import 'package:capestone_test/core/common/widget/animation_wrapper.dart';
import 'package:capestone_test/core/common/widget/cached_network_image.dart';
import 'package:capestone_test/core/theme/app_pallete.dart';
import 'package:capestone_test/core/util/calculate_reading_time.dart';
import 'package:capestone_test/core/util/format_date.dart';
import 'package:capestone_test/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BlogViewerPage extends StatelessWidget {
  final BlogEntity blog;

  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().slideX(),
                  const SizedBox(height: 20),
                  Text(
                    'By ${blog.posterName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ).animate().slideX(),
                  const SizedBox(height: 5),
                  Text(
                    '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppPallete.greyColor,
                      fontSize: 16,
                    ),
                  ).animate().slideX(),
                  const SizedBox(height: 20),
                  CachedNetworkImage(imageUrl: blog.imageUrl),
                  const SizedBox(height: 20),
                  AnimatedWrapper(
                    child: Text(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
