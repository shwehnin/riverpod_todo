import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  const CircleContainer({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: color,
        ),
        color: color,
      ),
      child: child,
    );
  }
}
