import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers/patch_notes_providers.dart';

class PatchNotesScreen extends ConsumerWidget {
  String preprocessMarkdown(String content) {
    // Agrega un espacio de línea antes y después de los títulos en Markdown
    content = content.replaceAllMapped(RegExp(r'\*\*(.+?)\*\*'), (match) {
      return '\n\n**${match.group(1)}**\n\n';
    });
    // Asegura que cada punto seguido de un espacio sea el final de una línea
    content = content.replaceAll('. ', '.\n\n');
    return content;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patchNotesStream = ref.watch(patchNotesStreamProvider);

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
      body: patchNotesStream.when(
        data: (patchNotes) {
          return ListView.builder(
            itemCount: patchNotes.length,
            itemBuilder: (context, index) {
              final patchNote = patchNotes[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contenedor para el título, versión y URL de la imagen
                      Container(
                        color: Colors.black,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patchNote.title, // Título de la nota del parche
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Version: ${patchNote.version}', // Versión del parche
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          
                          ],
                        ),
                      ),

                      // Contenedor para el contenido de las notas del parche
                      Container(
                        color: Colors.black,
                        padding: const EdgeInsets.all(16.0),
                        child: MarkdownBody(
                          data: preprocessMarkdown(patchNote.content),
                          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                            p: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
                            strong: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
