// lib/presentation/screens/epic_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/epic_provider.dart';
import 'epic_detail_screen.dart';

class EpicScreen extends StatefulWidget {
  const EpicScreen({Key? key}) : super(key: key);

  @override
  State<EpicScreen> createState() => _EpicScreenState();
}

class _EpicScreenState extends State<EpicScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EpicProvider>().fetchEpics();
    });
  }

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: vm.isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : vm.error != null
                ? Center(
                    child: Text('Error: ${vm.error}',
                        style: const TextStyle(color: Colors.redAccent)),
                  )
                : vm.epics == null || vm.epics!.isEmpty
                    ? Center(
                        child: ElevatedButton(
                          onPressed: vm.fetchEpics,
                          child: const Text('Cargar imágenes de la Tierra'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
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
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EpicDetailScreen(epic: e),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              clipBehavior: Clip.hardEdge,
                              elevation: 6,
                              child: Stack(
                                children: [
                                  Hero(
                                    tag: e.imageUrl,
                                    child: Image.network(
                                      e.imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (ctx, child, prog) {
                                        if (prog == null) return child;
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (ctx, err, st) =>
                                          const Center(
                                              child: Icon(Icons.broken_image)),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      color: Colors.black54,
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        formatted,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
