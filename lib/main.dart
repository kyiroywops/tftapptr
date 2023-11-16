import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Asegúrate de importar flutter_riverpod
import 'package:tftapp/config/router/app_router.dart';
import 'package:tftapp/config/theme/app_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    ProviderScope( // Envuelve tu aplicación en un ProviderScope
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tft Sinergy',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme().themeData,
    );
  }
}
