import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/mock_pontos.dart';
import '../../../models/ponto_coleta.dart';
import '../../../widgets/content_container.dart';
import 'section_label.dart';

/// Secao de pontos de coleta (CollectionPointsSection.tsx): busca, filtros
/// e a lista de bancos de leite. O mapa do web vira um painel estatico aqui,
/// ja que o app da sprint e 100% mockado e sem dependencias externas.
class LandingPoints extends StatefulWidget {
  const LandingPoints({super.key});

  @override
  State<LandingPoints> createState() => _LandingPointsState();
}

class _LandingPointsState extends State<LandingPoints> {
  bool _somenteDomiciliar = false;

  @override
  Widget build(BuildContext context) {
    final pontos = _somenteDomiciliar
        ? pontosMock.where((p) => p.coletaDomiciliar).toList()
        : pontosMock;

    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: ContentContainer(
        espacoAcima: 48,
        espacoAbaixo: 24,
        child: Column(
        children: [
          const SectionLabel(texto: 'PONTOS DE COLETA', cor: AppColors.blue),
          const SizedBox(height: 12),
          const Text(
            'Encontre um banco de leite perto de voce',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.inkDeep,
              height: 1.15,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7FA),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5EBF3)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Buscar ponto de coleta',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.line),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.line),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _chipFiltro('Todos', !_somenteDomiciliar,
                        () => setState(() => _somenteDomiciliar = false)),
                    const SizedBox(width: 8),
                    _chipFiltro('Coleta Domiciliar', _somenteDomiciliar,
                        () => setState(() => _somenteDomiciliar = true)),
                  ],
                ),
                const SizedBox(height: 16),
                ...pontos.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _CardPonto(ponto: p),
                  ),
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _chipFiltro(String rotulo, bool ativo, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: ativo ? AppColors.pink : AppColors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: ativo ? AppColors.pink : AppColors.line),
        ),
        child: Text(
          rotulo,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ativo ? AppColors.white : AppColors.slate,
          ),
        ),
      ),
    );
  }
}

class _CardPonto extends StatelessWidget {
  final PontoColeta ponto;

  const _CardPonto({required this.ponto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  ponto.nome,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.inkDeep,
                  ),
                ),
              ),
              Text(
                '${ponto.distanciaKm.toStringAsFixed(1)} km',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${ponto.endereco} - ${ponto.bairro}, ${ponto.cidade}',
            style: const TextStyle(fontSize: 13, color: AppColors.slate),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _tag(
                ponto.aberto ? 'Aberto agora' : 'Fechado',
                ponto.aberto ? const Color(0xFF0F766E) : AppColors.muted,
                ponto.aberto ? const Color(0xFFD5F3EA) : AppColors.line,
              ),
              if (ponto.coletaDomiciliar) ...[
                const SizedBox(width: 8),
                _tag('Coleta domiciliar', AppColors.navy, AppColors.blueSoft),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _tag(String texto, Color cor, Color fundo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fundo,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: cor,
        ),
      ),
    );
  }
}
