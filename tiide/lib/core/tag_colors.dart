import 'package:flutter/material.dart';

/// Palette for tag dots/chips — mirrors redesign/src/ui.jsx TAG_COLORS.
const Map<String, Color> tagColors = {
  'craving': Color(0xFFB8855F),
  'anger': Color(0xFFA05A45),
  'anxiety': Color(0xFF6B7C8A),
  'loneliness': Color(0xFF7A6B8A),
  'boredom': Color(0xFF8A8467),
  'grief': Color(0xFF4A5866),
  'relapse': Color(0xFF3D4A4F),
  'practice': Color(0xFF5A6B5A),
};

Color? colorForTag(String label) => tagColors[label.toLowerCase()];
