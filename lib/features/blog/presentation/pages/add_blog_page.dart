import 'dart:io';

import 'package:capestone_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:capestone_test/core/common/widget/custom_painters/dotted_border_painter.dart';
import 'package:capestone_test/core/common/widget/loader.dart';
import 'package:capestone_test/core/theme/app_pallete.dart';
import 'package:capestone_test/core/util/pick_image.dart';
import 'package:capestone_test/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:capestone_test/features/blog/presentation/pages/blog_page.dart';
import 'package:capestone_test/features/blog/presentation/widgets/blog_editor.dart';
import 'package:capestone_test/features/blog/presentation/widgets/choice_chip_list_view.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final List<String> selectedTopics = [];
  final formKey = GlobalKey<FormState>();
  File? image;

  void selectedImage() async {
    final pickedImage = await pickImage();
    // if (pickedImage != null) {
    setState(() {
      image = pickedImage;
    });
    // }
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add_outlined),
            onPressed: () {
              if (formKey.currentState!.validate() &&
                  image != null &&
                  selectedTopics.isNotEmpty) {
                final posterId =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .profileEntity
                        .id;

                context.read<BlogBloc>().add(
                      UploadBlogEvent(
                        posterId: posterId,
                        title: _titleController.text,
                        content: _contentController.text,
                        topics: selectedTopics,
                        image: image!,
                      ),
                    );
                // Upload the blog
              }
              // Save the blog
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is UploadBlogSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Blog Uploaded Successfully'),
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const BlogPage()),
                (route) => false,
              );
            } else if (state is BlogFailure) {
              if (kDebugMode) {
                print(state.message);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    _buildSelectImageButton(),
                    const Gap(20),
                    _buildFilterChips(),
                    const Gap(20),
                    BlogEditor(
                      hintText: 'Blog Title',
                      controller: _titleController,
                    ),
                    const Gap(20),
                    BlogEditor(
                      hintText: 'Blog Content',
                      controller: _contentController,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FilterChipListView _buildFilterChips() {
    return FilterChipListView(
      chipLabels: const [
        'Business',
        'Technology',
        'Programming',
        'Entertainment',
      ],
      selectedLabelsNotifier: ValueNotifier(selectedTopics.toSet()),
      onSelected: (value) {
        selectedTopics.clear();
        selectedTopics.addAll(value);
        if (kDebugMode) {
          print(selectedTopics);
        }
      },
    );
  }

  Widget _buildSelectImageButton() {
    return GestureDetector(
      onTap: () {
        selectedImage();
      },
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: AppPallete.borderColor,
          strokeWidth: 2.0,
          dashWidth: 10.0,
          dashGap: 5.0,
        ),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: image == null
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 35,
                    ),
                    Gap(15),
                    Text(
                      'Select Your Image',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
