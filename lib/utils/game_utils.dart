import '../models/game_model.dart';

class GameUtils {
  static String statusText(GameStatus status) {
    switch (status) {
      case GameStatus.wantToBuy:
        return 'Хочу купить';
      case GameStatus.purchased:
        return 'Куплена';
      case GameStatus.playing:
        return 'В процессе';
      case GameStatus.completed:
        return 'Пройдена';
    }
  }
}
