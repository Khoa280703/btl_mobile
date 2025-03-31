import 'package:flutter/material.dart';

class TuyChinhButtons extends StatefulWidget {
  @override
  _TuyChinhButtonsState createState() => _TuyChinhButtonsState();
}

class _TuyChinhButtonsState extends State<TuyChinhButtons> {
  int? selectedIndex;

  final List<Color> initialColors = [
    Colors.blue,
    Colors.blue,
    Colors.white,
    Colors.blue,
    Colors.blue, // Right-side button 1
    Colors.blue, // Right-side button 2
  ];

  final List<IconData?> icons = [
    Icons.track_changes,
    Icons.center_focus_strong,
    null, // Empty white circle
    Icons.location_on,
    Icons.settings, // Right-side button 1
    Icons.info, // Right-side button 2
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column of buttons
        Column(
          children: List.generate(4, (index) {
            return _buildButton(index);
          }),
        ),
        const Spacer(), // Push right-side buttons to the right
        // Right column of buttons
        Column(
          children: List.generate(2, (index) {
            return _buildButton(index + 4); // Offset to right-side buttons
          }),
        ),
      ],
    );
  }

  Widget _buildButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: selectedIndex == index ? Colors.yellow : initialColors[index],
          child: icons[index] != null ? Icon(icons[index], color: Colors.black) : null,
        ),
      ),
    );
  }

}
