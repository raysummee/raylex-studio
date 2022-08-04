import 'package:flutter/material.dart';

class CustomSliderThumbShape extends SliderComponentShape {
  const CustomSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.showThumb = true,
    required this.disabledThumbRadius,
  });

  final double enabledThumbRadius;
  final bool showThumb;

  final double disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    if (!showThumb) {
      return;
    }
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final Paint paintBorder = Paint()
      ..color = const Color.fromARGB(255, 112, 112, 112)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
      center,
      radiusTween.evaluate(enableAnimation),
      Paint()..color = colorTween.evaluate(enableAnimation)!,
    );
    canvas.drawCircle(
      center,
      radiusTween.evaluate(enableAnimation),
      paintBorder,
    );
  }
}
