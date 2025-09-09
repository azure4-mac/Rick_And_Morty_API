import 'package:flutter/material.dart';

class CharactersListScreen extends StatelessWidget {
  const CharactersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters List')),
      body: const Center(
        child: Text('List of Characters will be displayed here'),
      ),
    );
  }
}
