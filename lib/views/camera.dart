import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mobile/views/tuy_chinh_page.dart';
import '../components/element.dart';
import '../components/element_scale.dart';
import '../components/camera_zoom.dart';
import '../components/joystick.dart';

import './button_page.dart';
import './tuy_chinh_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isCameraReady = false;

  Offset _elementPosition = const Offset(150, 300);
  double _elementScale = 1.0;

  double _zoomLevel = 1.0;
  final double _minZoom = 1.0;
  final double _maxZoom = 4.0;
  final double _minElementScale = 0.5;
  final double _maxElementScale = 2.0;

  String _selectedButton = ''; // Stores the currently selected button

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _listenForVolumeKeys();
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
      _isCameraReady = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _moveElement(Offset offset) {
    setState(() {
      _elementPosition = Offset(
        _elementPosition.dx + offset.dx * 5,
        _elementPosition.dy + offset.dy * 5,
      );
    });
  }

  void _setZoom(double zoom) async {
    if (zoom < _minZoom || zoom > _maxZoom) return;
    await _cameraController.setZoomLevel(zoom);
    setState(() {
      _zoomLevel = zoom;
    });
  }

  void _setElementScale(double scale) {
    if (scale < _minElementScale || scale > _maxElementScale) return;
    setState(() {
      _elementScale = scale;
    });
  }

  void _listenForVolumeKeys() {
    HardwareKeyboard.instance.addHandler((event) {
      if (event is KeyDownEvent) {
        if (event.physicalKey == PhysicalKeyboardKey.audioVolumeUp) {
          _setZoom(_zoomLevel + 0.5);
          _setElementScale(_elementScale + 0.1);
          return true;
        }
        if (event.physicalKey == PhysicalKeyboardKey.audioVolumeDown) {
          _setZoom(_zoomLevel - 0.5);
          _setElementScale(_elementScale - 0.1);
          return true;
        }
      }
      return false;
    });
  }

  Widget _buildRoundButton(String label) {
    bool isSelected =
        _selectedButton == label; // Check if the button is selected

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
            backgroundColor:
                isSelected ? Colors.blue : Colors.white, // Change color
            foregroundColor:
                isSelected ? Colors.white : Colors.black, // Change text color
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


  int? selectedTuyChinhButtonIndex;

  final List<Color> initialColors = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.blue, // Right-side button 1
    Colors.blue, // Right-side button 2
  ];

  final List<IconData?> icons = [
    Icons.track_changes,
    Icons.center_focus_strong,
    Icons.location_on,
    Icons.settings, // Right-side button 1
    Icons.info, // Right-side button 2
  ];

  final List<Function> actions = [
    () {
      // Action for button 1
      print('Button 1 pressed');
    },
    () {
      // Action for button 2
      print('Button 2 pressed');
    },
    () {
      // Action for button 4
      print('Button 4 pressed');
    },
    () {
      // Action for right-side button 1
      print('Right-side button 1 pressed');
    },
    () {
      // Action for right-side button 2
      print('Right-side button 2 pressed');
    },
  ];

  Widget _buildTuyChinhButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTuyChinhButtonIndex = index;
        });
        actions[index](); // Call the action associated with the button
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: CircleAvatar(
          radius: 20,
          backgroundColor:
              selectedTuyChinhButtonIndex == index ? Colors.yellow : initialColors[index],
          child: icons[index] != null
              ? Icon(icons[index], color: Colors.black)
              : null,
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _isCameraReady
          ? Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenSize.height,
                  // child: CameraPreview(_cameraController),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
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
                Positioned(
                  top: 15,
                  left: 0,
                  right: 0,
                  height: screenSize.height,
                  // child: CameraPreview(_cameraController),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left column of buttons
                            Column(
                              children: List.generate(3, (index) {
                                return _buildTuyChinhButton(index);
                              }),
                            ),
                            const Spacer(), // Push right-side buttons to the right
                            // Right column of buttons
                            Column(
                              children: List.generate(2, (index) {
                                return _buildTuyChinhButton(
                                    index + 3); // Offset to right-side buttons
                              }),
                            ),
                          ],
                        ), // Add the button list here
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: _elementPosition.dx,
                  top: _elementPosition.dy,
                  child: CustomElement(scale: _elementScale),
                ),
                Positioned(
                  bottom: screenSize.height * 0.2,
                  left: (screenSize.width - screenSize.width * 0.6) / 2,
                  child: Column(
                    children: [
                      CameraZoomControls(
                        zoomLevel: _zoomLevel,
                        onZoomIn: () => _setZoom(_zoomLevel + 0.5),
                        onZoomOut: () => _setZoom(_zoomLevel - 0.5),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CameraJoystick(onMove: _moveElement),
                          const SizedBox(width: 10),
                          ElementScaleSlider(
                            currentScale: _elementScale,
                            minScale: _minElementScale,
                            maxScale: _maxElementScale,
                            onScaleChanged: _setElementScale,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
