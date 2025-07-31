import 'package:flutter/material.dart';
import 'apod_screen.dart';
import 'neo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos un degradado en el AppBar
      appBar: AppBar(
        title: const Text('NASA App - MVVM + Clean Arch'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _HomeCard(
                  icon: Icons.image,
                  title: 'Imagen del Día',
                  subtitle: 'Explora la APOD diaria',
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const ApodScreen())),
                  gradient: const [Colors.purple, Colors.indigo],
                ),
                const SizedBox(height: 24),
                _HomeCard(
                  icon: Icons.brightness_2,
                  title: 'Asteroides Cercanos',
                  subtitle: 'Descubre los NEOs de hoy',
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const NeoScreen())),
                  gradient: const [Colors.orange, Colors.deepOrangeAccent],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final List<Color> gradient;

  const _HomeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(2, 4)),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(width: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text(subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
