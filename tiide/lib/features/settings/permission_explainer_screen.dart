import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/permissions.dart';
import '../../core/theme.dart';

/// Shown once before first session to explain Health + Location usage
/// and let the user opt in granularly.
class PermissionExplainerScreen extends ConsumerStatefulWidget {
  const PermissionExplainerScreen({super.key});

  @override
  ConsumerState<PermissionExplainerScreen> createState() =>
      _PermissionExplainerScreenState();
}

class _PermissionExplainerScreenState
    extends ConsumerState<PermissionExplainerScreen> {
  bool _health = true;
  bool _geo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TiideSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(Icons.shield_outlined,
                  color: TiideColors.accent, size: 56),
              const SizedBox(height: TiideSpacing.l),
              Text(
                'your data, your choice',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TiideSpacing.m),
              Text(
                'tiide can enrich sessions with heart-rate / HRV and '
                'location to help you spot triggers.\n\n'
                'everything stays local and encrypted — '
                'you can change these any time in settings.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TiideSpacing.xl),
              _PermToggle(
                icon: Icons.favorite_outline,
                label: 'Heart Rate & HRV',
                description: 'reads 5 min before & after each session',
                value: _health,
                onChanged: (v) => setState(() => _health = v),
              ),
              const SizedBox(height: TiideSpacing.m),
              _PermToggle(
                icon: Icons.location_on_outlined,
                label: 'Coarse Location',
                description: 'one point at start + end, never continuous',
                value: _geo,
                onChanged: (v) => setState(() => _geo = v),
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () => _save(context),
                child: const Text('CONTINUE'),
              ),
              const SizedBox(height: TiideSpacing.s),
              TextButton(
                onPressed: () => _skip(context),
                child: const Text('skip for now',
                    style: TextStyle(color: TiideColors.silver)),
              ),
              const SizedBox(height: TiideSpacing.m),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    final prefs = ref.read(permissionPrefsProvider);
    await prefs.setHealthOptIn(_health);
    await prefs.setGeoOptIn(_geo);
    await prefs.setExplainerShown();
    if (context.mounted) context.go('/');
  }

  Future<void> _skip(BuildContext context) async {
    final prefs = ref.read(permissionPrefsProvider);
    await prefs.setHealthOptIn(false);
    await prefs.setGeoOptIn(false);
    await prefs.setExplainerShown();
    if (context.mounted) context.go('/');
  }
}

class _PermToggle extends StatelessWidget {
  const _PermToggle({
    required this.icon,
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TiideSpacing.m),
      decoration: BoxDecoration(
        color: TiideColors.darkSurface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
      ),
      child: Row(
        children: [
          Icon(icon, color: TiideColors.accent, size: 28),
          const SizedBox(width: TiideSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: TiideColors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(description,
                    style: const TextStyle(
                        fontSize: 12, color: TiideColors.silver)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: TiideColors.accent,
          ),
        ],
      ),
    );
  }
}
