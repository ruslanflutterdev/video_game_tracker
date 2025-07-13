import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/platform_model.dart';

final platformListProvider = Provider<List<PlatformModel>>((ref) {
  return [
    PlatformModel(id: 'pc', name: 'PC', logoAsset: 'assets/pc.png'),
    PlatformModel(
      id: 'ps5',
      name: 'PlayStation 5',
      logoAsset: 'assets/ps5.png',
    ),
    PlatformModel(
      id: 'xbox',
      name: 'Xbox Series X',
      logoAsset: 'assets/xbox.png',
    ),
    PlatformModel(
      id: 'switch',
      name: 'Nintendo Switch',
      logoAsset: 'assets/switch.png',
    ),
    PlatformModel(id: 'deck', name: 'Steam Deck', logoAsset: 'assets/deck.png'),
  ];
});
