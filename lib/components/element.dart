import 'package:flutter/material.dart';

class CustomElement extends StatelessWidget {
  final double scale;

  const CustomElement({
    super.key,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.blue, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
