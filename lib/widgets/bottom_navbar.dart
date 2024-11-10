import 'package:flutter/material.dart';

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
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Tombol Home
          IconButton(
            icon: Icon(
              Icons.home,
              color: selectedIndex == 0
                  ? const Color.fromARGB(239, 4, 0, 255)
                  : Colors.grey,
            ),
            onPressed: () => onItemTapped(0),
          ),
          // Tombol Search
          IconButton(
            icon: Icon(
              Icons.search,
              color: selectedIndex == 1
                  ? const Color.fromARGB(239, 4, 0, 255)
                  : Colors.grey,
            ),
            onPressed: () => onItemTapped(1),
          ),
          // Tombol Profile
          IconButton(
            icon: Icon(
              Icons.person,
              color: selectedIndex == 2
                  ? const Color.fromARGB(239, 4, 0, 255)
                  : Colors.grey,
            ),
            onPressed: () => onItemTapped(2),
          ),
        ],
      ),
    );
  }
}
