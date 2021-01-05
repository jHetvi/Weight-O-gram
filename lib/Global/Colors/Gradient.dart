import 'package:flutter/material.dart';

LinearGradient customGradient(
    {bool reverseColors = false,
    double opacity = 1.0,
    bool topBottomGradient = false}) {
  List<Color> colors = [
    Color(0xFF11998e).withOpacity(opacity),
    Color(0xFF38ef7d).withOpacity(opacity),
  ];
  if (reverseColors) colors = colors.reversed.toList();
  return LinearGradient(
    colors: colors,
    stops: [0.125, 1],
    end: topBottomGradient ? Alignment.topCenter : Alignment.topLeft,
    begin: topBottomGradient ? Alignment.bottomCenter : Alignment.bottomRight,
  );
}
