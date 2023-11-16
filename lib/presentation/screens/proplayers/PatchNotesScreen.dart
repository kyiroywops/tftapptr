import 'package:flutter/material.dart';

class PatchNotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patch Notes'),
      ),
      body: const Center(
        child: Text('Contenido de Patch Notes aquí'),
      ),
    );
  }
}
