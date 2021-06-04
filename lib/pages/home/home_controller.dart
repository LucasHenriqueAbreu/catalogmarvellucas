
import 'package:catalogmarvellucas/core/models/character.dart';
import 'package:catalogmarvellucas/repositories/character/character_repository.dart';
import 'package:flutter/widgets.dart';

class HomeController extends ChangeNotifier {
  final CharacterRepository repository;

  ValueNotifier<List<Character>> characters = ValueNotifier([]);
  ValueNotifier<List<Character>> charactersFavoritos = ValueNotifier([]);

  HomeController({required this.repository});

  Future<void> getCharacters() async {
    final result = await this.repository.get(null);
    characters.value = result.data.results;
  }

  Future<void> favoritar(Character character) async {
    await this.repository.favoritar(character);
  }

  Future<void> getCharactersFavoritos() async {
    charactersFavoritos.value = await this.repository.getFavoritos();
    print(charactersFavoritos.value);
  }


}