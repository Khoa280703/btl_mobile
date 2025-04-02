import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../components/element.dart';
import '../components/element_scale.dart';
import '../components/camera_zoom.dart';
import '../components/joystick.dart';
import '../components/custom_button.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage>
    with SingleTickerProviderStateMixin {
  late CameraController _cameraController;
  bool _isCameraReady = false;
  bool _isLoading = false;

  Offset _elementPosition = const Offset(150, 300);
  double _elementScale = 1.0;
  late String _element='';
  double _zoomLevel = 1.0;
  final double _minZoom = 1.0;
  final double _maxZoom = 4.0;
  final double _minElementScale = 0.5;
  final double _maxElementScale = 2.0;

  bool _editMode = false;
  bool _cameraMode = false;
  bool _isScanning = false;
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;
  String _selectedButton = '';
  int? selectedCustomButtonIndex;

  Map activeMap = {
    'camera': false,
    'scan': false,
    'location': false,
    'info': false,
  };

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _listenForVolumeKeys();
    _initializeScanAnimation();
  }

  Future<void> _initializeCamera() async {
    setState(() {
      _isLoading = true;
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
    _scanAnimationController.dispose();
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

  void _initializeScanAnimation() {
    _scanAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scanAnimation = Tween<double>(begin: 0.0, end: 0.9).animate(
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
  }

  Future<void> _toggleCameraMode() async {
    setState(() {
      _isLoading = true;
    });
    if (!_cameraMode) {
      _isScanning = false;
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
      _scanAnimationController.stop();
    } else {
      _scanAnimationController.forward();
    }
    setState(() {
      _isScanning = !_isScanning;
      _isLoading = false;
      activeMap['scan'] = _isScanning;
    });
  }

  Widget _buildRoundButton(String label,Function onTap) {
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
            onTap();
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
                              : CameraPreview(_cameraController),
                        ),
                        Column(
                          children: [
                            const Spacer(),
                            if (!_isScanning)
                              Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildRoundButton('Info',()=>{}),
                                      const SizedBox(width: 10),
                                      _buildRoundButton('Practice',()=>{}),
                                      const SizedBox(width: 10),
                                      _buildRoundButton('...',()=>{}),
                                    ],
                                  ),
                                ),
                              ),
                            if (!_isScanning)
                              Container(
                                height: 50,
                                color:
                                    Colors.grey.withAlpha((0.5 * 255).toInt()),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    children: [
                                      _buildRoundButton('Công tắc 1',()=>{setState(() {
                                        _element = 'switch';
                                      })}),
                                      _buildRoundButton('Công tắc 2',()=>{setState(() {
                                        _element = 'switch2';
                                      })}),
                                      _buildRoundButton('Công tắc 3',()=>{setState(() {
                                        _element = 'switch3';
                                      })}),
                                      _buildRoundButton('Công tắc 4',()=>{setState(() {
                                        _element = 'switch4';
                                      })}),
                                      _buildRoundButton('Knob',()=>{setState(() {
                                        _element = 'knob';
                                      })}),
                                      _buildRoundButton('Ledid',()=>{setState(() {
                                        _element = 'ledit';
                                      })}),
                                      _buildRoundButton('Meter',()=>{setState(() {
                                        _element = 'meter';
                                      })}),
                                      _buildRoundButton('Bộ Điện Di',()=>{}),
                                      _buildRoundButton('Tủ Mát',()=>{}),
                                      _buildRoundButton('Tủ Thao Tác',()=>{}),
                                    ],
                                  ),
                                ),
                              ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              color: const Color.fromRGBO(25, 94, 182, 1),
                              child: (!_editMode && !_isScanning)
                                  ? TextButton.icon(
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
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          _isScanning
                                              ? 'ĐANG QUÉT'
                                              : 'CHẾ ĐỘ CHỈNH SỬA',
                                          style: const TextStyle(
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
                                    icon: Icons.location_on,
                                    label: "Location",
                                    isSelected: activeMap['location'] ?? false,
                                    onPress: () {
                                      setState(() {
                                        activeMap['location'] =
                                            !activeMap['location']!;
                                      });
                                    },
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
                                          _cameraMode
                                              ? Icons.camera_alt
                                              : Icons.camera,
                                          color: _cameraMode
                                              ? Colors.blue
                                              : Colors.grey,
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
                                  if (_cameraMode)
                                    CustomButton(
                                      icon: Icons.center_focus_strong,
                                      label: "Scan",
                                      isSelected: activeMap['scan'] ?? false,
                                      onPress: () async {
                                        await _toggleScanningMode();
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
                                  CustomButton(
                                    icon: Icons.info,
                                    label: "Info",
                                    isSelected: activeMap['info'] ?? false,
                                    onPress: () {
                                      setState(() {
                                        activeMap['info'] = !activeMap['info']!;
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
                    child: CustomElement(scale: _elementScale,element: _element),
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
                    ),
                  if (_isScanning)
                    AnimatedBuilder(
                      animation: _scanAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: _scanAnimation.value * screenSize.height,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            color: Colors.red.withAlpha((0.7 * 255).toInt()),
                          ),
                        );
                      },
                    ),
                ],
              ));
  }
}
