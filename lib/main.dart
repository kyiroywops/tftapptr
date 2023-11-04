import 'package:flutter/material.dart';
import 'package:tftapp/config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tft Sinergy',
      theme: AppTheme().themeData,
    );
  }
}
