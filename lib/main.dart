import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/apod_remote_datasource.dart';
import 'data/datasources/neo_remote_datasource.dart';
import 'data/repositories/apod_repository_impl.dart';
import 'data/repositories/neo_repository_impl.dart';
import 'domain/usecases/get_apod.dart';
import 'domain/usecases/get_neos.dart';
import 'presentation/providers/apod_provider.dart';
import 'presentation/providers/neo_provider.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  const nasaApiKey = "TJ4oYGssIOXBhEvG08neXxPE9gfVeifylsyrYMHb"; // <-- ¡PON TU KEY AQUI!
  runApp(MyApp(apiKey: nasaApiKey));
}

class MyApp extends StatelessWidget {
  final String apiKey;
  const MyApp({super.key, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final datasource = ApodRemoteDatasource(apiKey: apiKey);
            final repository = ApodRepositoryImpl(remoteDatasource: datasource);
            final usecase = GetApod(repository);
            return ApodProvider(getApodUseCase: usecase);
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final datasource = NeoRemoteDatasource(apiKey: apiKey);
            final repository = NeoRepositoryImpl(remoteDatasource: datasource);
            final usecase = GetNeos(repository);
            return NeoProvider(getNeosUseCase: usecase);
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NASA MVVM',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
