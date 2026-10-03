import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

// MODEL: TRAILER

class Trailer {
  final String title;

  const Trailer({
    required this.title,
  });
}

// MODEL: MOVIE

class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<Trailer> trailers;

  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

// SAMPLE DATA

final List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl:
    'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    overview:
    'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: [
      'Sci-Fi',
      'Adventure',
      'Drama',
    ],
    rating: 8.6,
    trailers: [
      Trailer(title: 'Official Trailer #1'),
      Trailer(title: 'IMAX Sneak Peek'),
    ],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl:
    'https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
    overview:
    'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: [
      'Action',
      'Comedy',
    ],
    rating: 8.3,
    trailers: [
      Trailer(title: 'Red Band Trailer'),
      Trailer(title: 'Behind the Scenes'),
    ],
  ),
];
// APP

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF7FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// HOME SCREEN

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movies',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return MovieCard(movie: movie);
        },
      ),
    );
  }
}

// MOVIE CARD

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigation:
          // Navigator.push + MaterialPageRoute
          Navigator.push(    //Movie object được truyền từ Home Screen sang Detail Screen.
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                movie: movie,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.network(
                  movie.posterUrl,
                  width: 76,
                  height: 52,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 76,
                      height: 52,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.movie),
                    );
                  },
                ),
              ),

              const SizedBox(width: 14),

              // Movie information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_border,
                          size: 17,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toString(),
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '• ${movie.genres.join(', ')}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MOVIE DETAIL SCREEN

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // Scrollable detail page
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =================================================
            // HERO BANNER
            // =================================================

            Hero(
              tag: 'movie-${movie.id}',
              child: SizedBox(
                width: double.infinity,
                height: 210,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.movie,
                            size: 50,
                          ),
                        );
                      },
                    ),

                    // Gradient overlay
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),

                    // Movie title on banner
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =================================================
            // GENRES
            // =================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: movie.genres.map((genre) {
                  return Chip(
                    label: Text(
                      genre,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ),

            // =================================================
            // OVERVIEW
            // =================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                movie.overview,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            // =================================================
            // ACTION BUTTONS
            // =================================================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Favorite
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                    const Text(
                      'Favorite',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),

                // Rate
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Rate'),
                              content: const Text(
                                'Thank you for rating this movie!',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.star_border),
                    ),
                    const Text(
                      'Rate',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),

                // Share
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Share button pressed',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share),
                    ),
                    const Text(
                      'Share',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // =================================================
            // TRAILERS
            // =================================================

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Trailers',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 4),

            ListView.builder(
              itemCount: movie.trailers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final trailer = movie.trailers[index];

                return ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.play_circle_filled,
                    size: 20,
                  ),
                  title: Text(
                    trailer.title,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Playing ${trailer.title}',
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}