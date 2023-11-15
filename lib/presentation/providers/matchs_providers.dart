import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/infrastructure/datasources/tft_match_datasource.dart';
import 'package:tftapp/infrastructure/repositories/tft_match_repository.dart';
import 'package:tftapp/infrastructure/models/match_info_model.dart';

// Provider para el repositorio de TFT Match
final tftMatchRepositoryProvider = Provider<TFTMatchRepository>((ref) {
  // Deberás crear y configurar tu TFTMatchDataSource aquí y luego instanciar tu TFTMatchRepository con él.
  // Asegúrate de tener todos los parámetros necesarios y la configuración correcta para tu TFTMatchDataSource.
  // Esto es solo un ejemplo y necesitarás reemplazarlo con tu implementación real.
  final dataSource = TFTMatchDataSource(); // Este debe ser el constructor correcto para tu TFTMatchDataSource.
  return TFTMatchRepository(dataSource);
});

// FutureProvider para obtener match IDs por PUUID
final matchIdsProvider = FutureProvider.family<List<String>, String>((ref, puuid) async {
  // Aquí obtenemos la instancia del repositorio.
  final repository = ref.watch(tftMatchRepositoryProvider);
  // Aquí deberías tener lógica para determinar la región, por ahora usaremos una cadena estática como ejemplo.
  const region = 'your_region_here'; // Reemplaza con la lógica de tu aplicación.
  // Llamamos al método del repositorio usando la instancia del repositorio y retornamos los resultados.
  return repository.getMatchIdsByPUUID(puuid, region);
});

// FutureProvider para obtener detalles de las partidas por una lista de match IDs
final matchDetailsProvider = FutureProvider.family<List<MatchInfoModel>, List<String>>((ref, matchIds) async {
  // De nuevo, obtenemos la instancia del repositorio.
  final repository = ref.watch(tftMatchRepositoryProvider);
  // Al igual que antes, usamos un valor estático para la región como ejemplo.
  const region = 'your_region_here'; // Reemplaza con la lógica de tu aplicación.
  // Llamamos al método del repositorio y retornamos los resultados.
  return repository.getMatchDetailsByMatchIds(matchIds, region);
});
