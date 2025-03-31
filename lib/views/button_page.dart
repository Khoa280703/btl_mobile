import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Light grey background
      body: SafeArea(
        child: Stack(
          children: [
            // Full-screen background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/anh_da_den_high_five.png', // Change this to your actual image
                fit: BoxFit.cover, // Make the image cover the whole screen
              ),
            ),

            // Overlay content
            Column(
              children: [
                const SizedBox(height: 20),

                // Top bar with settings icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white, // Background color
                          shape: BoxShape.circle, // Circular shape
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.settings, color: Colors.black54),
                          iconSize: 30, // Adjust icon size
                          splashRadius: 24, // Ripple effect size
                          onPressed: () {
                            // Handle settings action
                          },
                        ),
                      ),
                    ],
                  ),
                ),


                // Horizontal button list with semi-transparent background
                Container(
                  height: 50, // Set the height of the container
                  color: Colors.grey
                      .withOpacity(0.5), // Gray background with opacity
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment:
                        Alignment.center, // Center buttons inside the container
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        _buildRoundButton('Info', Colors.white, Colors.black),
                        _buildRoundButton(
                            'Practice', Colors.blue, Colors.white),
                        _buildRoundButton('...', Colors.white, Colors.black),
                        _buildRoundButton(
                            'Bản thực hành', Colors.white, Colors.black),
                        _buildRoundButton(
                            'Bộ Điện Di', Colors.white, Colors.black),
                        _buildRoundButton('Tủ Mát', Colors.white, Colors.black),
                        _buildRoundButton(
                            'Tủ Thao Tác', Colors.white, Colors.black),
                      ],
                    ),
                  ),
                ),

                // Bottom navigation button
                Container(
                  width: double.infinity,
                  color: const Color.fromRGBO(25, 94, 182, 1), // Blue
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    label: const Text(
                      'MÀN HÌNH CHÍNH',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundButton(String label, Color bgColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 30, // Minimum height to keep the button short
          maxHeight: 30, // Maximum height to prevent it from expanding
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            padding: const EdgeInsets.symmetric(
                horizontal: 12), // Keep padding only for width
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(25), // Increased border radius
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold, // Make text bold
            ),
          ),
        ),
      ),
    );
  }
}
