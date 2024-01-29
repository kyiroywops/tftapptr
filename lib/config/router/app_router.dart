import 'package:go_router/go_router.dart';
import 'package:tftapp/presentation/screens/proplayers/BaseScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/CompositionsTrendingScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/PatchNotesScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/ProPlayersScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/SearchPlayersScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/StreamPlayers.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BaseScreen(),
    ),
    GoRoute(
      path: '/pro_players',
      builder: (context, state) => ChallengersScreen(),
    ),
    GoRoute(
      path: '/patch_notes',
      builder: (context, state) => PatchNotesScreen(),
    ),
    GoRoute(
      path: '/search_players',
      builder: (context, state) => SearchPlayersScreen(),
    ),
    GoRoute(
      path: '/compositions',
      builder: (context, state) => CompositionsScreen(),
    ),
     GoRoute(
      path: '/streamplayers',
      builder: (context, state) => StreamPlayers(),
    ),
  ],
);
