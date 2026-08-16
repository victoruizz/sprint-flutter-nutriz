import 'package:flutter/material.dart';

import '../core/date_format.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../models/etapa_doacao.dart';

class TimelineTile extends StatelessWidget {
  final EtapaDoacao etapa;
  final bool ultima;

  const TimelineTile({super.key, required this.etapa, this.ultima = false});

  Color get _cor => switch (etapa.status) {
        StatusEtapa.concluida => AppColors.teal,
        StatusEtapa.emAndamento => AppColors.navy,
        StatusEtapa.pendente => AppColors.line,
        StatusEtapa.erro => const Color(0xFFA32D2D),
      };

  IconData get _icone => switch (etapa.status) {
        StatusEtapa.concluida => Icons.check,
        StatusEtapa.emAndamento => Icons.autorenew,
        StatusEtapa.pendente => Icons.circle_outlined,
        StatusEtapa.erro => Icons.priority_high,
      };

  @override
  Widget build(BuildContext context) {
    final pendente = etapa.status == StatusEtapa.pendente;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: pendente ? AppColors.white : _cor,
                  shape: BoxShape.circle,
                  border: Border.all(color: _cor, width: 2),
                ),
                child: Icon(
                  _icone,
                  size: 16,
                  color: pendente ? AppColors.muted : AppColors.white,
                ),
              ),
              if (!ultima)
                Expanded(child: Container(width: 2, color: AppColors.line)),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    etapa.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.ink,
                    ),
                  ),
                  if (etapa.data != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      dataExtenso(etapa.data!),
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    etapa.descricao,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 13.5,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
