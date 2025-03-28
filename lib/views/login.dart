import 'package:flutter/material.dart';
import 'home.dart'; // Import your HomePage widget

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundLayer(screenHeight, screenWidth),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Image.asset(
              'assets/images/bk_name_vi.png',
              fit: BoxFit.cover,
              width: screenWidth,
            ),
          ),
          Positioned(
            top: screenHeight * 0.2,
            left: (screenWidth - 240) / 2,
            child: Image.asset(
              'assets/images/BIOTECH.png',
              width: 240,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: screenHeight * 0.55,
            left: (screenWidth - 320) / 2,
            child: _buildEmailField(),
          ),
          Positioned(
            top: screenHeight * 0.65,
            left: (screenWidth - 320) / 2,
            child: _buildMXCN(),
          ),
          Positioned(
            top: screenHeight * 0.78,
            left: (screenWidth - 300) / 2,
            child: _buildLoginButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundLayer(double screenHeight, double screenWidth) {
    return Positioned(
      left: 0,
      top: screenHeight * 0.5,
      child: Container(
        width: screenWidth,
        height: screenHeight * 0.6,
        decoration: ShapeDecoration(
          color: const Color(0xFF195DB6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      width: 320,
      height: 60,
      decoration: _inputDecoration(),
      child: const Center(
        child: Text(
          'Email',
          style: TextStyle(
            color: Color(0xFF888888),
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildMXCN() {
    return Container(
      width: 320,
      height: 60,
      decoration: _inputDecoration(),
      child: const Center(
        child: Text(
          'Mã số cá nhân',
          style: TextStyle(
            color: Color(0xFF888888),
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF72A6E9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Đăng nhập',
            style: TextStyle(
              color: Color(0xFF002660),
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _inputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
