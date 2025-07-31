import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mars_provider.dart';

class MarsScreen extends StatelessWidget {
  const MarsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MarsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mars Rover Photos'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.redAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: vm.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : vm.error != null
                  ? Text('Error: ${vm.error}', style: const TextStyle(color: Colors.redAccent))
                  : vm.photos == null || vm.photos!.isEmpty
                      ? ElevatedButton(
                          onPressed: vm.fetchPhotos,
                          child: const Text('Cargar fotos de Marte'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                      : ListView.builder(
                          itemCount: vm.photos!.length,
                          itemBuilder: (_, i) {
                            final p = vm.photos![i];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.network(p.imgSrc, fit: BoxFit.cover, height: 200),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      '${p.roverName} - ${p.cameraName}\n${p.earthDate}',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
        ),
      ),
    );
  }
}
