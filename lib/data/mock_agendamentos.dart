import '../models/agendamento.dart';

/// Agendamentos atendidos pelo enfermeiro (mock).
final List<Agendamento> agendamentosMock = [
  Agendamento(
    doadora: 'Mariana Alves',
    endereco: 'Vila Mariana, Sao Paulo',
    etapa: 'Coleta',
    dataHora: DateTime(2026, 8, 14, 10, 0),
    status: StatusAgendamento.aguardando,
  ),
  Agendamento(
    doadora: 'Beatriz Ramos',
    endereco: 'Centro, Guarulhos',
    etapa: 'Envio do Kit de Ordenha',
    dataHora: DateTime(2026, 8, 14, 14, 30),
    status: StatusAgendamento.aguardando,
  ),
  Agendamento(
    doadora: 'Juliana Prado',
    endereco: 'Km 18, Osasco',
    etapa: 'Coleta',
    dataHora: DateTime(2026, 8, 13, 9, 0),
    status: StatusAgendamento.realizada,
  ),
  Agendamento(
    doadora: 'Fernanda Lima',
    endereco: 'Pinheiros, Sao Paulo',
    etapa: 'Coleta',
    dataHora: DateTime(2026, 8, 12, 16, 0),
    status: StatusAgendamento.naoRealizada,
  ),
];
