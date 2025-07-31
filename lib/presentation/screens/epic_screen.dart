import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/epic_provider.dart';
import 'package:intl/intl.dart';
import 'epic_detail_screen.dart';  // ← importa el detalle

class EpicScreen extends StatelessWidget {
  const EpicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EpicProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('EPIC Earth'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.blueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: vm.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : vm.error != null
                    ? Text('Error: ${vm.error}',
                        style: const TextStyle(color: Colors.redAccent))
                    : vm.epics == null || vm.epics!.isEmpty
                        ? ElevatedButton(
                            onPressed: vm.fetchEpics,
                            child: const Text('Cargar imágenes de la Tierra'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                            itemCount: vm.epics!.length,
                            itemBuilder: (_, i) {
                              final e = vm.epics![i];
                              final formatted =
                                  DateFormat('yyyy-MM-dd').format(e.date);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EpicDetailScreen(epic: e),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 6,
                                  clipBehavior: Clip.hardEdge,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Hero(
                                          tag: e.imageUrl,
                                          child: Image.network(
                                            e.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.black54,
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(formatted,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 4),
                                            Text(e.caption,
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ),
      ),
    );
  }
}
