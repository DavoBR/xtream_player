import 'package:flutter/material.dart';

class StreamInfoButton extends StatelessWidget {
  const StreamInfoButton(this.onPressed, {super.key});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Show info',
      child: IconButton(
        icon: const Icon(Icons.info_outline, color: Colors.blue),
        onPressed: onPressed,
      ),
    );
  }
}
