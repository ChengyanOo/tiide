import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/permissions.dart';
import '../../core/theme.dart';
import '../../shared/ink_card.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _cloudSync = false;

  @override
  Widget build(BuildContext context) {
    final prefs = ref.watch(permissionPrefsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text('settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          const _SectionLabel('SESSION'),
          InkCard(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.zero,
            clip: Clip.antiAlias,
            child: Column(children: [
            _Row(
              icon: Icons.water_drop_outlined,
              label: 'default duration',
              trailing: const _RowTrail(value: '15 min'),
              onTap: () {},
            ),
            _Row(
              icon: Icons.spa_outlined,
              label: 'calming visual',
              trailing: const _RowTrail(value: 'tide'),
              onTap: () {},
            ),
            _Row(
              icon: Icons.menu_book_outlined,
              label: 'verse library',
              trailing: const _RowTrail(),
              onTap: () => context.push('/verses'),
              last: true,
            ),
          ]),
          ),
          const _SectionLabel('DATA & PRIVACY'),
          InkCard(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.zero,
            clip: Clip.antiAlias,
            child: Column(children: [
            _Row(
              icon: Icons.favorite_outline,
              label: 'biometrics',
              trailing: _ToggleTrail(
                text: prefs.healthOptIn ? 'on' : 'off',
                value: prefs.healthOptIn,
                onChanged: (v) async {
                  await ref.read(permissionPrefsProvider).setHealthOptIn(v);
                  if (mounted) setState(() {});
                },
              ),
            ),
            _Row(
              icon: Icons.place_outlined,
              label: 'location',
              trailing: _ToggleTrail(
                text: prefs.geoOptIn ? 'on' : 'off',
                value: prefs.geoOptIn,
                onChanged: (v) async {
                  await ref.read(permissionPrefsProvider).setGeoOptIn(v);
                  if (mounted) setState(() {});
                },
              ),
            ),
            _Row(
              icon: Icons.cloud_outlined,
              label: 'cloud sync',
              sub: 'opt-in, off by default',
              trailing: _ToggleTrail(
                text: _cloudSync ? 'on' : 'off',
                value: _cloudSync,
                onChanged: (v) => setState(() => _cloudSync = v),
              ),
            ),
            _Row(
              icon: Icons.tune,
              label: 'permissions',
              trailing: const _RowTrail(),
              onTap: () => context.push('/permissions'),
              last: true,
            ),
          ]),
          ),
          const _SectionLabel('APPEARANCE'),
          InkCard(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.zero,
            clip: Clip.antiAlias,
            child: Column(children: [
            _Row(
              icon: Icons.nightlight_outlined,
              label: 'theme',
              trailing: const _RowTrail(value: 'dusk · auto'),
              onTap: () {},
            ),
            _Row(
              icon: Icons.water_drop_outlined,
              label: 'accent',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _Swatch(color: TiideColors.accent),
                  SizedBox(width: 6),
                  Text('sumi ink',
                      style: TextStyle(color: TiideColors.ink3, fontSize: 14)),
                  SizedBox(width: 6),
                  Icon(Icons.chevron_right,
                      size: 16, color: TiideColors.ink4),
                ],
              ),
              onTap: () {},
              last: true,
            ),
          ]),
          ),
          const _SectionLabel('YOUR DATA'),
          InkCard(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.zero,
            clip: Clip.antiAlias,
            child: Column(children: [
            _Row(
              icon: Icons.file_download_outlined,
              label: 'export as JSON',
              trailing: const _RowTrail(),
              onTap: () => context.push('/privacy'),
            ),
            _Row(
              icon: Icons.close,
              label: 'delete all data',
              trailing: const _RowTrail(),
              onTap: () => context.push('/privacy'),
              last: true,
            ),
            _Row(
              icon: Icons.refresh,
              label: 'replay onboarding',
              trailing: const _RowTrail(),
              onTap: () async {
                await ref.read(permissionPrefsProvider).resetOnboarding();
                if (context.mounted) context.go('/onboarding');
              },
              last: true,
            ),
          ]),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 28, 24, 0),
            child: Text(
              'tiide is offline by default. every session stays\non this device until you say otherwise.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: TiideColors.ink4,
                fontStyle: FontStyle.italic,
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 22, 24, 8),
      child: Text(
        text,
        style: const TextStyle(
          color: TiideColors.ink4,
          fontSize: 11,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.label,
    required this.trailing,
    this.sub,
    this.onTap,
    this.last = false,
  });
  final IconData icon;
  final String label;
  final String? sub;
  final Widget trailing;
  final VoidCallback? onTap;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: last
              ? null
              : const Border(
                  bottom: BorderSide(color: TiideColors.hair2),
                ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: TiideColors.ink3),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                        color: TiideColors.ink,
                        fontSize: 15,
                      )),
                  if (sub != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(sub!,
                          style: const TextStyle(
                            color: TiideColors.ink4,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _RowTrail extends StatelessWidget {
  const _RowTrail({this.value});
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(value!,
                style: const TextStyle(
                    color: TiideColors.ink3, fontSize: 14)),
          ),
        const Icon(Icons.chevron_right, size: 16, color: TiideColors.ink4),
      ],
    );
  }
}

class _ToggleTrail extends StatelessWidget {
  const _ToggleTrail({
    required this.text,
    required this.value,
    required this.onChanged,
  });
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text,
            style:
                const TextStyle(color: TiideColors.ink3, fontSize: 14)),
        const SizedBox(width: 6),
        Transform.scale(
          scale: 0.85,
          child: Switch(value: value, onChanged: onChanged),
        ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
