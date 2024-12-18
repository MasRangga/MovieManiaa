import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie.dart'; // Import model Movie

class WatchlistService {
  final String _storageKey = 'watchlist';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Mendapatkan UID pengguna yang login
  String get userId {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("User is not logged in");
    }
    return user.uid;
  }

  // ------------------ Firestore Implementation ------------------

  // Menambahkan film ke Firestore Watchlist
  Future<void> addToWatchlist(Movie movie) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movie.id.toString()) // ID unik berdasarkan movie.id
        .set({
      'id': movie.id,
      'title': movie.title,
      'imageUrl': movie.imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Menghapus film dari Firestore Watchlist
  Future<void> removeFromWatchlist(int movieId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movieId.toString())
        .delete();
  }

  // Mengambil semua film dari Firestore Watchlist
  Future<List<Movie>> getWatchlist() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Movie(
        id: data['id'],
        title: data['title'],
        imageUrl: data['imageUrl'],
      );
    }).toList();
  }

  // Mengecek apakah film ada di Firestore Watchlist
  Future<bool> isInWatchlist(int movieId) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('watchlist')
        .doc(movieId.toString())
        .get();
    return doc.exists;
  }

  // ------------------ SharedPreferences Implementation ------------------

  // Menyimpan watchlist ke SharedPreferences (opsional, jika masih ingin digunakan)
  Future<void> addToLocalWatchlist(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final watchlist = await getLocalWatchlist();
    watchlist.add(movie);
    await prefs.setStringList(
      _storageKey,
      watchlist.map((movie) => jsonEncode(movie.toMap())).toList(),
    );
  }

  Future<void> removeFromLocalWatchlist(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final watchlist = await getLocalWatchlist();
    watchlist.removeWhere((movie) => movie.id == movieId);
    await prefs.setStringList(
      _storageKey,
      watchlist.map((movie) => jsonEncode(movie.toMap())).toList(),
    );
  }

  Future<List<Movie>> getLocalWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_storageKey) ?? [];
    return data
        .map((movieJson) => Movie.fromMap(jsonDecode(movieJson)))
        .toList();
  }
}
