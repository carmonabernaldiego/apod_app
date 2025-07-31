import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/neo_provider.dart';
import '../../domain/entities/neo.dart';

class NeoScreen extends StatelessWidget {
  const NeoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final neoProvider = Provider.of<NeoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asteroides Cercanos'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrangeAccent, Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: neoProvider.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : neoProvider.error != null
                  ? Text('Error: ${neoProvider.error}',
                      style: const TextStyle(color: Colors.redAccent))
                  : neoProvider.neos.isEmpty
                      ? ElevatedButton.icon(
                          onPressed: () => neoProvider.fetchNeos(),
                          icon: const Icon(Icons.brightness_2,
                              color: Colors.white),
                          label:
                              const Text('Cargar asteroides de hoy'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 6,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: neoProvider.neos.length,
                          itemBuilder: (context, i) {
                            final Neo neo = neoProvider.neos[i];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 6,
                              shadowColor: Colors.black54,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: const Icon(Icons.warning,
                                    size: 32, color: Colors.redAccent),
                                title: Text(neo.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  'Diámetro: ${neo.diameter.toStringAsFixed(2)} m\n'
                                  'Acercamiento: ${neo.closeApproachDate}',
                                ),
                              ),
                            );
                          },
                        ),
        ),
      ),
    );
  }
}
