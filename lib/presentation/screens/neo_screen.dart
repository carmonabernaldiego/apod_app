import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/neo_provider.dart';

class NeoScreen extends StatelessWidget {
  const NeoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final neoProvider = Provider.of<NeoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asteroides Cercanos (HOY)'),
      ),
      body: Center(
        child: neoProvider.isLoading
            ? const CircularProgressIndicator()
            : neoProvider.error != null
                ? Text('Error: ${neoProvider.error}')
                : neoProvider.neos.isEmpty
                    ? ElevatedButton(
                        onPressed: () => neoProvider.fetchNeos(),
                        child: const Text('Cargar asteroides de hoy'),
                      )
                    : ListView.builder(
                        itemCount: neoProvider.neos.length,
                        itemBuilder: (context, index) {
                          final neo = neoProvider.neos[index];
                          return ListTile(
                            title: Text(neo.name),
                            subtitle: Text(
                                'Diámetro: ${neo.diameter.toStringAsFixed(2)} m\nAcercamiento: ${neo.closeApproachDate}'),
                          );
                        },
                      ),
      ),
    );
  }
}
