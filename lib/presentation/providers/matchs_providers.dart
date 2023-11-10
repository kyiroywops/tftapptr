import 'package:riverpod/riverpod.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/repositories/tft_match_repository.dart'; // Importa el datasource

final tftMatchDataSource = TFTMatchDataSource(); // Crea una instancia de TFTMatchDataSource

final tftMatchRepository = TFTMatchRepository(tftMatchDataSource); // Pasa TFTMatchDataSource al constructor de TFTMatchRepository

final tftMatchProvider = Provider<TFTMatchRepository>((ref) => tftMatchRepository); // Crea un provider para el repositorio

// Puedes usar tftMatchProvider para obtener el repositorio en tus widgets
