import 'package:flutter/material.dart';

class Mobile extends StatelessWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('Mobile View'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: AspectRatio(
        aspectRatio: 16 / 9,

        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This is the mobile layout',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 200,
                color: Colors.blue.shade400,
                child: const Center(
                  child: Text(
                    'Mobile Content',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          )
          ),
      ),
      );
  }
}

