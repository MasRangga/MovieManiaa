import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moviemania/screens/watchlist_screen.dart';
import 'package:moviemania/services/tmdb_service.dart';
import 'package:moviemania/widgets/bottom_navbar.dart';
import 'package:moviemania/styles.dart';
import 'package:moviemania/screens/search_screens.dart';
import 'package:moviemania/screens/profile_screens.dart';
import 'package:moviemania/screens/detail_screens.dart';
import 'package:moviemania/screens/movie_list_screen.dart'; // Import layar untuk daftar film

class Movie {
  final int id; // ID untuk mendapatkan detail film
  final String title;
  final String imageUrl;

  Movie({required this.id, required this.title, required this.imageUrl});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TMDBService tmdbService = TMDBService();

  List<Movie> trendingMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  bool isLoading = true;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final trendingResults = await tmdbService.fetchTrendingMovies();
      final topRatedResults = await tmdbService.fetchTopRatedMovies();
      final upcomingResults = await tmdbService.fetchUpcomingMovies();

      setState(() {
        // Map data dari API ke model `Movie`
        trendingMovies = trendingResults.map((movie) {
          return Movie(
            id: movie['id'], // Ambil ID dari API
            title: movie['title'] ?? 'No title',
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
          );
        }).toList();

        topRatedMovies = topRatedResults.map((movie) {
          return Movie(
            id: movie['id'],
            title: movie['title'] ?? 'No title',
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
          );
        }).toList();

        upcomingMovies = upcomingResults.map((movie) {
          return Movie(
            id: movie['id'],
            title: movie['title'] ?? 'No title',
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
          );
        }).toList();

        isLoading = false;
      });
    } catch (error) {
      print('Error fetching movies: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void onItemTapped(int index) {
    if (selectedIndex == index) return; // Hindari reload jika index sama
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreens()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WatchlistScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreens()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(239, 4, 0, 255),
        elevation: 0,
        title: Image.asset(
          'assets/icons/logo2.png',
          fit: BoxFit.cover,
          width: 150,
          height: 50,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSectionHeader(
                      context,
                      title: 'Trending Movies',
                      movies: trendingMovies,
                    ),
                    const SizedBox(height: 16),
                    buildCarouselSlider(trendingMovies),
                    const SizedBox(height: 32),
                    buildSectionHeader(
                      context,
                      title: 'Top Rated Movies',
                      movies: topRatedMovies,
                    ),
                    const SizedBox(height: 16),
                    buildHorizontalList(topRatedMovies),
                    const SizedBox(height: 32),
                    buildSectionHeader(
                      context,
                      title: 'Upcoming Movies',
                      movies: upcomingMovies,
                    ),
                    const SizedBox(height: 16),
                    buildHorizontalList(upcomingMovies),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }

  Widget buildSectionHeader(BuildContext context,
      {required String title, required List<Movie> movies}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.body.copyWith(fontSize: 25),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieListScreen(
                  categoryTitle: title,
                  movies: movies,
                ),
              ),
            );
          },
          child: const Text(
            'See All',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildCarouselSlider(List<Movie> movies) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        viewportFraction: 0.55,
        enlargeCenterPage: true,
      ),
      itemBuilder: (context, itemIndex, pageViewIndex) {
        final movie = movies[itemIndex];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreens(
                  movieId: movie.id,
                  title: movie.title,
                  posterUrl: movie.imageUrl,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movie.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildHorizontalList(List<Movie> movies) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreens(
                    movieId: movie.id,
                    title: movie.title,
                    posterUrl: movie.imageUrl,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movie.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
