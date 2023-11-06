
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String riotApiKey = dotenv.env['RIOT_API_KEY'] ?? 'no key';
}