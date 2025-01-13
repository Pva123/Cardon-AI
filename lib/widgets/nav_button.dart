import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const NavButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        side: BorderSide(
          color: backgroundColor != null ? Colors.transparent : Colors.orange,
        ),
        foregroundColor: foregroundColor ?? Colors.orange,
      ),
      child: Text(label),
    );
  }
}
