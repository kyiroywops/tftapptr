import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tftapp/presentation/providers/bottomNavigation_provider.dart';
import 'package:tftapp/presentation/screens/proplayers/CompositionsTrendingScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/PatchNotesScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/ProPlayersScreen.dart';
import 'package:tftapp/presentation/screens/proplayers/SearchPlayersScreen.dart';

class BaseScreen extends ConsumerWidget {
  static final List<Widget> _screens = [
    ProPlayersScreen(),
    CompositionsScreen(),
    PatchNotesScreen(),
    SearchPlayersScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: _screens,

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(

        ),
        child: GNav(
          gap:10,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          selectedIndex: selectedIndex,
          onTabChange: (index) => ref.watch(bottomNavigationProvider.notifier).selectTab(index),
          tabs: const [
            GButton(
              icon: Icons.verified,
              iconSize: 25,
              text: 'ProPlayers',
              
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
            ),]
        )
      ),
    );
  }
}
