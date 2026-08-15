import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/ponto_coleta.dart';
import '../../widgets/info_row.dart';
import '../../widgets/section_card.dart';

class PointDetailScreen extends StatelessWidget {
  final PontoColeta ponto;

  const PointDetailScreen({super.key, required this.ponto});

  void _agendar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Solicitacao enviada para ${ponto.nome}.'),
        backgroundColor: AppColors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ponto de coleta')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.blueSoft,
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: const Center(
              child: Icon(Icons.map_outlined, size: 56, color: AppColors.blue),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            ponto.nome,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SectionCard(
            child: Column(
              children: [
                InfoRow(
                  icone: Icons.place_outlined,
                  label: 'Endereco',
                  valor: '${ponto.endereco} - ${ponto.bairro}, ${ponto.cidade}',
                ),
                InfoRow(
                  icone: Icons.near_me_outlined,
                  label: 'Distancia',
                  valor: '${ponto.distanciaKm.toStringAsFixed(1)} km de voce',
                ),
                InfoRow(
                  icone: Icons.schedule,
                  label: 'Horario',
                  valor: ponto.horario,
                ),
                InfoRow(
                  icone: ponto.coletaDomiciliar
                      ? Icons.home_outlined
                      : Icons.storefront_outlined,
                  label: 'Tipo de coleta',
                  valor: ponto.tipoColeta,
                ),
                InfoRow(
                  icone: ponto.aberto
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  label: 'Situacao',
                  valor: ponto.aberto ? 'Aberto agora' : 'Fechado no momento',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            onPressed: () => _agendar(context),
            icon: const Icon(Icons.event_available),
            label: const Text('Solicitar coleta'),
          ),
        ],
      ),
    );
  }
}
