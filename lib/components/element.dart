import 'package:flutter/material.dart';

class CustomElement extends StatelessWidget {
  final double scale;
  final String element;
  final bool showInfo;

  final Map<String, Widget> elementMapping = {
    'switch': _buildElement(Colors.lightBlue, Colors.blue),
    'ledit': _buildElement(Colors.green, Colors.greenAccent),
    'ledout': _buildElement(Colors.red, Colors.redAccent),
    'led': _buildElement(Colors.yellow, Colors.yellowAccent),
    'switch2': _buildElement(Colors.purple, Colors.purpleAccent),
    'switch3': _buildElement(Colors.orange, Colors.orangeAccent),
    'switch4': _buildElement(Colors.cyan, Colors.cyanAccent),
    'switch5': _buildElement(Colors.teal, Colors.tealAccent),
    'switch6': _buildElement(Colors.indigo, Colors.indigoAccent),
    'knob': _buildKnob(),
    'meter': _buildMeter(),
  };

  CustomElement({
    super.key,
    required this.scale,
    required this.element,
    this.showInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Transform.scale(
          scale: scale,
          child: elementMapping[element] ?? const SizedBox.shrink(),
        ),
        if (showInfo)
          Positioned(
            top: -20, // Adjust for better placement
            right: -20, // Adjust for better placement
            child: Tooltip(
              message: "3D Model Info",
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_right, color: Colors.white, size: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "Thông tin vật thể",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  static Widget _buildElement(Color primary, Color border) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: border, width: 3),
          ),
        ),
        Positioned(
          top: 10,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: border,
              border: Border.all(color: Colors.white, width: 4),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildKnob() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 4)],
          ),
        ),
        const Icon(Icons.circle, color: Colors.white, size: 20),
      ],
    );
  }

  static Widget _buildMeter() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
        const Positioned(
          top: 5,
          child: Icon(Icons.arrow_drop_up, color: Colors.red, size: 24),
        ),
        Positioned(
          top: 15,
          child: Container(
            width: 2,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
