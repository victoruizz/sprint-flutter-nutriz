import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/theme/app_colors.dart';
import '../../models/etapa_doacao.dart';
import '../../widgets/app_page.dart';
import '../../widgets/status_badge.dart';

/// Detalhe de uma etapa da doacao na visao da nutriz, seguindo
/// pages/private/donations/common/step-detail do web-nutriz: cartao de
/// destaque com o numero e o status, informacoes da etapa (data e endereco),
/// responsavel e o bloco "sobre esta etapa".
class StepDetailScreen extends StatelessWidget {
  static const Color _titulo = Color(0xFF0E2A45);
  static const Color _borda = Color(0xFFE3EAF2);

  final EtapaDoacao etapa;
  final int numero;
  final String enderecoColeta;

  const StepDetailScreen({
    super.key,
    required this.etapa,
    required this.numero,
    required this.enderecoColeta,
  });

  @override
  Widget build(BuildContext context) {
    final iniciada = etapa.status != StatusEtapa.pendente;

    return AppPage(
      titulo: 'Etapa da doacao',
      larguraMaxima: 640,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          if (!iniciada)
            _naoIniciada()
          else ...[
            _destaque(),
            const SizedBox(height: 16),
            if (etapa.data != null) _informacoes(),
            if (etapa.enfermeira != null) ...[
              const SizedBox(height: 16),
              _responsavel(),
            ],
            const SizedBox(height: 16),
            _sobre(),
          ],
        ],
      ),
    );
  }

  Widget _naoIniciada() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: const Column(
        children: [
          Icon(Icons.schedule, size: 30, color: Color(0xFF6B8FAA)),
          SizedBox(height: 10),
          Text(
            'Etapa ainda nao iniciada',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _titulo,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Assim que esta etapa comecar, os detalhes aparecerao aqui.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFF6B8FAA)),
          ),
        ],
      ),
    );
  }

  Widget _destaque() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.blueSoft,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$numero',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Etapa $numero - ${etapa.titulo}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: _titulo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          StatusBadge(status: etapa.status),
        ],
      ),
    );
  }

  Widget _informacoes() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informacoes da etapa',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A41),
            ),
          ),
          const SizedBox(height: 14),
          _linha(Icons.calendar_today_outlined, 'Data / Previsao',
              dataBr(etapa.data!)),
          const SizedBox(height: 12),
          Container(height: 1, color: _borda),
          const SizedBox(height: 12),
          _linha(Icons.place_outlined, 'Endereco', enderecoColeta),
        ],
      ),
    );
  }

  Widget _responsavel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDD4F2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.medical_services_outlined,
              size: 20, color: Color(0xFF6D28D9)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Responsavel pela etapa',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 2),
                Text(
                  etapa.enfermeira!,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: _titulo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sobre() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sobre esta etapa',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A41),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            etapa.observacao ?? etapa.descricao,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppColors.slate,
            ),
          ),
        ],
      ),
    );
  }

  Widget _linha(IconData icone, String rotulo, String valor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icone, size: 18, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rotulo,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              const SizedBox(height: 2),
              Text(
                valor,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: _titulo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
