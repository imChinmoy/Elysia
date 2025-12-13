import 'package:flutter/material.dart';

class Desktop extends StatelessWidget {
  const Desktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop View'),
        centerTitle: true,
        backgroundColor: Colors.green.shade100,
      ),
      body: Expanded(
        child: const Center(
          child: Text('This is the desktop layout'),
        ),
      ),
    );
  }
}