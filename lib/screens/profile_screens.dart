import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:moviemania/screens/homescreen.dart';
import 'package:moviemania/screens/login_screens.dart';
import 'package:moviemania/screens/search_screens.dart';
import 'package:moviemania/screens/watchlist_screen.dart';
import 'package:moviemania/styles.dart'; // Pastikan TextStyles sudah didefinisikan
import 'package:moviemania/widgets/bottom_navbar.dart'; // BottomNavigationBarWidget

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int selectedIndex = 3;
  String userName = "Loading...";
  String userEmail = "Loading...";

  // Fungsi untuk mengambil data pengguna dari Firestore
  Future<void> _getUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Ambil data pengguna berdasarkan UID
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (doc.exists) {
          setState(() {
            // Perbaiki pengambilan 'username' dan 'email' sesuai dengan yang disimpan
            userName = doc['username'] ?? "No Name"; // Mengambil username
            userEmail = doc['email'] ?? "No Email"; // Mengambil email
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData(); // Panggil fungsi untuk mengambil data pengguna saat halaman dimuat
  }

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
      case 2: // Tambahkan kondisi untuk Watchlist
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WatchlistScreen()),
        );
        break;
      case 3: // Tetap di halaman Profile
        break;
    }
  }

  Future<void> _logout() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreens()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Logout Failed"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // Fungsi untuk menampilkan deskripsi aplikasi
  void _showAboutAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("About the Application"),
          content: const Text(
            "Cinema Collection is an application to discover various movies. "
            "Enjoy a wide selection of the best and most popular movies from around the world with an easy-to-use interface.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(239, 4, 0, 255),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // User Name
              Text(
                userName, // Tampilkan nama user yang diambil dari Firestore
                style: TextStyles.title.copyWith(
                  fontSize: 28,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              // User Email
              Text(
                userEmail, // Tampilkan email user yang diambil dari Firestore
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 1,
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 20),
              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Tombol Tentang Aplikasi
                    ElevatedButton.icon(
                      onPressed:
                          _showAboutAppDialog, // Menampilkan dialog tentang aplikasi
                      icon: const Icon(Icons.info, color: Colors.blue),
                      label: const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        side: const BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Logout Button
                    ElevatedButton.icon(
                      onPressed: _logout, // Panggil fungsi logout
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        side: const BorderSide(color: Colors.red, width: 1),
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
