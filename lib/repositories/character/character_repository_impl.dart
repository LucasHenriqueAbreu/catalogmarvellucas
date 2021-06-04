import 'package:catalogmarvellucas/core/http_provider/http_provider.dart';
import 'package:catalogmarvellucas/core/models/character.dart';
import 'package:catalogmarvellucas/core/models/character_data_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final HttpProvider httpProvider;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String url = '/v1/public/characters';

  CharacterRepositoryImpl({required this.httpProvider});

  @override
  Future<CharacterDataWrapper> get(Map<String, dynamic>? parametros) async {
    final result = await this.httpProvider.fetch(this.url, parametros);
    return CharacterDataWrapper.fromMap(result);
  }

  @override
  Future<void> favoritar(Character character) async {
    try {
      await firestore
          .collection('favoritos')
          .doc(character.id.toString())
          .set(character.toMap());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Character>> getFavoritos() async {
    final result = await firestore.collection('favoritos').get();
    return result.docs.map((query) => Character.fromMap(query.data())).toList();
  }
}
