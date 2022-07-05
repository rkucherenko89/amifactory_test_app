class Movie {
  final int id;
  final String title;
  final String description;
  final int release_year;
  final String mpa_rating;
  final double imdb_rating;
  final int duration;
  final String poster;
  final String bg_picture;
  final List genres;
  final List directors;
  final List writers;
  final List stars;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.release_year,
    required this.mpa_rating,
    required this.imdb_rating,
    required this.duration,
    required this.poster,
    required this.bg_picture,
    required this.genres,
    required this.directors,
    required this.writers,
    required this.stars,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      release_year: json['release_year'],
      mpa_rating: json['mpa_rating'],
      imdb_rating: json['imdb_rating'],
      duration: json['duration'],
      poster: json['poster'],
      bg_picture: json['bg_picture'],
      genres: json['genres'] ?? [],
      directors: json['directors'] ?? [],
      writers: json['writers'] ?? [],
      stars: json['stars'] ?? [],
    );
  }
}
