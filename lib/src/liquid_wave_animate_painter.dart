import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A custom painter that draws the liquid fill and wave animation.
/// The [showLiquid] flag determines whether to draw the liquid fill.
class LiquidWaveAnimatePainter extends CustomPainter {
  final double waveValue; // Wave phase (0.0 to 1.0)
  final double fillValue; // Liquid fill level (0.0 to [fillLevel])
  final Color liquidColor;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final bool showLiquid;

  LiquidWaveAnimatePainter({
    required this.waveValue,
    required this.fillValue,
    required this.liquidColor,
    required this.borderColor,
    required this.borderWidth,
    required this.backgroundColor,
    required this.showLiquid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Define a pill-shaped area for the button.
    final RRect buttonRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.height / 2),
    );

    // 1. Draw the button's background.
    final Paint backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRRect(buttonRRect, backgroundPaint);

    // 2. Draw the liquid fill if showLiquid is true.
    if (showLiquid) {
      canvas.save();
      canvas.clipRRect(buttonRRect);

      final double waveBaseline = size.height * (1.0 - fillValue);
      const double waveAmplitude = 8.0;
      const double waveFrequency = 2.0;

      final Path wavePath = Path()
        ..moveTo(0, size.height)
        ..lineTo(0, waveBaseline);

      for (double x = 0; x <= size.width; x++) {
        final double y = waveBaseline +
            math.sin((x / size.width * 2 * math.pi * waveFrequency) +
                    2 * math.pi * waveValue) *
                waveAmplitude;
        wavePath.lineTo(x, y);
      }
      wavePath
        ..lineTo(size.width, size.height)
        ..close();

      final Paint fillPaint = Paint()..color = liquidColor;
      canvas.drawPath(wavePath, fillPaint);
      canvas.restore();
    }

    // 3. Draw the button's border.
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawRRect(buttonRRect, borderPaint);
  }

  @override
  bool shouldRepaint(LiquidWaveAnimatePainter oldDelegate) {
    return oldDelegate.waveValue != waveValue ||
        oldDelegate.fillValue != fillValue ||
        oldDelegate.liquidColor != liquidColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.showLiquid != showLiquid;
  }
}