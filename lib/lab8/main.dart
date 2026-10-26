
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const Lab84App());
}

class Lab84App extends StatelessWidget {
  const Lab84App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 8.4 - ApiService',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const PostsScreen(),
    );
  }
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ApiService apiService = ApiService();

  late Future<List<Post>> postsFuture;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() {
    setState(() {
      postsFuture = apiService.fetchPosts().then(
            (data) => data.map(Post.fromJson).toList(),
      );
    });
  }

  Future<void> _refreshPosts() async {
    final future = apiService.fetchPosts().then(
          (data) => data.map(Post.fromJson).toList(),
    );

    setState(() {
      postsFuture = future;
    });

    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8.4 - ApiService'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: fetchPosts,
            tooltip: 'Reload posts',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading posts...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 56,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Failed to load posts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: fetchPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final posts = snapshot.data ?? [];

          if (posts.isEmpty) {
            return const Center(
              child: Text('No posts found.'),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshPosts,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.body),
                          const SizedBox(height: 8),
                          Text(
                            'User ID: ${post.userId}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
