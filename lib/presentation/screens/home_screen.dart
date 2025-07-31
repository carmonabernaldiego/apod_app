import 'package:flutter/material.dart';
import 'apod_screen.dart';
import 'neo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NASA App - MVVM')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Imagen Astronómica del Día'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ApodScreen()));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.brightness_2),
              label: const Text('Asteroides Cercanos (NEO)'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const NeoScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
