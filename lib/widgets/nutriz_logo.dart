import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class NutrizLogo extends StatelessWidget {
  final double size;
  final bool light;

  const NutrizLogo({super.key, this.size = 40, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            gradient: AppColors.evaGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.water_drop,
            color: AppColors.white,
            size: size * 0.55,
          ),
        ),
        SizedBox(width: size * 0.3),
        Text(
          'Nutriz',
          style: TextStyle(
            fontSize: size * 0.62,
            fontWeight: FontWeight.w800,
            color: light ? AppColors.white : AppColors.navy,
          ),
        ),
      ],
    );
  }
}
