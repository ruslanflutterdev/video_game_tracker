import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_game_tracker/services/game_service.dart';

final gameServiceProvider = Provider<GameService>((ref) => GameService());
