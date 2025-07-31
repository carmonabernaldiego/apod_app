import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/apod_provider.dart';

class ApodScreen extends StatelessWidget {
  const ApodScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ApodProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagen Astronómica del Día'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.indigo],
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
        padding: const EdgeInsets.all(16),
        child: Center(
          child: vm.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : vm.error != null
                  ? Text('Error: ${vm.error}', style: const TextStyle(color: Colors.redAccent))
                  : vm.apod == null
                      ? ElevatedButton.icon(
                          onPressed: vm.fetchApod,
                          icon: const Icon(Icons.image, color: Colors.white),
                          label: const Text('Cargar imagen'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.network(vm.apod!.url, fit: BoxFit.cover, height: 250),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(vm.apod!.title,
                                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      Text('Fecha: ${vm.apod!.date}',
                                          style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                                      const SizedBox(height: 12),
                                      Text(vm.apod!.explanation,
                                          textAlign: TextAlign.justify, style: const TextStyle(height: 1.5)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
        ),
      ),
    );
  }
}
