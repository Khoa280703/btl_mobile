import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _personalIdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _personalIdController.dispose();
    super.dispose();
  }

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
            top: screenHeight * 0.15,
            left: (screenWidth - 240) / 2,
            child: Image.asset(
              'assets/images/HCMCUT.png',
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
            child: _buildPersonalIdField(),
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
      child: Center(
        child: TextField(
          controller: _emailController,
          style: const TextStyle(
            fontSize: 22,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Color(0xFF888888),
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            isCollapsed: true,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget _buildPersonalIdField() {
    return Container(
      width: 320,
      height: 60,
      decoration: _inputDecoration(),
      child: Center(
        child: TextField(
          controller: _personalIdController,
          style: const TextStyle(
            fontSize: 22,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'Mã số cá nhân',
            hintStyle: TextStyle(
              color: Color(0xFF888888),
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            isCollapsed: true,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // You can add validation here before navigating
        if (_emailController.text.isNotEmpty && _personalIdController.text.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          // Show error message if fields are empty
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Vui lòng nhập Email và Mã số cá nhân'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF72A6E9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.15 * 255).toInt()),
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
          color: Colors.black.withAlpha((0.1 * 255).toInt()),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
