import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class SuggestionChip extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;

  const SuggestionChip({super.key, required this.texto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blueSoft,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            texto,
            style: const TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
