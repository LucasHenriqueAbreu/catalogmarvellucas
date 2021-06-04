import 'package:catalogmarvellucas/core/models/character.dart';
import 'package:flutter/material.dart';

class ListHerois extends StatelessWidget {
  final List<Character> characters;
  final void Function(Character)? onPressed;

  const ListHerois({
    Key? key,
    required this.characters,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (_, index) {
        final character = characters[index];
        return ListTile(
          leading: Image.network(character.thumbnail.caminhoCompleto),
          title: Text(character.name),
          subtitle: Text(character.description),
          trailing: onPressed != null ? IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              this.onPressed!(character);
            },
          ) : null,
        );
      },
    );
  }
}
