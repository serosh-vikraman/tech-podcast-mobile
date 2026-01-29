import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_podcast_mobile/presentation/widgets/audio/mini_player.dart';
import 'package:tech_podcast_mobile/presentation/widgets/side_menu.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({required this.navigationShell, super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Current route index
    final currentIndex = widget.navigationShell.currentIndex;
    const bgColor = Color(0xFF030712);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      drawerScrimColor: bgColor,
      endDrawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: const Color(0xFF030712),
          statusBarIconBrightness: Brightness.light,
        ),
        titleSpacing: 20,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            const Text(
              'CareerTwin',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937), // Dark Gray
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF374151)),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF9CA3AF), // Light Gray
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444), // Red 500
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: Color(0xFF1F2937), width: 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Menu Button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937), // Dark Gray
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF374151)),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              padding: EdgeInsets.zero,
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // Main Content - Wrap in Material to prevent surface tints
          Positioned.fill(
            child: Material(
              color: bgColor,
              type: MaterialType.canvas,
              child: widget.navigationShell,
            ),
          ),

          // MiniPlayer placed above the bottom bar
          const Positioned(left: 0, right: 0, bottom: 90, child: MiniPlayer()),
        ],
      ),
      // Custom FAB for "Create" (Index 2)
      floatingActionButton: Container(
        height: 64,
        width: 64,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF10B981),
              Color(0xFF0D9488),
            ], // Emerald500 to Teal600
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _goBranch(2),
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded, size: 32, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ColoredBox(
        color: bgColor,
        child: SafeArea(
          // Ensure bottom navigation respects system navigation bar insets
          top: false,
          bottom: true,
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              border: const Border(
                top: BorderSide(color: Color(0xFF262626)),
              ), // Keep border
            ),
            child: BottomAppBar(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              color: bgColor,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              notchMargin: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    0,
                    Icons.home_rounded,
                    Icons.home_outlined,
                    'Home',
                    currentIndex,
                  ),
                  _buildNavItem(
                    1,
                    Icons.library_music_rounded,
                    Icons.library_music_outlined,
                    'Library',
                    currentIndex,
                  ),
                  const SizedBox(width: 48), // Spacer for FAB
                  _buildNavItem(
                    3,
                    Icons.featured_play_list_rounded,
                    Icons.featured_play_list_outlined,
                    'My Playlist',
                    currentIndex,
                  ),
                  _buildNavItem(
                    4,
                    Icons.person_rounded,
                    Icons.person_outline_rounded,
                    'Profile',
                    currentIndex,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData selectedIcon,
    IconData unselectedIcon,
    String label,
    int currentIndex,
  ) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => _goBranch(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected
                  ? const Color(0xFF10B981)
                  : const Color(0xFF737373), // Emerald500 vs Neutral500
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF10B981)
                    : const Color(0xFF737373),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
