import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/model/Character.dart';

class CharactersPage extends StatefulWidget {
  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final List<Character> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchCharacters();
      }
    });
  }

  Future<void> _fetchCharacters() async {
    setState(() => _isLoading = true);

    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character?page=$_currentPage'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _characters.addAll(
          (data['results'] as List).map((c) => Character.fromJson(c)),
        );
        _currentPage++;
        _hasMore = data['info']['next'] != null;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Characters")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _characters.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _characters.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final c = _characters[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  c.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                c.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Species: ${c.species}"),
                  Text("Status: ${c.status}"),
                  Text("Gender: ${c.gender}"),
                  Text("Origin: ${c.origin}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
