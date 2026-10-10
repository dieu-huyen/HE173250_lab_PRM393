
import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

// MODEL
class Movie {
  final String title;
  final int year;
  final double rating;
  final List<String> genres;
  final String posterUrl;

  const Movie({
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
    required this.posterUrl,
  });
}

// SAMPLE DATA
const List<Movie> allMovies = [
  Movie(
    title: 'Avengers: Endgame',
    year: 2019,
    rating: 8.4,
    genres: ['Action', 'Sci-Fi'],
    posterUrl:
    'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=500',
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    rating: 9.0,
    genres: ['Action', 'Drama'],
    posterUrl:
    'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500',
  ),
  Movie(
    title: 'The Hangover',
    year: 2009,
    rating: 7.7,
    genres: ['Comedy'],
    posterUrl:
    'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=500',
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    rating: 8.7,
    genres: ['Drama', 'Sci-Fi'],
    posterUrl:
    'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=500',
  ),
  Movie(
    title: 'The Notebook',
    year: 2004,
    rating: 7.8,
    genres: ['Romance', 'Drama'],
    posterUrl:
    'https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2?w=500',
  ),
  Movie(
    title: 'A Quiet Place',
    year: 2018,
    rating: 7.5,
    genres: ['Horror', 'Drama'],
    posterUrl:
    'https://images.unsplash.com/photo-1509248961158-e54f6934749c?w=500',
  ),
  Movie(
    title: 'John Wick',
    year: 2014,
    rating: 7.4,
    genres: ['Action'],
    posterUrl:
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=500',
  ),
  Movie(
    title: 'Free Guy',
    year: 2021,
    rating: 7.1,
    genres: ['Comedy', 'Action', 'Sci-Fi'],
    posterUrl:
    'https://images.unsplash.com/photo-1519608487953-e999c86e7455?w=500',
  ),
];

// APP
class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Movie',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3478D4),
        ),
      ),
      home: const MovieHomePage(),
    );
  }
}

// HOME PAGE
class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  final TextEditingController searchController =
  TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  String searchQuery = '';
  String selectedSort = 'A-Z';

  final List<String> genres = [
    'Action',
    'Drama',
    'Comedy',
    'Horror',
    'Romance',
    'Sci-Fi',
  ];

  final Set<String> selectedGenres = {};

  // FILTER AND SORT
  List<Movie> get visibleMovies {
    final query = searchQuery.trim().toLowerCase();

    final result = allMovies.where((movie) {
      final matchesSearch =
      movie.title.toLowerCase().contains(query);

      final matchesGenres = selectedGenres.isEmpty ||
          movie.genres.any(
                (genre) => selectedGenres.contains(genre),
          );

      return matchesSearch && matchesGenres;
    }).toList();

    switch (selectedSort) {
      case 'A-Z':
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Z-A':
        result.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        result.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return result;
  }

  void clearFilters() {
    setState(() {
      searchQuery = '';
      searchController.clear();
      selectedGenres.clear();
      selectedSort = 'A-Z';
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FE),
      appBar: AppBar(
        title: const Text(
          'Movie Explorer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF7F8FE),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: ListView(
              padding: EdgeInsets.all(isTablet ? 28 : 20),
              children: [
                // LAB 6.1: RESPONSIVE HERO
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 500;

                    final hero = Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: compact ? 290 : 340,
                      ),
                      padding: EdgeInsets.all(compact ? 24 : 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2495F0),
                            Color(0xFF4052B8),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.movie_creation_outlined,
                            size: compact ? 54 : 70,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Find a Movie',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: compact ? 30 : 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Discover movies you will love',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 22),
                          FilledButton.icon(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(
                                searchFocusNode,
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 18,
                            ),
                            label: const Text('Explore Movies'),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                              const Color(0xFF234F91),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (constraints.maxWidth >= 800) {
                      return Row(
                        children: [
                          Expanded(child: hero),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.local_movies_rounded,
                            size: 80,
                            color: Color(0xFF4052B8),
                          ),
                        ],
                      );
                    }

                    return hero;
                  },
                ),

                const SizedBox(height: 28),

                // LAB 6.2: SEARCH BAR
                const Text(
                  'Search Movies',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  onChanged: (value) {
                    setState(() => searchQuery = value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by movie title...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() => searchQuery = '');
                      },
                      icon: const Icon(Icons.close),
                    )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // LAB 6.2: GENRE CHIPS
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Genres',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (selectedGenres.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          setState(() => selectedGenres.clear());
                        },
                        child: const Text('Clear'),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: genres.map((genre) {
                    return FilterChip(
                      label: Text(genre),
                      selected: selectedGenres.contains(genre),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedGenres.add(genre);
                          } else {
                            selectedGenres.remove(genre);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // LAB 6.2: SORT BAR
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    const Text(
                      'Browse Movies',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Sort by'),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: selectedSort,
                          items: const [
                            DropdownMenuItem(
                              value: 'A-Z',
                              child: Text('A-Z'),
                            ),
                            DropdownMenuItem(
                              value: 'Z-A',
                              child: Text('Z-A'),
                            ),
                            DropdownMenuItem(
                              value: 'Year',
                              child: Text('Year'),
                            ),
                            DropdownMenuItem(
                              value: 'Rating',
                              child: Text('Rating'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => selectedSort = value);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // LAB 6.3: RESULT COUNT AND RESET
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${visibleMovies.length} movies found',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: clearFilters,
                      icon: const Icon(
                        Icons.filter_alt_off,
                        size: 18,
                      ),
                      label: const Text('Reset'),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // LAB 6.3: RESPONSIVE MOVIE LIST
                if (visibleMovies.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.movie_filter_outlined,
                          size: 54,
                          color: Colors.black38,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No movies found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Try another title or genre.',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  )
                else if (isTablet)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visibleMovies.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 320,
                    ),
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: visibleMovies[index],
                      );
                    },
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visibleMovies.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: visibleMovies[index],
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// LAB 6.3: MOVIE CARD
class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;
        final posterWidth = compact ? 105.0 : 125.0;

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FIX: poster has a finite height
              SizedBox(
                width: posterWidth,
                height: 190,
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE1E7F5),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.movie_outlined,
                        size: 42,
                        color: Color(0xFF4052B8),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${movie.year}',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 19,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: movie.genres.map((genre) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF0FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              genre,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF344D91),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
