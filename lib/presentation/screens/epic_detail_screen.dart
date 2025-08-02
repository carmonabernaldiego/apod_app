import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/epic.dart';

class EpicDetailScreen extends StatelessWidget {
  final Epic epic;
  const EpicDetailScreen({Key? key, required this.epic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm').format(epic.date);

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
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: epic.imageUrl,
                child: InteractiveViewer(
                  child: Image.network(
                    epic.imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (ctx, child, prog) {
                      if (prog == null) return child;
                      return const Center(
                          child: CircularProgressIndicator());
                    },
                    errorBuilder: (ctx, err, st) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.black87,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fecha y hora (UTC): $formattedDateTime',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  epic.caption,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
