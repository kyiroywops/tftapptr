import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tftapp/presentation/providers/bottomNavigation_provider.dart';
import 'package:tftapp/presentation/screens/proplayers/PatchNotesScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/ProPlayersScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/SearchPlayersScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/StreamPlayers.dart';

class BaseScreen extends ConsumerWidget {
  static final List<Widget> _screens = [
    ChallengersScreen(),
    StreamPlayers(),
    PatchNotesScreen(),
    SearchPlayersScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black, 
            
          ),
          child: GNav(
            gap: 8, // Espacio entre el ícono y el texto
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            selectedIndex: selectedIndex,
            iconSize: 25,
            padding: const EdgeInsets.all(15),
            onTabChange: (index) => ref.watch(bottomNavigationProvider.notifier).selectTab(index),
            tabs: const [
              GButton(
                icon: Icons.verified,
                text: 'ProPlayers Tracker',
              ),
              GButton(
                icon: Icons.local_fire_department,
                text: 'Trending Comps',
              ),
              GButton(
                icon: Icons.route,
                text: 'Patch Notes',
              ),
              GButton(
                icon: Icons.person_search,
                text: 'Search',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
