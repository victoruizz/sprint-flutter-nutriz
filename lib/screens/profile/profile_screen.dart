import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/mock_sessao.dart';
import '../../data/mock_usuaria.dart';
import '../../models/perfil.dart';
import '../../widgets/content_container.dart';
import '../../widgets/page_title.dart';

/// Perfil do usuario, seguindo pages/private/profile do web-nutriz: cartao com
/// avatar, nome, e-mail e etiqueta do perfil; para a nutriz doadora, abas
/// "Meus dados" e "Meu bebe" com os campos editaveis e a barra de acoes que
/// aparece quando ha alteracoes.
class ProfileScreen extends StatefulWidget {
  final PerfilUsuario perfil;

  const ProfileScreen({super.key, this.perfil = PerfilUsuario.nutriz});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _borda = Color(0xFFE3EAF2);
  static const Color _tinta = Color(0xFF0E2A45);

  bool _abaBebe = false;
  bool _alterado = false;

  late final Map<String, TextEditingController> _campos;

  @override
  void initState() {
    super.initState();
    final u = usuariaMock;
    final endereco = u.endereco;

    _campos = {
      'nome': TextEditingController(text: _dados.nome),
      'telefone': TextEditingController(text: u.telefone),
      'email': TextEditingController(text: _dados.email),
      'cep': TextEditingController(text: endereco?.cep ?? ''),
      'numero': TextEditingController(text: endereco?.numero ?? ''),
      'complemento': TextEditingController(),
      'bebeNome': TextEditingController(text: u.bebe?.nome ?? ''),
      'bebeNascimento': TextEditingController(
        text: u.bebe == null ? '' : dataBr(u.bebe!.nascimento),
      ),
    };

    for (final c in _campos.values) {
      c.addListener(() {
        if (!_alterado) setState(() => _alterado = true);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _campos.values) {
      c.dispose();
    }
    super.dispose();
  }

  ({String nome, String subtitulo, String email}) get _dados =>
      switch (widget.perfil) {
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

  bool get _ehDoadora => widget.perfil == PerfilUsuario.nutriz;

  String _iniciais(String nome) => nome
      .trim()
      .split(' ')
      .take(2)
      .map((p) => p.isEmpty ? '' : p[0])
      .join()
      .toUpperCase();

  void _salvar() {
    setState(() => _alterado = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alteracoes salvas.'),
        backgroundColor: AppColors.teal,
      ),
    );
  }

  void _sair() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.landing,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ContentContainer(
          larguraMaxima: 1100,
          child: ListView(
            padding: EdgeInsets.only(
              top: AppSpacing.md,
              bottom: _alterado ? 100 : AppSpacing.md,
            ),
            children: [
              PageTitle(
                titulo: 'Perfil',
                descricao: _ehDoadora
                    ? 'Gerencie suas informacoes pessoais e de seu bebe.'
                    : 'Gerencie suas informacoes pessoais.',
              ),
              _cartaoIdentificacao(),
              const SizedBox(height: AppSpacing.md),
              if (_ehDoadora) ...[
                _abas(),
                const SizedBox(height: AppSpacing.md),
              ],
              if (!_ehDoadora || !_abaBebe) _secaoDados() else _secaoBebe(),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: _sair,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: Color(0xFFF3CACA)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Sair da conta'),
              ),
            ],
          ),
        ),
        if (_alterado) _barraAcoes(),
      ],
    );
  }

  Widget _cartaoIdentificacao() {
    final d = _dados;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borda),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.blueSoft,
            child: Text(
              _iniciais(d.nome),
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  d.nome,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _tinta,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  d.email,
                  style: const TextStyle(fontSize: 13, color: AppColors.muted),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.blueSoft,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    d.subtitulo,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _abas() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF2F7),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _aba('Meus dados', !_abaBebe, () => setState(() => _abaBebe = false)),
            _aba('Meu bebe', _abaBebe, () => setState(() => _abaBebe = true)),
          ],
        ),
      ),
    );
  }

  Widget _aba(String rotulo, bool ativo, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? AppColors.navy : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          rotulo,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ativo ? AppColors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _secaoDados() {
    return _cartao(
      titulo: 'Meus dados',
      filhos: [
        _campo('Nome completo', 'nome'),
        _campo('Telefone', 'telefone'),
        _campo('E-mail', 'email'),
        if (_ehDoadora) ...[
          const SizedBox(height: 4),
          const Text(
            'Endereco',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _tinta,
            ),
          ),
          const SizedBox(height: 12),
          _campo('CEP', 'cep'),
          _campo('Numero', 'numero'),
          _campo('Complemento', 'complemento', opcional: true),
        ],
      ],
    );
  }

  Widget _secaoBebe() {
    return _cartao(
      titulo: 'Meu bebe',
      filhos: [
        _campo('Nome do bebe', 'bebeNome'),
        _campo('Data de nascimento', 'bebeNascimento'),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.navy,
              minimumSize: const Size(0, 42),
              side: const BorderSide(color: Color(0xFFD0D9E8)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cadastro de mais bebes na versao completa.'),
              ),
            ),
            icon: const Icon(Icons.add, size: 16),
            label: const Text(
              'Adicionar bebe',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cartao({required String titulo, required List<Widget> filhos}) {
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
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _tinta,
            ),
          ),
          const SizedBox(height: 16),
          ...filhos,
        ],
      ),
    );
  }

  Widget _campo(String rotulo, String chave, {bool opcional = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                rotulo,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              if (opcional)
                const Text(
                  ' (opcional)',
                  style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _campos[chave],
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.navy),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Barra que so aparece quando ha alteracoes, como o BottomActionBar do site.
  Widget _barraAcoes() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: _borda)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => setState(() => _alterado = false),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF6B7280),
                  minimumSize: const Size(0, 44),
                ),
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size(0, 44),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _salvar,
                child: const Text(
                  'Salvar alteracoes',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
