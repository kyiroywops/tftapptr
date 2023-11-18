import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PatchNotesScreen extends StatelessWidget {
  // Asumimos que aquí colocas el contenido de tus patch notes que obtuviste de Firestore.
  final String patchNotesContent;

  PatchNotesScreen({Key? key, required this.patchNotesContent}) : super(key: key);

  String preprocessMarkdown(String content) {
    // Procesa el contenido como necesites, por ejemplo:
    // - Añadir líneas nuevas después de los titulos
    // - Añadir líneas nuevas después de los puntos.
    // Aquí puedes agregar tu lógica personalizada.
    return content;
  }

  @override
  Widget build(BuildContext context) {
    String processedContent = preprocessMarkdown(patchNotesContent);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patch Notes',
          style: TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MarkdownBody(
          data: processedContent,
          styleSheet: MarkdownStyleSheet(
            p: const TextStyle(fontSize: 16),
            h1: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            h2: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            // Puedes seguir añadiendo estilos para h3, h4, strong (negritas), em (cursivas), etc.
          ),
        ),
      ),
    );
  }
}
