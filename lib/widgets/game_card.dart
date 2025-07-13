import 'package:flutter/material.dart';
import 'package:video_game_tracker/models/game_model.dart';
import '../models/platform_model.dart';
import '../utils/game_utils.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  final PlatformModel platform;

  const GameCard({super.key, required this.game, required this.platform});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: Image.asset(
          platform.logoAsset,
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
        ),
        title: Text(game.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Описание: ${game.description}'),
            Text('Платформа: ${platform.name}'),
            Text('Год выпуска: ${game.releaseYear}'),
            Text('Статус: ${GameUtils.statusText(game.status)}'),
          ],
        ),
      ),
    );
  }
}
