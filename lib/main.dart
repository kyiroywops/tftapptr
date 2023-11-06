import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tftapp/config/router/app_router.dart';
import 'package:tftapp/config/theme/app_theme.dart';


// faltaria solo colocar el provider con providerscope
Future<void> main() async{
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
