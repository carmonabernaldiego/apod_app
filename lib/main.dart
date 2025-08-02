// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/apod_remote_datasource.dart';
import 'data/datasources/neo_remote_datasource.dart';
import 'data/datasources/epic_remote_datasource.dart';
import 'data/datasources/mars_remote_datasource.dart';

import 'data/repositories/apod_repository_impl.dart';
import 'data/repositories/neo_repository_impl.dart';
import 'data/repositories/epic_repository_impl.dart';
import 'data/repositories/mars_repository_impl.dart';

import 'domain/usecases/get_apod.dart';
import 'domain/usecases/get_neos.dart';
import 'domain/usecases/get_epic.dart';
import 'domain/usecases/get_mars.dart';

import 'presentation/providers/apod_provider.dart';
import 'presentation/providers/neo_provider.dart';
import 'presentation/providers/epic_provider.dart';
import 'presentation/providers/mars_provider.dart';

import 'presentation/screens/home_screen.dart';

void main() {
  const nasaApiKey = 'TJ4oYGssIOXBhEvG08neXxPE9gfVeifylsyrYMHb';
  runApp(MyApp(apiKey: nasaApiKey));
}

class MyApp extends StatelessWidget {
  final String apiKey;
  const MyApp({Key? key, required this.apiKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // APOD
        ChangeNotifierProvider(
          create: (_) => ApodProvider(
            getApod: GetApod(
              ApodRepositoryImpl(
                remoteDatasource: ApodRemoteDatasource(apiKey: apiKey),
              ),
            ),
          ),
        ),
        // NEO
        ChangeNotifierProvider(
          create: (_) => NeoProvider(
            getNeos: GetNeos(
              NeoRepositoryImpl(
                remoteDatasource: NeoRemoteDatasource(apiKey: apiKey),
              ),
            ),
          ),
        ),
        // EPIC (usa `remote`, no `remoteDatasource`)
        ChangeNotifierProvider(
          create: (_) => EpicProvider(
            getEpic: GetEpic(
              EpicRepositoryImpl(
                remoteDatasource: EpicRemoteDatasource(apiKey: apiKey),
              ),
            ),
          ),
        ),
        // MARS
        ChangeNotifierProvider(
          create: (_) => MarsProvider(
            getMars: GetMars(
              MarsRepositoryImpl(
                remoteDatasource: MarsRemoteDatasource(apiKey: apiKey),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NASA Explorer',
        theme: ThemeData.dark(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
