import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  const ToggleButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
      ),
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200),
        ),
      ),
    );
  }
}
