import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/apod_provider.dart';

class ApodScreen extends StatelessWidget {
  const ApodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<ApodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagen Astronómica del Día'),
      ),
      body: Center(
        child: apodProvider.isLoading
            ? const CircularProgressIndicator()
            : apodProvider.error != null
                ? Text('Error: ${apodProvider.error}')
                : apodProvider.apod == null
                    ? ElevatedButton(
                        onPressed: () => apodProvider.fetchApod(),
                        child: const Text('Cargar imagen del día'),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              apodProvider.apod!.title,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Image.network(apodProvider.apod!.url),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(apodProvider.apod!.explanation, textAlign: TextAlign.justify),
                            ),
                            const SizedBox(height: 10),
                            Text('Fecha: ${apodProvider.apod!.date}'),
                          ],
                        ),
                      ),
      ),
    );
  }
}
