import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveMovieApp());
}

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
          seedColor: Colors.blue,
        ),
      ),
      home: const HeroScreen(),
    );
  }
}

class HeroScreen extends StatefulWidget {
  const HeroScreen({super.key});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
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

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 800;

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
              padding: EdgeInsets.all(isWideScreen ? 32 : 20),
              children: [
                // LAB 6.1: RESPONSIVE HERO
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 500;
                    final heroHeight = compact ? 290.0 : 350.0;

                    return Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: heroHeight,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 15,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 22),
                          FilledButton.icon(
                            onPressed: () {
                              FocusScope.of(context)
                                  .requestFocus(searchFocusNode);
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 18,
                            ),
                            label: const Text('Explore Movies'),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF234F91),
                            ),
                          ),
                        ],
                      ),
                    );
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
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by movie title...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          searchQuery = '';
                        });
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
                          setState(() {
                            selectedGenres.clear();
                          });
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
                              setState(() {
                                selectedSort = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // PLACEHOLDER FOR LAB 6.3
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.movie_outlined,
                        size: 42,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Movie list will be added',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Search: ${searchQuery.isEmpty ? "None" : searchQuery}\n'
                            'Genres: ${selectedGenres.isEmpty ? "All" : selectedGenres.join(", ")}\n'
                            'Sort: $selectedSort',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black54,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}