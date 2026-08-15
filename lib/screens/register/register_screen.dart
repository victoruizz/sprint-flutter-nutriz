import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();
  final _cidade = TextEditingController();
  final _bairro = TextEditingController();
  final _bebe = TextEditingController();

  bool _temBebe = false;
  bool _aceitouTermos = false;
  bool _carregando = false;
  bool _enviado = false;

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _telefone.dispose();
    _cidade.dispose();
    _bairro.dispose();
    _bebe.dispose();
    super.dispose();
  }

  String? _obrigatorio(String? v) =>
      (v ?? '').trim().isEmpty ? 'Campo obrigatorio' : null;

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_aceitouTermos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E preciso aceitar os termos para continuar.'),
          backgroundColor: AppColors.pink,
        ),
      );
      return;
    }
    setState(() => _carregando = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      _carregando = false;
      _enviado = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: _enviado ? _sucesso() : _formulario(),
    );
  }

  Widget _formulario() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _titulo('Dados pessoais'),
            TextFormField(
              controller: _nome,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nome completo'),
              validator: _obrigatorio,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (v) {
                final t = (v ?? '').trim();
                if (t.isEmpty) return 'Campo obrigatorio';
                if (!t.contains('@') || !t.contains('.')) {
                  return 'E-mail invalido';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _telefone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Telefone'),
              validator: _obrigatorio,
            ),
            const SizedBox(height: AppSpacing.lg),
            _titulo('Endereco'),
            TextFormField(
              controller: _cidade,
              decoration: const InputDecoration(labelText: 'Cidade'),
              validator: _obrigatorio,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _bairro,
              decoration: const InputDecoration(labelText: 'Bairro'),
              validator: _obrigatorio,
            ),
            const SizedBox(height: AppSpacing.lg),
            _titulo('Bebe (opcional)'),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Tenho um bebe para cadastrar'),
              value: _temBebe,
              onChanged: (v) => setState(() => _temBebe = v),
            ),
            if (_temBebe)
              TextFormField(
                controller: _bebe,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Nome do bebe'),
                validator: (v) => _temBebe ? _obrigatorio(v) : null,
              ),
            const SizedBox(height: AppSpacing.lg),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                'Li e aceito os Termos de Uso e a Politica de Privacidade.',
                style: TextStyle(fontSize: 13.5),
              ),
              value: _aceitouTermos,
              onChanged: (v) => setState(() => _aceitouTermos = v ?? false),
            ),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
              onPressed: _carregando ? null : _enviar,
              child: _carregando
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
                  : const Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sucesso() {
    final nome = _nome.text.trim().split(' ').first;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              color: AppColors.tealSoft,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.check_circle, color: AppColors.teal, size: 64),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Cadastro concluido${nome.isEmpty ? '' : ', $nome'}!',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Sua conta de doadora foi criada. A equipe Lactare vai te acompanhar em cada etapa da doacao.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              ),
              child: const Text('Comecar a usar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titulo(String texto) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
          ),
        ),
      );
}
