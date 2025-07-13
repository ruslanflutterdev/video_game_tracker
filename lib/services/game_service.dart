import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:video_game_tracker/models/game_model.dart';

class GameService {
  final String baseUrl =
      'https://videogametracker-13cee-default-rtdb.europe-west1.firebasedatabase.app/games';

  Future<List<GameModel>> fetchGames() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded == null) {
        return [];
      }

      final Map<String, dynamic> data = decoded;
      return data.entries
          .map((entry) => GameModel.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Загрузка не удалась: ${response.statusCode}');
    }
  }

  Future<void> addGame(GameModel game) async {
    final response = await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(game.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Не удалось добавить игру: ${response.statusCode}');
    }
  }
}
