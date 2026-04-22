import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/permissions.dart';
import '../../core/theme.dart';

class PermissionExplainerScreen extends ConsumerStatefulWidget {
  const PermissionExplainerScreen({super.key});

  @override
  ConsumerState<PermissionExplainerScreen> createState() =>
      _PermissionExplainerScreenState();
}

class _PermissionExplainerScreenState
    extends ConsumerState<PermissionExplainerScreen> {
  bool? _health;
  bool? _geo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => _save(context),
        ),
        title: const Text('permissions'),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              TiideSpacing.l, TiideSpacing.s, TiideSpacing.l, TiideSpacing.l),
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'tiide uses these only during a session,\nand stores samples locally. off by default.',
                style: TextStyle(
                  color: TiideColors.ink3,
                  fontStyle: FontStyle.italic,
                  height: 1.55,
                  fontSize: 14,
                ),
              ),
            ),
            _PermCard(
              icon: Icons.favorite_outline,
              name: 'heart rate & HRV',
              body:
                  'we read heart rate and HRV from the 10 minutes before a session and during. this surfaces patterns — not diagnoses.',
              note: 'HEALTHKIT · SESSION-ONLY',
              allowed: _health,
              onAllow: () => setState(() => _health = true),
              onDeny: () => setState(() => _health = false),
            ),
            const SizedBox(height: 12),
            _PermCard(
              icon: Icons.place_outlined,
              name: 'location',
              body:
                  'we take a single fix at session start, kept locally, to form quiet place-clusters you can name.',
              note: 'COARSE · NO TRAIL, NO SHARING',
              allowed: _geo,
              onAllow: () => setState(() => _geo = true),
              onDeny: () => setState(() => _geo = false),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(4, 20, 4, 8),
              child: Text(
                "you can revoke either at any time. sessions still work without them — you just won't see biometric or place insights.",
                style: TextStyle(
                  color: TiideColors.ink4,
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  height: 1.55,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _save(context),
                child: const Text('continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save(BuildContext context) async {
    final prefs = ref.read(permissionPrefsProvider);
    await prefs.setHealthOptIn(_health ?? false);
    await prefs.setGeoOptIn(_geo ?? false);
    await prefs.setExplainerShown();
    if (context.mounted) context.go('/');
  }
}

class _PermCard extends StatelessWidget {
  const _PermCard({
    required this.icon,
    required this.name,
    required this.body,
    required this.note,
    required this.allowed,
    required this.onAllow,
    required this.onDeny,
  });

  final IconData icon;
  final String name;
  final String body;
  final String note;
  final bool? allowed;
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: TiideColors.accentSoft,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: TiideColors.accent, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                          color: TiideColors.ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(height: 6),
                    Text(body,
                        style: const TextStyle(
                          color: TiideColors.ink2,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          height: 1.55,
                        )),
                    const SizedBox(height: 8),
                    Text(note,
                        style: const TextStyle(
                          color: TiideColors.ink4,
                          fontSize: 11,
                          letterSpacing: 1.0,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ChoiceButton(
                  label: 'not now',
                  primary: false,
                  active: allowed == false,
                  onTap: onDeny,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ChoiceButton(
                  label: 'allow',
                  primary: true,
                  active: allowed == true,
                  onTap: onAllow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.label,
    required this.primary,
    required this.active,
    required this.onTap,
  });
  final String label;
  final bool primary;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    final Color? border;
    if (primary) {
      bg = active ? TiideColors.accent : TiideColors.accent.withValues(alpha: 0.85);
      fg = Colors.white;
      border = null;
    } else {
      bg = active ? TiideColors.surfaceElev : Colors.transparent;
      fg = TiideColors.ink2;
      border = TiideColors.hair;
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: border == null ? null : Border.all(color: border),
        ),
        child: Text(label,
            style: TextStyle(color: fg, fontSize: 14)),
      ),
    );
  }
}
