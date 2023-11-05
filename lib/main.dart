import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tftapp/config/constants/environment.dart';

Future<void> main() async{
   await dotenv.load(fileName: ".env");

    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fetchData(); // Llamamos a la función para probar la API
    return MaterialApp(
      title: 'Tft Sinergy',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Test'),
        ),
        body: Center(
          child: Text('Prueba de API en el cuerpo del widget'),
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.riotgames.com/tft/match/v1/',
        headers: {
          'X-Riot-Token': Enviroment.riotApiKey,
        },
      ),
    );

    try {
      final response = await dio.get('matches/by-puuid/9wtqe0_9jqnAzHb-NzMeHQ0CQADVq0GQsS-F_2nU_ZEiO4QhjhXPKRTLppRTza9S1927K-eONC5IGQ/ids?region=NA1');
      if (response.statusCode == 200) {
        final List<String> matchIds = List<String>.from(response.data);
        print('Match IDs: $matchIds');
      } else {
        print('Failed to fetch match IDs');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
