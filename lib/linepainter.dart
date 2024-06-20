import 'dart:math';

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  Color? lineColor;
  Color? completeColor;
  double? startPercent;
  double? endPercent;
  double? width;
  double? percentage;
  int? startValue;
  int? endValue;
  final angle = 2 * pi / 60;

  double? value;

  LinePainter(
      {this.lineColor,
      this.completeColor,
      this.startValue,
      this.endValue,
      this.startPercent,
      this.endPercent,
      this.width,
      this.percentage,
      this.value});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Color(0xFFC8C8C8)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width!;
    Paint complete = new Paint()
      ..color = completeColor!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width!;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    double sweepAngle = (40 * angle) * (percentage! / 100);

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        25 * angle, 40 * angle, false, line);

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        25 * angle, sweepAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
