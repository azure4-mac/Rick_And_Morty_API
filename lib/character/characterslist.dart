import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/model/Character.dart';
import 'dart:convert';

class CharactersPage extends StatefulWidget {
  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  Future<List<Character>> getCharacters() async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((c) => Character.fromJson(c)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Characters")),
      body: FutureBuilder<List<Character>>(
        future: getCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }

          final characters = snapshot.data!;
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return ExpansionTile(
                leading: Image.network(character.image, width: 50, height: 50),
                title: Text(character.name),
                subtitle: Text("${character.species} — ${character.status}"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(character.image, width: 150, height: 150),
                        const SizedBox(height: 10),
                        Text("Nome: ${character.name}"),
                        Text("Status: ${character.status}"),
                        Text("Espécie: ${character.species}"),
                        Text("Gênero: ${character.gender}"),
                        Text("Origem: ${character.origin}"),
                        Text("Criado em: ${character.created}"),
                        Text("URL: ${character.url}"),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
