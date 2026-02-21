import 'package:flutter/material.dart';

class TableStyles {
  static BoxDecoration modernDecoration(Color color) => BoxDecoration(
    color: const Color(0xFF1E1E1E),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color.withValues(alpha: 0.1), Colors.transparent],
    ),
  );
}