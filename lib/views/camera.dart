import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../components/element.dart';
import '../components/element_scale.dart';
import '../components/camera_zoom.dart';
import '../components/joystick.dart';

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
                  height: screenSize.height * 0.9,
                  child: CameraPreview(_cameraController),
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
