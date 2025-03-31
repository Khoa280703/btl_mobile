import 'package:flutter/material.dart';
import 'package:mobile/views/tuy_chinh_page.dart';
import 'button_page.dart'; // Import your ButtonPage widget
import 'camera.dart'; // Import your CameraPage widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0x4BADD8E6), // Light blue with opacity
              const Color(0xCCFFFFFF), // White with slight transparency
              const Color(0x4BADD8E6), // Light blue again
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Image Button 1
            _buildImageButton(
              context,
              'assets/images/tim_mat_phang.png',
              'TÌM MẶT PHẲNG',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ButtonPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Image Button 2
            _buildImageButton(
              context,
              'assets/images/tim_hinh_anh.png',
              'TÌM HÌNH ẢNH',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPage(),
                    // builder:(context)=>  TuyChinhPage(),
                  ),
                );
              },
            ),

            const Spacer(),

            // Bottom Button
            Container(
              width: double.infinity,
              color: const Color.fromRGBO(25, 94, 182, 1), // Blue
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'CHỌN CÁCH HIỂN THỊ!',
                  style: TextStyle(
                    color: Colors.white, // Fixed invalid color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(BuildContext context, String imagePath, String label, VoidCallback onTap) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min, // <-- Prevents extra spacing
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 241, // Same width as button
              // height: 150,
              fit: BoxFit.cover,
            ),
          ),
          // REMOVE EXTRA SPACE
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(25, 94, 182, 1), // Blue
              minimumSize: const Size(250, 40), // Same width as image
              padding: EdgeInsets.zero, // <-- Removes default padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // No border radius to remove spacing
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
