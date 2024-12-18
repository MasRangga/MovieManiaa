import 'package:flutter/material.dart';
import 'package:moviemania/services/tmdb_service.dart';
import 'package:moviemania/services/watchlist_service.dart';
import 'package:moviemania/services/movie.dart';
import 'package:moviemania/styles.dart';

class DetailScreens extends StatefulWidget {
  final int movieId;
  final String title;
  final String posterUrl;

  const DetailScreens({
    Key? key,
    required this.movieId,
    required this.title,
    required this.posterUrl,
  }) : super(key: key);

  @override
  State<DetailScreens> createState() => _DetailScreensState();
}

class _DetailScreensState extends State<DetailScreens> {
  final TMDBService tmdbService = TMDBService();
  final WatchlistService watchlistService = WatchlistService();

  String director = "Loading...";
  double rating = 0.0;
  String storyline = "Loading...";
  bool isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
    checkWatchlist();
  }

  Future<void> fetchMovieDetails() async {
    try {
      final details = await tmdbService.fetchMovieDetails(widget.movieId);

      setState(() {
        rating = details['vote_average'] ?? 0.0;
        storyline = details['overview'] ?? "No storyline available.";

        final crew = details['credits']['crew'] as List<dynamic>;
        final directorData = crew.firstWhere(
          (member) => member['job'] == 'Director',
          orElse: () => null,
        );
        director =
            directorData != null ? directorData['name'] : "Unknown Director";
      });
    } catch (e) {
      print("Error fetching movie details: $e");
      setState(() {
        director = "Unknown Director";
        storyline = "No storyline available.";
      });
    }
  }

  Future<void> checkWatchlist() async {
    final exists = await watchlistService.isInWatchlist(widget.movieId);
    setState(() {
      isInWatchlist = exists;
    });
  }

  Future<void> toggleWatchlist() async {
    final movie = Movie(
      id: widget.movieId,
      title: widget.title,
      imageUrl: widget.posterUrl,
    );

    if (isInWatchlist) {
      await watchlistService.removeFromWatchlist(widget.movieId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removed from Watchlist')),
      );
    } else {
      await watchlistService.addToWatchlist(movie);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to Watchlist')),
      );
    }

    setState(() {
      isInWatchlist = !isInWatchlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double defaultMargin = 16.0;
    const double defaultRadius = 12.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(239, 4, 0, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Detail Movie',
          style: TextStyles.title.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Container(
                height: 370,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  image: DecorationImage(
                    image: NetworkImage(widget.posterUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyles.body.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Director: $director',
                        style: TextStyles.body.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      Text(
                        '$rating',
                        style: TextStyles.body.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Storyline',
                    style: TextStyles.body.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    storyline,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Tombol di bagian bawah layar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ElevatedButton.icon(
          onPressed: toggleWatchlist,
          icon: Icon(
            isInWatchlist ? Icons.check : Icons.add,
            color: Colors.white,
          ),
          label: Text(
            isInWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
            style: const TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
