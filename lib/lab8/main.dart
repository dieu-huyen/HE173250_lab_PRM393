
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model đại diện cho một bài viết.
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Chuyển JSON thành đối tượng Post.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

void main() {
  runApp(const Lab82App());
}

class Lab82App extends StatelessWidget {
  const Lab82App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8.2 - Posts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const PostsScreen(),
    );
  }
}

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Post> posts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  // Gọi API và chuyển JSON thành List<Post>.
  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://jsonplaceholder.typicode.com/posts',
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'HTTP error: ${response.statusCode}',
        );
      }

      final List<dynamic> jsonData =
      jsonDecode(response.body) as List<dynamic>;

      final List<Post> loadedPosts = jsonData.map((item) {
        return Post.fromJson(
          item as Map<String, dynamic>,
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        posts = loadedPosts;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage =
        'Unable to load posts. Please check your connection.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8.2 - Posts'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: isLoading ? null : fetchPosts,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    // Trạng thái đang tải dữ liệu.
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Trạng thái lỗi.
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 12),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: fetchPosts,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    // Danh sách rỗng.
    if (posts.isEmpty) {
      return const Center(
        child: Text('No posts available.'),
      );
    }

    return Column(
      children: [
        // Hiển thị tổng số bài viết.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.blue.shade50,
          child: Text(
            'Total posts: ${posts.length}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Hiển thị danh sách bằng ListView.builder.
        Expanded(
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    child: Text('${post.id}'),
                  ),
                  title: Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(post.body),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
