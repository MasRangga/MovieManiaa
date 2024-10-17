import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviemania/screens/profile_screens.dart';
import 'package:moviemania/screens/search_screens.dart';
import 'package:moviemania/styles.dart';
import 'package:moviemania/widgets/bottom_navbar.dart';

// Model data untuk film
class Movie {
  final String title;
  final String imageUrl;

  Movie({required this.title, required this.imageUrl});
}

// Data dummy untuk film
final List<Movie> trendingMovies = [
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0bhYtWb34m_h8KkEw9MNVmCkGVgXJdQAQZg&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4u9qJGLT-n3vKIc5S97PZUr0e47bWphjGAQ&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu7o8jayxoKPyPyYHTwau9yWm0REoKYEjDvQ&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTavZL5-qqVSr4hDfnGQbKI5rcth5nmcroVw&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQOzjz5H_xsIOjtcNI6Ygoprv0qPbQqI6pw&s'),
   Movie(
      title: ' ',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQOzjz5H_xsIOjtcNI6Ygoprv0qPbQqI6pw&s'),
];

final List<Movie> topRatedMovies = [
  Movie(
      title: ' ',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0bhYtWb34m_h8KkEw9MNVmCkGVgXJdQAQZg&s'),
  Movie(
      title: ' ',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4u9qJGLT-n3vKIc5S97PZUr0e47bWphjGAQ&s'),
  Movie(
      title: ' ',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu7o8jayxoKPyPyYHTwau9yWm0REoKYEjDvQ&s'),
  Movie(
      title: ' ',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTavZL5-qqVSr4hDfnGQbKI5rcth5nmcro1Vw&s'),
  Movie(
      title: ' ',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQOzjz5H_xsIOjtcNI6Ygoprv0qPbQqI6pw&s'),
];

final List<Movie> upcomingMovies = [
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0bhYtWb34m_h8KkEw9MNVmCkGVgXJdQAQZg&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4u9qJGLT-n3vKIc5S97PZUr0e47bWphjGAQ&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu7o8jayxoKPyPyYHTwau9yWm0REoKYEjDvQ&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTavZL5-qqVSr4hDfnGQbKI5rcth5nmcro1Vw&s'),
  Movie(
      title: ' ',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQOzjz5H_xsIOjtcNI6Ygoprv0qPbQqI6pw&s'),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0; // Track selected index

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index; // Update selected index
    });
    // Navigate to the corresponding screen based on selected index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen()), // Stay on HomeScreen
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const SearchScreens()), // Navigate to SearchScreens
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const ProfileScreens()), // Navigate to ProfileScreens
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trending Movies Section
              Text(
                'Trending Movies',
                style: TextStyles.body.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: trendingMovies.length,
                  options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    viewportFraction: 0.55,
                    enlargeCenterPage: true,
                    pageSnapping: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                  ),
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    final movie = trendingMovies[itemIndex];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(movie.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Top Rated Movies Section
              Text(
                'Top Rated Movies',
                style: TextStyles.body.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: topRatedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = topRatedMovies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(movie.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // s Section
              Text(
                'Upcoming Movies',
                style: TextStyles.body.copyWith(fontSize: 25),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: upcomingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = upcomingMovies[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(movie.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
}
