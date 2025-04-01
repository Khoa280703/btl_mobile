import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SimpleScanCameraPage extends StatefulWidget {
  final bool displayBottom;
  const SimpleScanCameraPage({super.key, this.displayBottom = true});

  @override
  State<SimpleScanCameraPage> createState() => _SimpleScanCameraPageState();
}

class _SimpleScanCameraPageState extends State<SimpleScanCameraPage> with SingleTickerProviderStateMixin {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  // Animation controller for scanning line
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize camera
    _initializeCamera();

    // Setup scan animation
    _scanAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Make animation repeat up and down
    _scanAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scanAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _scanAnimationController.forward();
      }
    });

    // Start the animation
    _scanAnimationController.forward();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    await _cameraController.initialize();
    if (!mounted) return;

    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(_cameraController),
                ),
                AnimatedBuilder(
                  animation: _scanAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: _scanAnimation.value * (screenSize.height - 150),
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2,
                        color: Colors.green,
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (widget.displayBottom)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const Text(
                        'ĐANG QUÉT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(25, 94, 182, 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
