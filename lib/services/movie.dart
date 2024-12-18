class Movie {
  final int id; // ID film
  final String title; // Judul film
  final String imageUrl; // URL poster film
  bool isInWatchlist; // Status apakah film ada di watchlist

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isInWatchlist = false,
  });

  // Convert object Movie ke Map untuk disimpan
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'isInWatchlist': isInWatchlist,
    };
  }

  // Convert Map ke object Movie untuk diambil
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'] ?? 'No Title',
      imageUrl: map['imageUrl'] ?? '',
      isInWatchlist: map['isInWatchlist'] ?? false,
    );
  }
}
