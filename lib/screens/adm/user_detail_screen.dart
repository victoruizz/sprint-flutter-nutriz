import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/app_page.dart';
import '../../models/usuario_sistema.dart';
import '../../widgets/info_row.dart';
import '../../widgets/section_card.dart';

class UserDetailScreen extends StatelessWidget {
  final UsuarioSistema usuario;

  const UserDetailScreen({super.key, required this.usuario});

  void _acao(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          usuario.ativo
              ? 'Usuario ${usuario.nome} desativado.'
              : 'Usuario ${usuario.nome} reativado.',
        ),
        backgroundColor: AppColors.navy,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      titulo: 'Detalhe do usuario',
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.blueSoft,
                child: Text(
                  usuario.nome.isEmpty ? '?' : usuario.nome[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      usuario.nome,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      usuario.tipoLabel,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionCard(
            child: Column(
              children: [
                InfoRow(
                  icone: Icons.mail_outline,
                  label: 'E-mail',
                  valor: usuario.email,
                ),
                InfoRow(
                  icone: Icons.place_outlined,
                  label: 'Cidade',
                  valor: usuario.cidade,
                ),
                if (usuario.tipo == TipoUsuario.doadora)
                  InfoRow(
                    icone: Icons.favorite_outline,
                    label: 'Doacoes',
                    valor: '${usuario.doacoes}',
                  ),
                InfoRow(
                  icone: usuario.ativo
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  label: 'Situacao',
                  valor: usuario.ativo ? 'Ativo' : 'Inativo',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => _acao(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: usuario.ativo ? AppColors.pink : AppColors.teal,
              minimumSize: const Size.fromHeight(50),
              side: BorderSide(
                color: usuario.ativo ? AppColors.pink : AppColors.teal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: Icon(usuario.ativo ? Icons.block : Icons.check),
            label:
                Text(usuario.ativo ? 'Desativar usuario' : 'Reativar usuario'),
          ),
        ],
      ),
    );
  }
}
