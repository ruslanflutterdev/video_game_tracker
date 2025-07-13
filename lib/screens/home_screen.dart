import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_tracker/models/game_model.dart';
import 'package:video_game_tracker/providers/games_list_provider.dart';
import 'package:video_game_tracker/providers/platform_provider.dart';
import '../models/platform_model.dart';
import '../widgets/game_card.dart';
import 'add_game_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  AsyncValue<List<GameModel>> _watchGames(WidgetRef ref) {
    return ref.watch(gamesListProvider);
  }

  List<PlatformModel> _watchPlatforms(WidgetRef ref) {
    return ref.watch(platformListProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesAsync = _watchGames(ref);
    final platforms = _watchPlatforms(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text('Game Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddGameScreen()),
              );
            },
          ),
        ],
      ),
      body: gamesAsync.when(
        data: (games) => games.isEmpty
            ? Center(child: Text('Список пуст'))
            : ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];
                  final platform = platforms.firstWhere(
                    (p) => p.id == game.platformId,
                    orElse: () => PlatformModel(
                      id: 'unknown',
                      name: 'Неизвестно',
                      logoAsset: 'assets/unknown.png',
                    ),
                  );
                  return GameCard(game: game, platform: platform);
                },
              ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка загрузки: $e')),
      ),
    );
  }
}
