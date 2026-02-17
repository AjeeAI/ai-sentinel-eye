import 'package:flutter/material.dart';
import 'dart:math' as math;

class RippleLoader extends StatefulWidget {
  final double size;
  final Color color;

  const RippleLoader({
    super.key,
    this.size = 100.0,
    this.color = const Color(0xFF00FF41), // Default to Matrix Green
  });

  @override
  State<RippleLoader> createState() => _RippleLoaderState();
}

class _RippleLoaderState extends State<RippleLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Your SVG duration was "1s", so we match that here
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _RipplePainter(
          animation: _controller,
          color: widget.color,
        ),
      ),
    );
  }
}

class _RipplePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _RipplePainter({required this.animation, required this.color}) : super(repaint: animation);

  void _drawCircle(Canvas canvas, Size size, double value) {
    final double maxRadius = size.width / 2;
    final double radius = maxRadius * value; // Expands from 0 to Max
    
    // Opacity goes from 1.0 -> 0.0 as it expands (keySplines="0.2 0 0.8 1")
    final double opacity = (1.0 - value).clamp(0.0, 1.0);
    
    final Paint paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0; // Matches your SVG stroke-width="2" (adjusted for high-DPI)

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Circle 1 (Starts at 0.0)
    _drawCircle(canvas, size, animation.value);

    // Circle 2 (Starts at 0.5, mimicking the "-0.5s" delay in your SVG)
    double secondCircleValue = animation.value - 0.5;
    if (secondCircleValue < 0) secondCircleValue += 1.0;
    
    _drawCircle(canvas, size, secondCircleValue);
  }

  @override
  bool shouldRepaint(_RipplePainter oldDelegate) => true;
}