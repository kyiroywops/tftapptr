import "package:go_router/go_router.dart";
import 'package:tftapp/presentation/screens/proplayers/ProPlayersScreen.dart';




final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreenProPlayers.name,
      builder: (context, state) => const HomeScreenProPlayers(),
    ),
  ],
);