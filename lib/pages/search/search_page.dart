import 'dart:async';

import 'package:catalogmarvellucas/core/http_provider/http_provider_implementation.dart';
import 'package:catalogmarvellucas/pages/search/search_controller.dart';
import 'package:catalogmarvellucas/pages/widgets/list_herois.dart';
import 'package:catalogmarvellucas/repositories/character/character_repository_impl.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  SearchController _controller = SearchController(
      repository:
          CharacterRepositoryImpl(httpProvider: HttpProviderImplementation()));

  Timer? _timerSearch;

  @override
  void initState() {
    _textEditingController.addListener(() {
      if (_timerSearch?.isActive ?? false) _timerSearch!.cancel();
      _timerSearch = Timer(Duration(seconds: 3), () {
        _controller.getCharacters(_textEditingController.text);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pesquise aqui...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: _createBodyResults(),
            )
          ],
        ),
      ),
    );
  }

  Widget _createBodyResults() {
    return ValueListenableBuilder(
      valueListenable: _controller.characters,
      builder: (_, __, ___) {
        if (_controller.characters.value.length == 0) {
          return Center(child: Text('Nada foi encontrado...'));
        }
        return ListHerois(
          characters: _controller.characters.value,
        );
      },
    );
  }
}
