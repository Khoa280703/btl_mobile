import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../components/element.dart';
import '../components/element_scale.dart';
import '../components/camera_zoom.dart';
import '../components/joystick.dart';
import '../components//custom_button.dart';
import './scan_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late CameraController _cameraController;
  bool _isCameraReady = false;
  bool _isLoading = false; // Flag for loading state

  Offset _elementPosition = const Offset(150, 300);
  double _elementScale = 1.0;
  double _zoomLevel = 1.0;
  final double _minZoom = 1.0;
  final double _maxZoom = 4.0;
  final double _minElementScale = 0.5;
  final double _maxElementScale = 2.0;

  bool _editMode = false;
  bool _cameraMode = false;
  bool _isScanning = false;

  String _selectedButton = '';
  int? selectedCustomButtonIndex;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _listenForVolumeKeys();
  }

  Future<void> _initializeCamera() async {
    setState(() {
      _isLoading = true; // Set loading to true before starting async operation
    });

    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    await _cameraController.initialize();
    if (!mounted) return;

    setState(() {
      _isCameraReady = true;
      _isLoading = false;
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

  Future<void> _toggleCameraMode() async {
    setState(() {
      _isLoading = true;
    });

    if (!_cameraMode) {
      await _initializeCamera();
    }
    setState(() {
      _cameraMode = !_cameraMode;
      _isLoading = false;
    });
  }

  Future<void> _toggleScanningMode() async {
    setState(() {
      _isLoading = true;
    });

    if (_isScanning) {
      await _cameraController.dispose();
    }
    setState(() {
      _isScanning = !_isScanning;
      _isLoading = false;
    });
  }

  Widget _buildRoundButton(String label) {
    bool isSelected = _selectedButton == label;

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
              _selectedButton = label;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue : Colors.white,
            foregroundColor: isSelected ? Colors.white : Colors.black,
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: (_isLoading || !_isCameraReady)
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: screenSize.height,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: (!_cameraMode && !_isScanning)
                              ? Image.asset(
                                  'assets/images/anh_da_den_high_five.png',
                                  fit: BoxFit.cover,
                                )
                              : _isScanning
                                  ? const SimpleScanCameraPage(displayBottom: false)
                                  : CameraPreview(_cameraController),
                        ),
                        Column(
                          children: [
                            const Spacer(),
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
                            Container(
                              height: 50,
                              color: Colors.grey.withAlpha((0.5 * 255).toInt()),
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
                            Container(
                              width: double.infinity,
                              height: 50,
                              color: const Color.fromRGBO(25, 94, 182, 1),
                              child: !_editMode
                                  ? TextButton.icon(
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
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'CHẾ ĐỘ CHỈNH SỬA',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                            )
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CustomButton(
                                    icon: Icons.track_changes,
                                    label: "Chế độ",
                                    isSelected: selectedCustomButtonIndex == 0,
                                    onPress: () async {
                                      await _toggleScanningMode();
                                    },
                                  ),
                                  CustomButton(
                                    icon: Icons.center_focus_strong,
                                    label: "Focus",
                                    isSelected: selectedCustomButtonIndex == 1,
                                    onPress: () {
                                      setState(() {
                                        selectedCustomButtonIndex = 1;
                                      });
                                    },
                                  ),
                                  CustomButton(
                                    icon: Icons.location_on,
                                    label: "Location",
                                    isSelected: selectedCustomButtonIndex == 2,
                                    onPress: () {
                                      setState(() {
                                        selectedCustomButtonIndex = 2;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 10),
                                      Switch(
                                        activeColor: Colors.blue,
                                        inactiveThumbColor: Colors.grey,
                                        value: _editMode,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _editMode = value;
                                            selectedCustomButtonIndex = value ? 3 : -1;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Chỉnh sửa',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          await _toggleCameraMode();
                                        },
                                        child: Icon(
                                          _cameraMode ? Icons.camera_alt : Icons.camera,
                                          color: _cameraMode ? Colors.blue : Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Camera',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomButton(
                                    icon: Icons.info,
                                    label: "Info",
                                    isSelected: selectedCustomButtonIndex == 5,
                                    onPress: () {
                                      setState(() {
                                        selectedCustomButtonIndex = 5;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: _elementPosition.dx,
                    top: _elementPosition.dy,
                    child: CustomElement(scale: _elementScale),
                  ),
                  if (_editMode)
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
                    )
                ],
              ));
  }
}
