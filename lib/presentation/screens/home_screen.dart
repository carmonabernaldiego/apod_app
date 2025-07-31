import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apod_screen.dart';
import 'neo_screen.dart';
import 'epic_screen.dart';
import 'mars_screen.dart';
import '../widgets/astro_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('🌌 NASA Explorer'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/space_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              AstroCard(
                title: "Imagen del Día",
                subtitle: "APOD",
                icon: Icons.image,
                colors: [Colors.purple, Colors.indigo],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ApodScreen()),
                ),
              ),
              AstroCard(
                title: "Asteroides",
                subtitle: "NEOs",
                icon: Icons.brightness_2,
                colors: [Colors.orange, Colors.deepOrangeAccent],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NeoScreen()),
                ),
              ),
              AstroCard(
                title: "EPIC Earth",
                subtitle: "DSCOVR",
                icon: Icons.public,
                colors: [Colors.blue, Colors.cyan],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EpicScreen()),
                ),
              ),
              AstroCard(
                title: "Mars Rover",
                subtitle: "Curiosity",
                icon: Icons.landscape,
                colors: [Colors.red, Colors.deepOrange],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MarsScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
