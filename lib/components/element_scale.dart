import 'package:flutter/material.dart';

class ElementScaleSlider extends StatefulWidget {
  final double currentScale;
  final double minScale;
  final double maxScale;
  final Function(double) onScaleChanged;

  const ElementScaleSlider({
    super.key,
    required this.currentScale,
    required this.minScale,
    required this.maxScale,
    required this.onScaleChanged,
  });

  @override
  State<ElementScaleSlider> createState() => _ElementScaleSliderState();
}

class _ElementScaleSliderState extends State<ElementScaleSlider> {
  late double sliderValue;

  @override
  void initState() {
    super.initState();
    _updateSliderValue();
  }

  @override
  void didUpdateWidget(ElementScaleSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentScale != widget.currentScale) {
      _updateSliderValue();
    }
  }

  void _updateSliderValue() {
    double scaleRange = widget.maxScale - widget.minScale;
    sliderValue = (widget.currentScale - widget.minScale) / scaleRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_drop_up, color: Colors.white, size: 20),
                Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
              ],
            ),
          ),
          Positioned(
            top: 15 + (90 - 30) * (1 - sliderValue),
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                double scaleRange = widget.maxScale - widget.minScale;
                double newSliderValue = (sliderValue - details.delta.dy / 100).clamp(0.0, 1.0);

                setState(() {
                  sliderValue = newSliderValue;
                });

                double newScale = widget.minScale + newSliderValue * scaleRange;
                widget.onScaleChanged(newScale);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
