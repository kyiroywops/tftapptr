import "package:go_router/go_router.dart";
import 'package:tftapp/presentation/screens/proplayers/ProPlayersScreen.dart';




final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreenProPlayers(),
    ),
    GoRoute(
      path: '/patch_notes',
      builder: (context, state) => const PatchNotesScreen(),
    ),
    GoRoute(
      path: '/search_players',
      builder: (context, state) => const SearchPlayersScreen(),
    ),
    GoRoute(
      path: '/compositions',
      builder: (context, state) => const CompositionsScreen(),
    ),
  ],
);
