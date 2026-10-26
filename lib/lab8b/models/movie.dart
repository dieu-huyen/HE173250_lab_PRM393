
class Movie {
  final int id;
  final String name;
  final String summary;
  final String? imageUrl;
  final double rating;
  final String premiered;
  final String? officialSite;

  const Movie({
    required this.id,
    required this.name,
    required this.summary,
    required this.imageUrl,
    required this.rating,
    required this.premiered,
    required this.officialSite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final image = json['image'] as Map<String, dynamic>?;
    final ratingData = json['rating'] as Map<String, dynamic>?;

    return Movie(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Unknown',
      summary: json['summary'] as String? ?? '',
      imageUrl: image?['medium'] as String?,
      rating: (ratingData?['average'] as num?)?.toDouble() ?? 0,
      premiered: json['premiered'] as String? ?? 'Unknown',
      officialSite: json['officialSite'] as String?,
    );
  }

  String get plainSummary =>
      summary.replaceAll(RegExp(r'<[^>]*>'), '').trim();
}
