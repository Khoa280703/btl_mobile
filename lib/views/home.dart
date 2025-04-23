import 'package:flutter/material.dart';
import 'edit_page.dart';
import './scan_page.dart';
import 'web_view.dart';
import 'google.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0x4BADD8E6),
              Color(0xCCFFFFFF),
              Color(0x4BADD8E6),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            _buildImageButton(
              context,
              'assets/images/tim_mat_phang.png',
              'TÌM MẶT PHẲNG',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildImageButton(
              context,
              'assets/images/tim_hinh_anh.png',
              'TÌM HÌNH ẢNH',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleScanCameraPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildImageButton(
              context,
              'assets/images/CSE.png',
              'LMS',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const YoutubePage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GooglePage(),
                  ),
                );
              },
              icon: const Icon(Icons.search, size: 40),
              style: IconButton.styleFrom(
                backgroundColor: const Color.fromRGBO(25, 94, 182, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              color: const Color.fromRGBO(25, 94, 182, 1),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  'CHỌN CÁCH HIỂN THỊ!',
                  style: TextStyle(
                    color: Colors.white,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 241,
              fit: BoxFit.cover,
            ),
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(25, 94, 182, 1),
              minimumSize: const Size(250, 40),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
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
