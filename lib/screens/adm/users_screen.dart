import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../widgets/app_page.dart';
import '../../data/mock_usuarios.dart';
import '../../models/usuario_sistema.dart';
import '../../widgets/section_card.dart';
import 'user_detail_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      titulo: 'Usuarios',
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        itemCount: usuariosMock.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final usuario = usuariosMock[i];
          return SectionCard(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UserDetailScreen(usuario: usuario),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.blueSoft,
                  child: Text(
                    usuario.nome.isEmpty ? '?' : usuario.nome[0].toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w800,
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
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.ink,
                        ),
                      ),
                      Text(
                        usuario.cidade,
                        style: const TextStyle(
                            color: AppColors.muted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                _TipoChip(usuario: usuario),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TipoChip extends StatelessWidget {
  final UsuarioSistema usuario;

  const _TipoChip({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final (Color fg, Color bg) = switch (usuario.tipo) {
      TipoUsuario.doadora => (AppColors.pink, AppColors.pinkSoft),
      TipoUsuario.enfermeiro => (AppColors.teal, AppColors.tealSoft),
      TipoUsuario.administrador => (AppColors.navy, AppColors.blueSoft),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(
        usuario.tipoLabel,
        style:
            TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 11.5),
      ),
    );
  }
}
