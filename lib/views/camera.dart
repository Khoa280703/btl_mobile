import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with SingleTickerProviderStateMixin {
  late CameraController _cameraController;
  bool _isCameraReady = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _setupAnimation();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first, // Use the first available camera
      ResolutionPreset.high,
    );

    await _cameraController.initialize();
    if (!mounted) return;

    setState(() {
      _isCameraReady = true;
    });
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Speed of scanning
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: 1, // Move the scanner from top to bottom fully
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _isCameraReady
          ? Stack(
              children: [
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover, // Ensures full-screen camera preview
                    child: SizedBox(
                      width: screenSize.width,
                      height: screenSize.height,
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Positioned(
                      top: screenSize.height * _animation.value,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 4,
                        color: Colors.red.withOpacity(0.8), // Scanning laser line
                      ),
                    );
                  },
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
