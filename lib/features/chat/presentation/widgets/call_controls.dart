import 'package:flutter/material.dart';

class CallControls extends StatelessWidget {
  final VoidCallback onEnd;

  const CallControls({super.key, required this.onEnd});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: onEnd,
            child: const Icon(Icons.call_end),
          ),
        ],
      ),
    );
  }
}
