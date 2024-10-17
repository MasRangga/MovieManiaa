import 'package:flutter/material.dart';
import 'package:moviemania/screens/homescreen.dart';
import 'package:moviemania/screens/search_screens.dart'; // Import SearchScreens
import 'package:moviemania/styles.dart'; // Ensure to import styles for TextStyles
import 'package:moviemania/widgets/bottom_navbar.dart'; // Import BottomNavigationBarWidget

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  int selectedIndex = 2; // Set the selected index for the profile screen

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreens()),
        );
        break;
      // Handle other cases if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(239, 4, 0, 255),
        elevation: 0,
        // Remove the leading back button
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Container(
        color: Colors.white, // Background color is white
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // User Name (without profile photo)
              Text(
                'Yi Hao Cheng', // User name
                style: TextStyles.title.copyWith(
                  fontSize: 28,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              // User Email
              Text(
                'yihao.cheng@example.com', // User email
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              // Divider
              const Divider(
                thickness: 1,
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 20),
              // Action Buttons (Edit, Logout)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement edit profile action
                      },
                      icon: const Icon(Icons.edit,
                          color: Colors.blue), // Blue icon
                      label: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18, // Larger text size
                          fontWeight: FontWeight.normal, // Regular text style
                          color: Colors.black, // Black text color
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // White button color
                        minimumSize: const Size.fromHeight(50), // Full width
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 1, // Blue border around the button
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Logout Button
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement logout action
                      },
                      icon: const Icon(Icons.logout,
                          color: Colors.red), // Red icon
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18, // Larger text size
                          fontWeight: FontWeight.normal, // Regular text style
                          color: Colors.black, // Black text color
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // White button color
                        minimumSize: const Size.fromHeight(50), // Full width
                        side: const BorderSide(
                          color: Colors.red,
                          width: 1, // Red border around the button
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
