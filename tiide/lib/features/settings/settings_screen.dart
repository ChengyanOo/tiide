import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/permissions.dart';
import '../../core/theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('settings')),
      body: ListView(
        padding: const EdgeInsets.all(TiideSpacing.m),
        children: [
          _SettingsTile(
            icon: Icons.play_circle_outline,
            label: 'Replay Onboarding',
            subtitle: 'walk through the intro again',
            onTap: () async {
              final prefs = ref.read(permissionPrefsProvider);
              await prefs.resetOnboarding();
              if (context.mounted) context.go('/onboarding');
            },
          ),
          const SizedBox(height: TiideSpacing.s),
          _SettingsTile(
            icon: Icons.shield_outlined,
            label: 'Permissions',
            subtitle: 'health & location opt-in',
            onTap: () => context.push('/permissions'),
          ),
          const SizedBox(height: TiideSpacing.s),
          _SettingsTile(
            icon: Icons.lock_outline,
            label: 'Privacy Center',
            subtitle: 'export, delete, encryption status',
            onTap: () => context.push('/privacy'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TiideColors.darkSurface,
      borderRadius: BorderRadius.circular(TiideRadius.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(TiideRadius.card),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(TiideSpacing.m),
          child: Row(
            children: [
              Icon(icon, color: TiideColors.accent, size: 24),
              const SizedBox(width: TiideSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            color: TiideColors.white,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: TiideColors.silver)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: TiideColors.borderGray),
            ],
          ),
        ),
      ),
    );
  }
}
