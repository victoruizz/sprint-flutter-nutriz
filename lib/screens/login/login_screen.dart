import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/perfil.dart';
import '../../widgets/nutriz_logo.dart';
import '../adm/adm_shell.dart';
import '../home/home_shell.dart';
import '../nurse/nurse_shell.dart';

/// Login mockado: valida o formato dos campos e permite escolher o perfil
/// (doadora, administrador ou enfermeiro) para explorar cada area do app.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.navy,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: NutrizLogo(size: 56)),
                const SizedBox(height: AppSpacing.xl),
                const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Escolha um perfil para explorar o app.',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: AppSpacing.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SegmentedButton<PerfilUsuario>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: PerfilUsuario.nutriz,
                        label: Text('Doadora'),
                      ),
                      ButtonSegment(
                        value: PerfilUsuario.adm,
                        label: Text('Admin'),
                      ),
                      ButtonSegment(
                        value: PerfilUsuario.nurse,
                        label: Text('Enferm.'),
                      ),
                    ],
                    selected: {_perfil},
                    onSelectionChanged: (s) =>
                        setState(() => _perfil = s.first),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  validator: (v) {
                    final t = (v ?? '').trim();
                    if (t.isEmpty) return 'Informe seu e-mail';
                    if (!t.contains('@') || !t.contains('.')) {
                      return 'E-mail invalido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _senhaCtrl,
                  obscureText: _ocultarSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _ocultarSenha
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () =>
                          setState(() => _ocultarSenha = !_ocultarSenha),
                    ),
                  ),
                  validator: (v) {
                    if ((v ?? '').length < 6) {
                      return 'A senha deve ter ao menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: _carregando ? null : _entrar,
                  child: _carregando
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : const Text('Entrar'),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ainda nao tem conta?',
                      style: TextStyle(color: AppColors.muted),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                      child: const Text('Cadastre-se'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
