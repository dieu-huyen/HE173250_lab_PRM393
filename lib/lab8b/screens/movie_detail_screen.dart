
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() =>
      _MovieDetailScreenState();
}

class _MovieDetailScreenState
    extends State<MovieDetailScreen> {
  final MovieService _service = MovieService();
  late Future<Movie> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture =
        _service.fetchShowDetail(widget.movie.id);
  }

  void _retry() {
    setState(() {
      _detailFuture =
          _service.fetchShowDetail(widget.movie.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show Details')),
      body: FutureBuilder<Movie>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Unable to load details.'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _retry,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final movie = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (movie.imageUrl != null)
                Center(
                  child: Image.network(
                    movie.imageUrl!,
                    height: 300,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.movie,
                      size: 100,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                movie.name,
                style: Theme.of(context)
                    .textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text('Rating: ${movie.rating}/10'),
              Text('Premiered: ${movie.premiered}'),
              const SizedBox(height: 16),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                movie.plainSummary.isEmpty
                    ? 'No overview available.'
                    : movie.plainSummary,
              ),
              if (movie.officialSite != null) ...[
                const SizedBox(height: 16),
                SelectableText(
                  'Official site: ${movie.officialSite}',
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
