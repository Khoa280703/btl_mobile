import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final VoidCallback? onPress;
  final bool isSelected;
  final Color defaultColor;
  final Color selectedColor;
  final double radius;
  final Color iconColor;
  final TextStyle? labelStyle;

  const CustomButton({
    super.key,
    this.icon,
    this.label,
    this.onPress,
    this.isSelected = false,
    this.defaultColor = Colors.blue,
    this.selectedColor = Colors.yellow,
    this.radius = 20,
    this.iconColor = Colors.black,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: isSelected ? selectedColor : defaultColor,
              child: icon != null
                  ? Icon(icon, color: iconColor)
                  : (label != null && icon == null)
                      ? Text(
                          label!.isNotEmpty ? label![0] : "",
                          style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
                        )
                      : null,
            ),
            if (label != null && label!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  label!,
                  style: labelStyle ?? const TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
