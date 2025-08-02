import 'package:flutter/material.dart';
import '../../domain/entities/mars.dart';

class MarsDetailScreen extends StatelessWidget {
  final Mars photo;
  const MarsDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${photo.roverName} - ${photo.cameraName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Hero(
          tag: photo.imgSrc,
          child: InteractiveViewer(
            child: Image.network(
              photo.imgSrc,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(
          'Fecha terrestre: ${photo.earthDate}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
