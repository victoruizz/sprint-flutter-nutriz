import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_sessao.dart';
import '../../data/mock_usuaria.dart';
import '../../models/perfil.dart';
import '../../widgets/info_row.dart';
import '../../widgets/section_card.dart';

/// Perfil do usuario logado. Adapta o conteudo ao papel (doadora, admin ou
/// enfermeiro). Para a nutriz, mostra bebe e endereco.
class ProfileScreen extends StatelessWidget {
  final PerfilUsuario perfil;

  const ProfileScreen({super.key, this.perfil = PerfilUsuario.nutriz});

  ({String nome, String subtitulo, String email}) get _dados => switch (perfil) {
        PerfilUsuario.nutriz => (
            nome: usuariaMock.nome,
            subtitulo: 'Doadora',
            email: usuariaMock.email,
          ),
        PerfilUsuario.adm => (
            nome: adminMock.nome,
            subtitulo: adminMock.cargo,
            email: adminMock.email,
          ),
        PerfilUsuario.nurse => (
            nome: nurseMock.nome,
            subtitulo: nurseMock.cargo,
            email: nurseMock.email,
          ),
      };

  String _iniciais(String nome) {
    final partes = nome.trim().split(' ');
    final letras = partes.take(2).map((p) => p.isEmpty ? '' : p[0]).join();
    return letras.toUpperCase();
  }

  void _sair(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = _dados;
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.blueSoft,
                child: Text(
                  _iniciais(d.nome),
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
                      d.nome,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      d.subtitulo,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (perfil == PerfilUsuario.nutriz)
            ..._conteudoNutriz()
          else
            _conteudoEquipe(d.email),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => _sair(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.pink,
              minimumSize: const Size.fromHeight(50),
              side: const BorderSide(color: AppColors.pink),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  Widget _conteudoEquipe(String email) {
    return SectionCard(
      child: Column(
        children: [
          InfoRow(icone: Icons.mail_outline, label: 'E-mail', valor: email),
          const InfoRow(
            icone: Icons.badge_outlined,
            label: 'Vinculo',
            valor: 'Equipe Lactare',
          ),
        ],
      ),
    );
  }

  List<Widget> _conteudoNutriz() {
    final nutriz = usuariaMock;
    return [
      _titulo('Dados pessoais'),
      SectionCard(
        child: Column(
          children: [
            InfoRow(
              icone: Icons.mail_outline,
              label: 'E-mail',
              valor: nutriz.email,
            ),
            InfoRow(
              icone: Icons.phone_outlined,
              label: 'Telefone',
              valor: nutriz.telefone,
            ),
            InfoRow(
              icone: Icons.cake_outlined,
              label: 'Idade',
              valor: '${nutriz.idade} anos',
            ),
            InfoRow(
              icone: Icons.water_drop_outlined,
              label: 'Leite doado',
              valor: '${nutriz.leiteDoadoMl.toInt()} ml',
            ),
          ],
        ),
      ),
      if (nutriz.bebe != null) ...[
        const SizedBox(height: AppSpacing.md),
        _titulo('Bebe'),
        SectionCard(
          child: Column(
            children: [
              InfoRow(
                icone: Icons.child_care_outlined,
                label: 'Nome',
                valor: nutriz.bebe!.nome,
              ),
              InfoRow(
                icone: Icons.timeline_outlined,
                label: 'Fase',
                valor: nutriz.bebe!.faseDescricao,
              ),
            ],
          ),
        ),
      ],
      if (nutriz.endereco != null) ...[
        const SizedBox(height: AppSpacing.md),
        _titulo('Endereco'),
        SectionCard(
          child: Column(
            children: [
              InfoRow(
                icone: Icons.place_outlined,
                label: 'Logradouro',
                valor: nutriz.endereco!.linha,
              ),
              InfoRow(
                icone: Icons.map_outlined,
                label: 'Bairro / Cidade',
                valor: nutriz.endereco!.resumo,
              ),
              InfoRow(
                icone: Icons.markunread_mailbox_outlined,
                label: 'CEP',
                valor: nutriz.endereco!.cep,
              ),
            ],
          ),
        ),
      ],
    ];
  }

  Widget _titulo(String texto) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
        ),
      );
}
