import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/perfil.dart';
import '../../widgets/nutriz_logo.dart';
import '../adm/adm_shell.dart';
import '../home/home_shell.dart';
import '../nurse/nurse_shell.dart';

/// Login no mesmo desenho do web-nutriz (pages/public/login/index.tsx):
/// circulos pastel no topo, wordmark centralizada, cartao com os campos
/// arredondados e o botao azul da marca.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color _azulBotao = Color(0xFF0B57B8);
  static const Color _tituloEscuro = Color(0xFF16224A);
  static const Color _textoSuave = Color(0xFF54648A);
  static const Color _bordaCampo = Color(0xFFE2E7F1);

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  bool _carregando = false;
  bool _ocultarSenha = true;
  PerfilUsuario _perfil = PerfilUsuario.nutriz;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _carregando = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _carregando = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login realizado com sucesso!'),
        backgroundColor: AppColors.teal,
      ),
    );
    final Widget destino = switch (_perfil) {
      PerfilUsuario.nutriz => const HomeShell(),
      PerfilUsuario.adm => const AdmShell(),
      PerfilUsuario.nurse => const NurseShell(),
    };
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destino),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          _circulosDecorativos(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
              // `max-w-sm` do login do site: coluna estreita centralizada.
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 384),
                  child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: NutrizLogo(altura: 44, light: false)),
                    const SizedBox(height: 20),
                    const Text(
                      'Bem-vinda(o) de volta!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: _tituloEscuro,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Faca login para acessar sua conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: _textoSuave),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: _bordaCampo, height: 1),
                    const SizedBox(height: 24),
                    _cartaoFormulario(),
                    const SizedBox(height: 24),
                    const Divider(color: _bordaCampo, height: 1),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ainda nao tem uma conta?',
                          style: TextStyle(fontSize: 14, color: _textoSuave),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, AppRoutes.register),
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1C5FD0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartaoFormulario() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _bordaCampo),
        boxShadow: [
          BoxShadow(
            color: _azulBotao.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _rotulo('E-mail'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: _decoracao(
              dica: 'Digite seu e-mail',
              sufixo: const Icon(Icons.mail_outline,
                  size: 20, color: Color(0xFF9AA3B8)),
            ),
            validator: (v) {
              final t = (v ?? '').trim();
              if (t.isEmpty) return 'E-mail e obrigatorio.';
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(t)) {
                return 'Informe um e-mail valido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _rotulo('Senha'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _senhaCtrl,
            obscureText: _ocultarSenha,
            decoration: _decoracao(
              dica: 'Digite sua senha',
              sufixo: IconButton(
                icon: Icon(
                  _ocultarSenha
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: const Color(0xFF9AA3B8),
                ),
                tooltip: _ocultarSenha ? 'Mostrar senha' : 'Ocultar senha',
                onPressed: () =>
                    setState(() => _ocultarSenha = !_ocultarSenha),
              ),
            ),
            validator: (v) {
              final t = v ?? '';
              if (t.trim().isEmpty) return 'Senha e obrigatoria.';
              if (t.length < 6) {
                return 'A senha deve ter no minimo 6 caracteres.';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _azulBotao,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: _carregando ? null : _entrar,
              child: _carregando
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Entrando...'),
                      ],
                    )
                  : const Text(
                      'Entrar',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          _seletorPerfil(),
        ],
      ),
    );
  }

  /// Atalho da sprint: o produto real separa os perfis pelo tipo do usuario
  /// autenticado. Como aqui o login e mockado, a escolha fica explicita para
  /// permitir navegar pelas areas de doadora, administracao e enfermagem.
  Widget _seletorPerfil() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Entrar como (demonstracao)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E3C5E),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SegmentedButton<PerfilUsuario>(
          showSelectedIcon: false,
          style: SegmentedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 12.5),
            selectedBackgroundColor: AppColors.blueSoft,
            selectedForegroundColor: AppColors.navy,
          ),
          segments: const [
            ButtonSegment(value: PerfilUsuario.nutriz, label: Text('Doadora')),
            ButtonSegment(value: PerfilUsuario.adm, label: Text('Admin')),
            ButtonSegment(value: PerfilUsuario.nurse, label: Text('Enferm.')),
          ],
          selected: {_perfil},
          onSelectionChanged: (s) => setState(() => _perfil = s.first),
        ),
      ],
    );
  }

  Widget _rotulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2E3C5E),
      ),
    );
  }

  InputDecoration _decoracao({required String dica, required Widget sufixo}) {
    OutlineInputBorder borda(Color cor) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: cor),
        );

    return InputDecoration(
      hintText: dica,
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9AA3B8)),
      filled: true,
      fillColor: AppColors.white,
      suffixIcon: sufixo,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: borda(_bordaCampo),
      enabledBorder: borda(_bordaCampo),
      focusedBorder: borda(_azulBotao),
      errorBorder: borda(const Color(0xFFF87171)),
      focusedErrorBorder: borda(const Color(0xFFF87171)),
    );
  }

  /// Circulos pastel do topo da tela de login do web.
  Widget _circulosDecorativos() {
    return SizedBox(
      height: 256,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
              left: -64,
              top: -48,
              child: _circulo(176, const Color(0xFFCFE0F8))),
          Positioned(
              left: 28, top: 64, child: _circulo(64, const Color(0xFFF6D4DC))),
          Positioned(
              right: -48,
              top: -56,
              child: _circulo(208, const Color(0xFFDBE7FB))),
          Positioned(
              right: 20, top: 96, child: _circulo(80, const Color(0xFFF6D4DC))),
          Positioned(
              right: 96, top: 16, child: _circulo(48, const Color(0xFFCFE0F8))),
        ],
      ),
    );
  }

  Widget _circulo(double tamanho, Color cor) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
    );
  }
}
