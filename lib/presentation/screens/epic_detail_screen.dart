import 'package:flutter/material.dart';
import '../../domain/entities/epic.dart';

class EpicDetailScreen extends StatelessWidget {
  final Epic epic;
  const EpicDetailScreen({super.key, required this.epic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          epic.caption,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Hero(
          tag: epic.imageUrl,
          child: InteractiveViewer(
            child: Image.network(
              epic.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
