import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Chips de filtro do web-nutriz (components/full/FilterChips): pilulas com o
/// selecionado em rosa e os demais em branco com borda.
class FilterChips<T> extends StatelessWidget {
  final List<({T valor, String rotulo})> opcoes;
  final T selecionado;
  final ValueChanged<T> onSelecionar;

  const FilterChips({
    super.key,
    required this.opcoes,
    required this.selecionado,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: opcoes.map((o) {
        final ativo = o.valor == selecionado;
        return GestureDetector(
          onTap: () => onSelecionar(o.valor),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: ativo ? AppColors.pink : AppColors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: ativo ? AppColors.pink : const Color(0xFFE5E7EB),
              ),
            ),
            child: Text(
              o.rotulo,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: ativo ? AppColors.white : const Color(0xFF6B7280),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Campo de busca do site (components/full/SearchBar).
class SearchBarNutriz extends StatelessWidget {
  final String dica;

  const SearchBarNutriz({super.key, required this.dica});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: TextField(
        readOnly: true,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: dica,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          prefixIcon: const Icon(Icons.search, size: 18),
          filled: true,
          fillColor: AppColors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: _borda(),
          enabledBorder: _borda(),
          focusedBorder: _borda(cor: AppColors.navy),
        ),
      ),
    );
  }

  OutlineInputBorder _borda({Color cor = const Color(0xFFE5E7EB)}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cor),
      );
}

/// Cabecalho dos cards do painel (DashboardCardHeader.tsx): icone circular,
/// titulo, subtitulo e linha divisoria.
class DashboardCardHeader extends StatelessWidget {
  final IconData icone;
  final Color corIcone;
  final Color fundoIcone;
  final String titulo;
  final String subtitulo;

  const DashboardCardHeader({
    super.key,
    required this.icone,
    required this.corIcone,
    required this.fundoIcone,
    required this.titulo,
    required this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: fundoIcone, shape: BoxShape.circle),
              child: Icon(icone, size: 18, color: corIcone),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2A37),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitulo,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Container(height: 1, color: const Color(0xFFE5E7EB)),
      ],
    );
  }
}

/// Cartao branco arredondado usado por todos os blocos do painel.
class DashboardCard extends StatelessWidget {
  final Widget child;

  const DashboardCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: child,
    );
  }
}
