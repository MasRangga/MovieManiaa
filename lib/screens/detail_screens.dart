import 'package:flutter/material.dart';
import 'package:moviemania/styles.dart'; // Asumsikan TextStyles sudah didefinisikan
import 'package:moviemania/screens/homescreen.dart';

class DetailScreens extends StatelessWidget {
  const DetailScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double defaultMargin = 16.0;
    const double defaultRadius = 12.0;
    const Color lightBackgroundColor = Color(0xFFE0E0E0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(239, 4, 0, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
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
              // Poster Film
              Container(
                height: 370,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  image: const DecorationImage(
                    image: AssetImage('assets/icons/detailimage.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Informasi Film
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Behind Her Eyes',
                    style: TextStyles.body.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Director: Erik Richter Strand',
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
                        '4.9',
                        style: TextStyles.body.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // Genre 1
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: lightBackgroundColor,
                        ),
                        child: Text(
                          'Drama',
                          style: TextStyles.body,
                        ),
                      ),
                      // Genre 2
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: lightBackgroundColor,
                        ),
                        child: Text(
                          'Supernatural Thriller',
                          style: TextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Storyline
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
                  Text.rich(
                    TextSpan(
                      text:
                          'Behind Her Eyes follows Louise, a single mother who embarks on an affair with her psychiatrist boss while secretly befriending his enigmatic wife. As the love triangle intensifies, dark secrets start to unravel, leading to a twisted and supernatural climax.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: ' Read More',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
