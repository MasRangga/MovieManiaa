import 'package:flutter/material.dart';
import 'package:moviemania/screens/homescreen.dart';
import 'package:moviemania/screens/profile_screens.dart';
import 'package:moviemania/screens/search_screens.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white, // Warna latar belakang BottomAppBar
      child: Row(
        children: [
          // Tombol Home
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.home,
                color: selectedIndex == 0
                    ? const Color.fromARGB(239, 4, 0, 255)
                    : Colors.grey,
              ),
              onPressed: () => onItemTapped(0), // Navigasi ke HomeScreen
            ),
          ),
          const Spacer(flex: 2),
          // Tombol Search
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: selectedIndex == 1
                    ? const Color.fromARGB(239, 4, 0, 255)
                    : Colors.grey,
              ),
              onPressed: () => onItemTapped(1), // Navigasi ke SearchScreen
            ),
          ),
          const Spacer(flex: 2),
          // Tombol Profile
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 2
                    ? const Color.fromARGB(239, 4, 0, 255)
                    : Colors.grey,
              ),
              onPressed: () => onItemTapped(2), // Navigasi ke ProfileScreen
            ),
          ),
        ],
      ),
    );
  }
}
