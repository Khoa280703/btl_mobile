import 'package:flutter/material.dart';

class ElementConfig with ChangeNotifier {
  int testInt = 0;
  void setTestInt(int value) {
    testInt = value;
  }
}
