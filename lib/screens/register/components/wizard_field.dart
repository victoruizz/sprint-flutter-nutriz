import 'package:flutter/material.dart';

/// Campo do formulario de cadastro, no mesmo desenho do WizardField.tsx:
/// rotulo pequeno acima, caixa com borda clara e mensagem de erro abaixo.
class WizardField extends StatelessWidget {
  static const Color borda = Color(0xFFE4E4E7);
  static const Color rotuloCor = Color(0xFF09090B);

  final String rotulo;
  final String? dica;
  final TextEditingController controlador;
  final bool opcional;
  final bool senha;
  final TextInputType? tipoTeclado;
  final String? Function(String?)? validador;

  const WizardField({
    super.key,
    required this.rotulo,
    required this.controlador,
    this.dica,
    this.opcional = false,
    this.senha = false,
    this.tipoTeclado,
    this.validador,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              rotulo,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: rotuloCor,
              ),
            ),
            if (opcional) ...[
              const SizedBox(width: 6),
              const Text(
                '(opcional)',
                style: TextStyle(fontSize: 12, color: Color(0xFF71717A)),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controlador,
          obscureText: senha,
          keyboardType: tipoTeclado,
          validator: validador,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: dica,
            hintStyle:
                const TextStyle(fontSize: 14, color: Color(0xFFA1A1AA)),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: _borda(borda),
            enabledBorder: _borda(borda),
            focusedBorder: _borda(WizardStepperCores.azul),
            errorBorder: _borda(const Color(0xFFDC2626)),
            focusedErrorBorder: _borda(const Color(0xFFDC2626)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  OutlineInputBorder _borda(Color cor) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: cor),
      );
}

/// Cores compartilhadas do fluxo de cadastro.
class WizardStepperCores {
  WizardStepperCores._();

  static const Color azul = Color(0xFF0D3B6E);
  static const Color fundo = Color(0xFFEEF2F7);
  static const Color rodapeCard = Color(0xFFFAFAFA);
  static const Color borda = Color(0xFFE4E4E7);
  static const Color textoSuave = Color(0xFF71717A);
}
