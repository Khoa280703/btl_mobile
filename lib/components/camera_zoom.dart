import 'package:flutter/material.dart';

class CameraZoomControls extends StatelessWidget {
  final double zoomLevel;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const CameraZoomControls({
    super.key,
    required this.zoomLevel,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onZoomOut,
          icon: const Icon(Icons.remove, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withAlpha((0.5 * 255).toInt()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Camera Zoom: ${zoomLevel.toStringAsFixed(1)}x',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
          onPressed: onZoomIn,
          icon: const Icon(Icons.add, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withAlpha((0.5 * 255).toInt()),
          ),
        ),
      ],
    );
  }
}
