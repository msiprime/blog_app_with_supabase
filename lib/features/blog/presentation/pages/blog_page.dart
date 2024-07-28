import 'package:capestone_test/core/common/widget/loader.dart';
import 'package:capestone_test/core/theme/app_pallete.dart';
import 'package:capestone_test/core/util/show_snackbar.dart';
import 'package:capestone_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:capestone_test/features/auth/presentation/pages/login_page.dart';
import 'package:capestone_test/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:capestone_test/features/blog/presentation/pages/add_blog_page.dart';
import 'package:capestone_test/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(const GetAllBlogsEvent());
    super.initState();
  }

  @override
  void dispose() {
    context.read<BlogBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        tilePadding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppPallete.gradient1,
              gradient: LinearGradient(
                colors: [
                  AppPallete.gradient1,
                  AppPallete.gradient2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),
            accountName: Text(
              'Msi Sakib',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text('msisakib958@gmail.com'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthBloc>().add(const AuthSignOutEvent());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Blog Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddBlogPage()),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context: context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is FetchBlogSuccess) {
            return ListView.builder(
              itemCount: state.allBlogs.length,
              itemBuilder: (context, index) {
                final blog = state.allBlogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 2 == 0
                      ? AppPallete.gradient1
                      : AppPallete.gradient2,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
