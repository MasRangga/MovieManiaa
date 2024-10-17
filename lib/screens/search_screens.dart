import 'package:flutter/material.dart';
import 'package:moviemania/screens/homescreen.dart'; // Import HomeScreen
import 'package:moviemania/screens/profile_screens.dart'; // Import ProfileScreens
import 'package:moviemania/styles.dart'; // Ensure to import styles for TextStyles
import 'package:moviemania/widgets/bottom_navbar.dart'; // Import BottomNavigationBarWidget

class SearchScreens extends StatefulWidget {
  const SearchScreens({Key? key}) : super(key: key);

  @override
  State<SearchScreens> createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  int selectedIndex = 1; // Set the selected index for the search screen

  // Dummy movie data
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Movie 1',
      'rating': 8.5,
      'description': 'This is a description for Movie 1.',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0bhYtWb34m_h8KkEw9MNVmCkGVgXJdQAQZg&s' // Replace with actual image URL
    },
    {
      'title': 'Movie 2',
      'rating': 7.2,
      'description': 'This is a description for Movie 2.',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4u9qJGLT-n3vKIc5S97PZUr0e47bWphjGAQ&s' // Replace with actual image URL
    },
    // Add more movies as needed
  ];

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreens()),
        );
        break;
      // Handle other cases if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white), // White text color for title
        ),
        backgroundColor: const Color.fromARGB(239, 4, 0, 255),
        centerTitle: true, // Center the title
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implement search logic here
              },
            ),
            const SizedBox(height: 20),
            // List of search results (dummy data)
            Expanded(
              child: ListView.builder(
                itemCount: movies.length, // Number of search results
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    elevation: 8, // Increased elevation for shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15), // Clip the content
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Movie image
                          Image.network(
                            movie['imageUrl'],
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                              width: 16), // Space between image and text
                          // Movie details
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  16.0), // Padding around the text
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie['title'],
                                    style: const TextStyle(
                                      fontSize:
                                          22, // Increased font size for title
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          8), // Space between title and rating
                                  Row(
                                    children: [
                                      // Display stars based on rating
                                      for (int i = 0; i < 5; i++)
                                        Icon(
                                          i < movie['rating'].round()
                                              ? Icons.star
                                              : Icons.star_border,
                                          color:
                                              Colors.amber, // Color for stars
                                          size: 20, // Size for stars
                                        ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${movie['rating']}',
                                        style: const TextStyle(
                                          fontSize: 16, // Font size for rating
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      height:
                                          8), // Space between rating and description
                                  Text(
                                    movie['description'],
                                    style: const TextStyle(
                                      fontSize:
                                          14, // Increased font size for description
                                      color: Colors.grey,
                                    ),
                                    maxLines:
                                        2, // Limit the description to 2 lines
                                    overflow: TextOverflow
                                        .ellipsis, // Show ellipsis if the text overflows
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }
}
