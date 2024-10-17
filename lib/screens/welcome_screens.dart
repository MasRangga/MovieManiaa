import 'package:flutter/material.dart';
import 'package:moviemania/screens/login_screens.dart';

class GetStartedScreens extends StatelessWidget {
  const GetStartedScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/icons/coverbg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Opacity Overlay
          Container(
            color: Colors.black
                .withOpacity(0.5), // Adjust opacity here (0.0 to 1.0)
          ),
          // Overlay with Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Enlarged Logo
                Image.asset(
                  'assets/icons/Splash.png', // Your logo asset path
                  width: 200, // Increased width
                  height: 200, // Increased height
                  fit: BoxFit.contain, // Use contain to prevent cropping
                ),
                const SizedBox(height: 20), // Spacing
                const Text(
                  'Discover and Enjoy Movies',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600, // Semi-bold
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 60), // Increased spacing before button
                // Get Started Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to LoginScreens
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreens()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(239, 4, 0, 255), // Button color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
