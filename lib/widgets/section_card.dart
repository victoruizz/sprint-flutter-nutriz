import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';

class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borda = BorderRadius.circular(AppSpacing.radius);
    final conteudo = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: borda,
        border: Border.all(color: AppColors.line),
      ),
      child: child,
    );

    if (onTap == null) return conteudo;
    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, borderRadius: borda, child: conteudo),
    );
  }
}
