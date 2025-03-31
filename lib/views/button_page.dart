import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  String _selectedButton = ''; // Stores the currently selected button

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
                'assets/images/anh_da_den_high_five.png',
                fit: BoxFit.cover,
              ),
            ),

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
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.settings, color: Colors.black54),
                          iconSize: 30,
                          splashRadius: 24,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // First row of buttons (Centered)
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildRoundButton('Info'),
                        const SizedBox(width: 10),
                        _buildRoundButton('Practice'),
                        const SizedBox(width: 10),
                        _buildRoundButton('...'),
                      ],
                    ),
                  ),
                ),

                // Second row of buttons (Scrollable)
                Container(
                  height: 50,
                  color: Colors.grey.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        _buildRoundButton('Bản thực hành'),
                        _buildRoundButton('Bộ Điện Di'),
                        _buildRoundButton('Tủ Mát'),
                        _buildRoundButton('Tủ Thao Tác'),
                      ],
                    ),
                  ),
                ),

                // Bottom navigation button
                Container(
                  width: double.infinity,
                  color: const Color.fromRGBO(25, 94, 182, 1),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Button Builder
  Widget _buildRoundButton(String label) {
    bool isSelected = _selectedButton == label; // Check if the button is selected

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 30,
          maxHeight: 30,
        ),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedButton = label; // Update the selected button
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue : Colors.white, // Change color
            foregroundColor: isSelected ? Colors.white : Colors.black, // Change text color
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
