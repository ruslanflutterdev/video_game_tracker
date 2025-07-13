import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_model.dart';
import '../providers/add_game_provider.dart';
import '../providers/games_list_provider.dart';
import '../providers/platform_provider.dart';
import '../utils/game_utils.dart';

class AddGameScreen extends ConsumerStatefulWidget {
  const AddGameScreen({super.key});

  @override
  ConsumerState<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends ConsumerState<AddGameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _releaseYearController = TextEditingController();
  String? _selectedPlatformId;
  GameStatus? _selectedStatus;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _releaseYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platforms = ref.watch(platformListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Добавить игру')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Название'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите название';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите описание';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _releaseYearController,
                decoration: InputDecoration(labelText: 'Год выпуска'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите год выпуска';
                  }
                  final year = int.tryParse(value);
                  if (year == null || year <= 0) {
                    return 'Введите корректный год';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Платформа'),
                value: _selectedPlatformId,
                items: platforms
                    .map(
                      (platform) => DropdownMenuItem(
                        value: platform.id,
                        child: Text(platform.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPlatformId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Выберите платформу';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<GameStatus>(
                decoration: InputDecoration(labelText: 'Статус'),
                value: _selectedStatus,
                items: GameStatus.values
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(GameUtils.statusText(status)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Выберите статус';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final game = GameModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      platformId: _selectedPlatformId!,
                      releaseYear: int.parse(
                        _releaseYearController.text.trim(),
                      ),
                      status: _selectedStatus!,
                    );

                    try {
                      await ref.read(addGameProvider(game).future);
                      if (!mounted) return;
                      ref.invalidate(gamesListProvider);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Игра добавлена')));
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
                    }
                  }
                },
                child: Text('Добавить игру'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
