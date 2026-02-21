import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TableGlowWrapper extends StatelessWidget {
  final Widget child;
  final bool shouldGlow;
  final Color statusColor;

  const TableGlowWrapper({super.key, required this.child, required this.shouldGlow, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    if (!shouldGlow) return child;
    return child.animate(onPlay: (c) => c.repeat(reverse: true)).boxShadow(
      begin: BoxShadow(color: statusColor.withValues(alpha: 0.1), blurRadius: 10),
      end: BoxShadow(color: statusColor.withValues(alpha: 0.6), blurRadius: 20, spreadRadius: 2),
      duration: 1500.ms,
      curve: Curves.easeInOutQuad,
    );
  }
}

class TableBackgroundNumber extends StatelessWidget {
  final int id;
  const TableBackgroundNumber({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -10, bottom: -15,
      child: Text(id.toString().padLeft(2, '0'),
        style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900, color: Colors.white.withValues(alpha: 0.03)),
      ),
    );
  }
}