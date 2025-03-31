import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class CameraJoystick extends StatelessWidget {
  final Function(Offset) onMove;

  const CameraJoystick({
    super.key,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Joystick(
        mode: JoystickMode.all,
        listener: (details) {
          onMove(Offset(details.x, details.y));
        },
      ),
    );
  }
}
