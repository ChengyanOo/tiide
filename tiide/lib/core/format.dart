// Small format helpers used across redesigned screens.

String formatTimeOfDay(DateTime d) {
  final h24 = d.hour;
  final h = h24 == 0 ? 12 : (h24 > 12 ? h24 - 12 : h24);
  final m = d.minute.toString().padLeft(2, '0');
  final suffix = h24 < 12 ? 'am' : 'pm';
  return '$h:$m $suffix';
}

/// "today" / "yesterday" / "mon, apr 21" — lowercase per mockup.
String formatSessionDateBucket(DateTime d, DateTime now) {
  final today = DateTime(now.year, now.month, now.day);
  final that = DateTime(d.year, d.month, d.day);
  final diff = today.difference(that).inDays;
  if (diff == 0) return 'today';
  if (diff == 1) return 'yesterday';
  const days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  const months = [
    'jan', 'feb', 'mar', 'apr', 'may', 'jun',
    'jul', 'aug', 'sep', 'oct', 'nov', 'dec',
  ];
  return '${days[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}';
}

String formatDurationShort(int minutes) {
  if (minutes < 60) return '${minutes}m';
  final h = minutes ~/ 60;
  final m = minutes % 60;
  if (m == 0) return '${h}h';
  return '${h}h ${m}m';
}

/// `M:SS` for short replays, `MM:SS` for session countdowns. Negative → "done".
String formatMMSS(Duration d, {bool padMinutes = false}) {
  if (d.isNegative) return 'done';
  final totalSec = d.inSeconds;
  final m = totalSec ~/ 60;
  final s = totalSec % 60;
  final mm = padMinutes ? m.toString().padLeft(2, '0') : m.toString();
  return '$mm:${s.toString().padLeft(2, '0')}';
}
