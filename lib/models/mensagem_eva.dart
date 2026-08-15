/// Uma mensagem na conversa com a EVA (espelha message/conversation).
class MensagemEva {
  final String texto;

  /// true = mensagem da EVA; false = mensagem da nutriz.
  final bool daEva;

  const MensagemEva({required this.texto, required this.daEva});
}
