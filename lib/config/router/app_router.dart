import "package:go_router/go_router.dart";
import 'package:tftapp/presentation/screens/proplayers/CompositionsTrendingScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/PatchNotesScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/ProPlayersScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/SearchPlayersScreen.dart';




final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ProPlayersScreen(),
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
  ],
);
