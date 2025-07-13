import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  const CustomInkwell({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongTap,
    this.inkwellRadius = 16.0,
  });

  final double inkwellRadius;
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(inkwellRadius),
              onTap:onTap,
              onLongPress: onLongTap,
            ),
          ),
        ),
      ],
    );
  }
}
