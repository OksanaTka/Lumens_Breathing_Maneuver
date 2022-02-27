import 'package:flutter/material.dart';
import './breath_route.dart';

void main() {
  runApp(const MaterialApp(
    home: MainRoute(),
  ));
}

class MainRoute extends StatelessWidget {
  const MainRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lumen’s breathing maneuver',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Start Breathing!'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BreathRoute()),
            );
          },
        ),
      ),
    );
  }
}
