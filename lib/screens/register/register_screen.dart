import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/nutriz_logo.dart';
import 'components/wizard_field.dart';
import 'components/wizard_stepper.dart';

/// Cadastro da nutriz no mesmo formato do web-nutriz
/// (pages/public/register): assistente de quatro etapas com indicador de
/// progresso, cartao branco com o formulario e rodape com Voltar/Continuar.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const List<String> _etapas = [
    'Dados pessoais',
    'Endereco',
    'Senha',
    'Bebe e termos',
  ];

  final _chavesFormulario =
      List.generate(4, (_) => GlobalKey<FormState>());

  // Dados pessoais
  final _nome = TextEditingController();
  final _cpf = TextEditingController();
  final _nascimento = TextEditingController();
  final _telefone = TextEditingController();
  final _email = TextEditingController();

  // Endereco
  final _cep = TextEditingController();
  final _numero = TextEditingController();
  final _complemento = TextEditingController();

  // Senha
  final _senha = TextEditingController();
  final _confirmaSenha = TextEditingController();

  // Bebe
  final _nomeBebe = TextEditingController();
  final _nascimentoBebe = TextEditingController();

  int _etapa = 0;
  int _maxVisitada = 0;
  bool _temBebe = false;
  bool _aceitouTermos = false;
  bool _enviando = false;
  bool _sucesso = false;

  @override
  void dispose() {
    for (final c in [
      _nome,
      _cpf,
      _nascimento,
      _telefone,
      _email,
      _cep,
      _numero,
      _complemento,
      _senha,
      _confirmaSenha,
      _nomeBebe,
      _nascimentoBebe,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _ultimaEtapa => _etapa == _etapas.length - 1;

  void _irParaEtapa(int destino) {
    setState(() {
      _etapa = destino;
      _maxVisitada = _maxVisitada > destino ? _maxVisitada : destino;
    });
  }

  Future<void> _continuar() async {
    if (!_chavesFormulario[_etapa].currentState!.validate()) return;

    if (!_ultimaEtapa) {
      _irParaEtapa(_etapa + 1);
      return;
    }

    if (!_aceitouTermos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E preciso aceitar os termos para criar a conta.'),
        ),
      );
      return;
    }

    setState(() => _enviando = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _enviando = false;
      _sucesso = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WizardStepperCores.fundo,
      body: Column(
        children: [
          _cabecalho(),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 48),
                    child: _sucesso ? _cartaoSucesso() : _formulario(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cabecalho() {
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      child: const SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: NutrizLogo(altura: 40)),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.navy,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          icon: const Icon(Icons.chevron_left, size: 18),
          label: const Text(
            'Voltar',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Criacao de usuario',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0E2A45),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Preencha seus dados para comecar a doar. Leva menos de 2 minutos.',
          style: TextStyle(fontSize: 13.5, color: WizardStepperCores.textoSuave),
        ),
        const SizedBox(height: 24),
        WizardStepper(
          etapas: _etapas,
          atual: _etapa,
          maxVisitada: _maxVisitada,
          onEtapaTocada: (i) {
            if (i <= _etapa) {
              _irParaEtapa(i);
            } else if (_chavesFormulario[_etapa].currentState!.validate()) {
              _irParaEtapa(i);
            }
          },
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: WizardStepperCores.borda),
          ),
          clipBehavior: Clip.antiAlias,
          child: Form(
            key: _chavesFormulario[_etapa],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: _conteudoEtapa(),
                ),
                _rodapeFormulario(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _conteudoEtapa() {
    switch (_etapa) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WizardField(
              rotulo: 'Nome completo',
              dica: 'Digite seu nome completo',
              controlador: _nome,
              validador: _obrigatorio,
            ),
            WizardField(
              rotulo: 'CPF',
              dica: '000.000.000-00',
              controlador: _cpf,
              tipoTeclado: TextInputType.number,
              validador: _obrigatorio,
            ),
            WizardField(
              rotulo: 'Data de nascimento',
              dica: 'DD/MM/AAAA',
              controlador: _nascimento,
              tipoTeclado: TextInputType.datetime,
              validador: _obrigatorio,
            ),
            WizardField(
              rotulo: 'Telefone',
              dica: '(11) 98765-4321',
              controlador: _telefone,
              tipoTeclado: TextInputType.phone,
              validador: _obrigatorio,
            ),
            WizardField(
              rotulo: 'Email',
              dica: 'voce@email.com',
              controlador: _email,
              tipoTeclado: TextInputType.emailAddress,
              validador: (v) {
                final t = (v ?? '').trim();
                if (t.isEmpty) return 'Email e obrigatorio.';
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(t)) {
                  return 'Informe um email valido.';
                }
                return null;
              },
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WizardField(
              rotulo: 'CEP',
              dica: '00000-000',
              controlador: _cep,
              tipoTeclado: TextInputType.number,
              validador: _obrigatorio,
            ),
            WizardField(
              rotulo: 'Numero',
              dica: '1543',
              controlador: _numero,
              tipoTeclado: TextInputType.number,
              validador: _obrigatorio,
            ),
            WizardField(
              rotulo: 'Complemento',
              dica: 'Apto, bloco...',
              controlador: _complemento,
              opcional: true,
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WizardField(
              rotulo: 'Senha',
              dica: 'Crie uma senha',
              controlador: _senha,
              senha: true,
              validador: (v) {
                if ((v ?? '').length < 6) {
                  return 'A senha deve ter no minimo 6 caracteres.';
                }
                return null;
              },
            ),
            WizardField(
              rotulo: 'Confirmar senha',
              dica: 'Repita a senha',
              controlador: _confirmaSenha,
              senha: true,
              validador: (v) {
                if (v != _senha.text) return 'As senhas nao conferem.';
                return null;
              },
            ),
          ],
        );
      default:
        return _etapaBebeTermos();
    }
  }

  Widget _etapaBebeTermos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confira seus dados',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF09090B),
          ),
        ),
        const SizedBox(height: 12),
        _resumo('Nome', _nome.text),
        _resumo('Email', _email.text),
        _resumo('Telefone', _telefone.text),
        _resumo('CEP', _cep.text),
        const SizedBox(height: 20),
        const Divider(color: WizardStepperCores.borda),
        const SizedBox(height: 12),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _temBebe,
          onChanged: (v) => setState(() => _temBebe = v),
          activeThumbColor: WizardStepperCores.azul,
          title: const Text(
            'Tenho um bebe',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'Informe os dados do seu bebe (opcional).',
            style: TextStyle(fontSize: 12.5, color: Color(0xFF71717A)),
          ),
        ),
        if (_temBebe) ...[
          const SizedBox(height: 12),
          WizardField(
            rotulo: 'Nome do bebe',
            dica: 'Nome do bebe',
            controlador: _nomeBebe,
            validador: _obrigatorio,
          ),
          WizardField(
            rotulo: 'Data de nascimento do bebe',
            dica: 'DD/MM/AAAA',
            controlador: _nascimentoBebe,
            tipoTeclado: TextInputType.datetime,
            validador: _obrigatorio,
          ),
        ],
        const SizedBox(height: 4),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: _aceitouTermos,
          activeColor: WizardStepperCores.azul,
          onChanged: (v) => setState(() => _aceitouTermos = v ?? false),
          title: const Text(
            'Li e aceito os termos de uso e a politica de privacidade.',
            style: TextStyle(fontSize: 13.5),
          ),
        ),
      ],
    );
  }

  Widget _resumo(String rotulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              rotulo,
              style: const TextStyle(
                fontSize: 13,
                color: WizardStepperCores.textoSuave,
              ),
            ),
          ),
          Expanded(
            child: Text(
              valor.isEmpty ? '-' : valor,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF09090B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rodapeFormulario() {
    return Container(
      color: WizardStepperCores.rodapeCard,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // Wrap para os botoes quebrarem a linha em telas estreitas em vez de
      // estourar o rodape.
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (_etapa == 0)
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: WizardStepperCores.textoSuave,
                minimumSize: const Size(0, 44),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            )
          else
            OutlinedButton.icon(
              onPressed: _enviando ? null : () => _irParaEtapa(_etapa - 1),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF09090B),
                backgroundColor: AppColors.white,
                minimumSize: const Size(0, 44),
                side: const BorderSide(color: WizardStepperCores.borda),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.chevron_left, size: 16),
              label: const Text(
                'Voltar',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ElevatedButton(
            onPressed: _enviando ? null : _continuar,
            style: ElevatedButton.styleFrom(
              backgroundColor: WizardStepperCores.azul,
              foregroundColor: AppColors.white,
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _enviando
                ? const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('Criando conta...'),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_ultimaEtapa) ...[
                        const Icon(Icons.check, size: 16),
                        const SizedBox(width: 8),
                        const Text(
                          'Criar conta',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ] else ...[
                        const Text(
                          'Continuar',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, size: 16),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _cartaoSucesso() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: WizardStepperCores.borda),
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F0FB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check,
                    size: 32, color: WizardStepperCores.azul),
              ),
              const SizedBox(height: 16),
              const Text(
                'Conta criada com sucesso!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: WizardStepperCores.azul,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Seu cadastro foi concluido. Faca login para acessar a sua '
                'conta e comecar a doar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                  color: WizardStepperCores.textoSuave,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WizardStepperCores.azul,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size(0, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  ),
                  child: const Text(
                    'Voltar ao inicio',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _obrigatorio(String? v) {
    if ((v ?? '').trim().isEmpty) return 'Campo obrigatorio.';
    return null;
  }
}
