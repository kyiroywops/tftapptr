import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tftapp/presentation/providers/patch_notes_providers.dart';

class PatchNotesScreen extends ConsumerWidget {
  String preprocessMarkdown(String content) {
    content = content.replaceAllMapped(RegExp(r'\*\*(.+?)\*\*'), (match) {
      return '\n\n**${match.group(1)}**\n\n';
    });
    content = content.replaceAll('. ', '.\n\n');
    return content;
  }

  String calculateTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return 'published ${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return 'published ${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return 'published ${difference.inMinutes} minutes ago';
    } else {
      return 'published moments ago';
    }
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
              final timeAgo = calculateTimeAgo(patchNote.releaseDate);

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.89),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:8, horizontal: 8), // Añadido padding inferior
                                child: Text(
                                  patchNote.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ReadexPro',
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
                                  children: [
                                    Text(
                                      patchNote.version,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ReadexPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      timeAgo,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'ReadexPro',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0), // Aquí defines el radio del borde
                                child: Image.network(
                                  patchNote.imageUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: MarkdownBody(
                            data: preprocessMarkdown(patchNote.content),
                            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                      
                              p: const TextStyle(
                                
                                color: Colors.white,
                                
                                fontFamily: 'ReadexPro',
                                fontSize: 16,
                              ),
                              strong: const TextStyle(

                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
