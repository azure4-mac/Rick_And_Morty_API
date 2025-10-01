import 'package:flutter/material.dart';
import 'package:rickandmortyapi/model/Character.dart' as model;

class CharacterDetailPage extends StatelessWidget {
  final model.Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(character.image, width: 150, height: 150),
            ),
            const SizedBox(height: 16),
            Text(
              "Name: ${character.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Species: ${character.species}"),
            Text("Status: ${character.status}"),
            Text("Gender: ${character.gender}"),
            Text("Origin: ${character.origin}"),
          ],
        ),
      ),
    );
  }
}
