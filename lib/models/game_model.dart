class GameModel {
  final String id;
  final String title;
  final String description;
  final String platformId;
  final int releaseYear;
  final GameStatus status;

  GameModel({
    required this.id,
    required this.title,
    required this.description,
    required this.platformId,
    required this.releaseYear,
    required this.status,
  }) {
    if (id.trim().isEmpty) {
      throw ArgumentError('ID не может быть пустым');
    }
    if (title.trim().isEmpty) {
      throw ArgumentError('Название не может быть пустым');
    }
    if (description.trim().isEmpty) {
      throw ArgumentError('Описание не может быть пустым');
    }
    if (platformId.trim().isEmpty) {
      throw ArgumentError('ID платформы не может быть пустым');
    }
    if (releaseYear <= 0) {
      throw ArgumentError('Год выпуска должен быть положительным числом');
    }
  }

  factory GameModel.fromJson(String id, Map<String, dynamic> json) {
    return GameModel(
      id: id,
      title: json['title'],
      description: json['description'],
      platformId: json['platformId'],
      releaseYear: json['releaseYear'],
      status: GameStatus.values.byName(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'platformId': platformId,
    'releaseYear': releaseYear,
    'status': status.name,
  };
}

enum GameStatus { wantToBuy, purchased, playing, completed }
