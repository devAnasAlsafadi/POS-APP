import 'package:flutter/material.dart';
import 'dart:math';
import '../enum/snakebar_tybe.dart';
import '../theme/app_color.dart';
import '../theme/app_text_style.dart';


class AppSnackBar {
  static Future<void> show(
      BuildContext context, {
        required String message,
        required SnackBarType type,
        String? title,
      }) async {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: _SnackBarWidget(
            message: message,
            title: title,
            type: type,
            onDismiss: () => overlayEntry.remove(),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) overlayEntry.remove();
    });
  }
}

class _SnackBarWidget extends StatefulWidget {
  final String? title;
  final String message;
  final SnackBarType type;
  final VoidCallback onDismiss;

  const _SnackBarWidget({
    required this.message,
    this.title,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<_SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<_SnackBarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    if (widget.type == SnackBarType.error) {
      _shakeController.forward();
    }
  }

  double _getShakeOffset(double animationValue) {
    return sin(animationValue * pi * 3) * 8;
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = widget.type == SnackBarType.error
        ? const Color(0xFF3D1B1B)
        : (widget.type == SnackBarType.success ? const Color(0xFF1B3922) : Colors.black87);

    final IconData icon = widget.type == SnackBarType.error
        ? Icons.error_outline
        : (widget.type == SnackBarType.success ? Icons.check_circle_outline : Icons.info_outline);

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_getShakeOffset(_shakeController.value), 0),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.title != null)
                    Text(widget.title!, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(widget.message, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white54, size: 18),
              onPressed: widget.onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}