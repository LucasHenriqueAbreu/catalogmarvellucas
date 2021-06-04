import 'package:catalogmarvellucas/core/http_provider/http_provider_implementation.dart';
import 'package:catalogmarvellucas/core/models/character.dart';
import 'package:catalogmarvellucas/pages/home/home_controller.dart';
import 'package:catalogmarvellucas/pages/search/search_page.dart';
import 'package:catalogmarvellucas/pages/widgets/list_herois.dart';
import 'package:catalogmarvellucas/repositories/character/character_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController(
    repository:
        CharacterRepositoryImpl(httpProvider: HttpProviderImplementation()),
  );

  @override
  void initState() {
    controller.getCharacters();
    controller.getCharactersFavoritos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.favorite)),
            ],
          ),
          title: Text('Catálogo'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _goToSearchPage,
            )
          ],
        ),
        body: TabBarView(
          children: [
            _createBodyHome(),
            _createBodyFavoritos(),
          ],
        ),
      ),
    );
  }

  Widget _createBodyHome() {
    return ValueListenableBuilder(
      valueListenable: controller.characters,
      builder: (_, __, ___) {
        return ListHerois(
          characters: controller.characters.value,
          onPressed: (Character character) {
            controller.favoritar(character);
          },
        );
      },
    );
  }

  Widget _createBodyFavoritos() {
    return ValueListenableBuilder(
      valueListenable: controller.charactersFavoritos,
      builder: (_, __, ___) {
        return ListHerois(
          characters: controller.charactersFavoritos.value,
        );
      },
    );
  }

  void _goToSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchPage(),
      ),
    );
  }
}
