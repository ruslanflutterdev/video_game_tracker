import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_tracker/models/game_model.dart';
import 'package:video_game_tracker/providers/game_service_provider.dart';

final gamesListProvider = FutureProvider<List<GameModel>>((ref) async {
  final service = ref.read(gameServiceProvider);
  return await service.fetchGames();
});
