import 'package:catalogmarvellucas/core/models/character.dart';
import 'package:catalogmarvellucas/core/models/character_data_wrapper.dart';

abstract class CharacterRepository {
  Future<CharacterDataWrapper> get(Map<String, dynamic>? parametros);
  Future<void> favoritar(Character character);
  Future<List<Character>> getFavoritos();
}
