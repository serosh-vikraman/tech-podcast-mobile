import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_podcast_mobile/core/providers/dummy_user_provider.dart';
import 'package:tech_podcast_mobile/data/repositories/auth_repository.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final user = authRepository.currentUser;
    final email = user?.email ?? 'Guest';
    final name = user?.displayName ?? 'User';

    // ... colors ...
    const backgroundColor = Color(0xFF1F2937); // Dark Gray
    const headerColor = Color(0xFF111827); // Darker Gray
    const iconColor = Color(0xFF9CA3AF); // Light Gray
    const textColor = Colors.white;

    return Drawer(
      backgroundColor: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // User Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              color: headerColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF374151),
                    backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                    child: user?.photoURL == null ? Text(
                      name.isNotEmpty ? name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ) : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(color: iconColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.person_outline,
                    label: 'My Twin Profile',
                    onTap: () {
                      context.pop(); // Close drawer
                      context.go('/profile');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.lock_outline,
                    label: 'The Vault',
                    onTap: () {
                      context.pop(); // Close drawer
                      context.push('/vault');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.monetization_on_outlined,
                    label: 'Pricing',
                    onTap: () {
                      context.pop(); // Close drawer
                      context.push('/pricing');
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.credit_card,
                    label: 'Billing & Subscription',
                    onTap: () {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Billing & Subscription clicked'),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.settings_outlined,
                    label: 'Account Settings',
                    onTap: () {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account Settings clicked'),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Color(0xFF374151),
                    height: 32,
                    thickness: 1,
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.logout_rounded,
                    label: 'Sign Out',
                    textColor: const Color(0xFFEF4444),
                    iconColor: const Color(0xFFEF4444),
                    onTap: () async {
                      context.pop(); // Close drawer
                      await ref.read(authRepositoryProvider).signOut();
                      ref.read(dummyUserProvider.notifier).logout();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? const Color(0xFF9CA3AF),
        size: 24,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      horizontalTitleGap: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
