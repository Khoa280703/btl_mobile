import 'package:flutter/material.dart';

class CustomElement extends StatelessWidget {
  final double scale;
  final Map elementMapping = {
    'switch': Stack(
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
    'ledit': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.greenAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.greenAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'ledout': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.redAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'led': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.yellowAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellowAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'switch2': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.purpleAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'switch3': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.orangeAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orangeAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'switch4': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.cyanAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'switch5': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.tealAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.tealAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'switch6': Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.indigoAccent, width: 3),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.indigoAccent,
                border: Border.all(color: Colors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    'knob': Stack(
  alignment: Alignment.center,
  children: [
    Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)],
      ),
    ),
    Icon(Icons.circle, color: Colors.white, size: 20),
  ],
),
    'meter': Stack(
  alignment: Alignment.center,
  children: [
    Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        border: Border.all(color: Colors.black, width: 2),
      ),
    ),
    Positioned(
      top: 5,
      child: Icon(Icons.arrow_drop_up, color: Colors.red, size: 24),
    ),
    Positioned(
      top:15,
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
),
  };
  final String element;

  CustomElement({
    super.key,
    required this.scale,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: elementMapping[element] ?? Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        child: Center(child: Text('Unknown Element')),
      ),
    );
  }
}
