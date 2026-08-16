import '../models/agendamento.dart';

/// Agendamentos atribuidos a enfermagem. Cada um traz a orientacao da etapa e,
/// quando ja encerrado, o relatorio registrado na visita.

const String _orientacaoColeta =
    'Confirme a identificacao dos frascos, verifique se o leite se manteve '
    'congelado e registre o volume recolhido. Transporte em caixa termica com '
    'gelo ate o banco de leite.';
const String _orientacaoKit =
    'Entregue o kit de ordenha esterilizado, explique o passo a passo da '
    'higiene e confirme o endereco para a proxima coleta.';

final List<Agendamento> agendamentosMock = [
  Agendamento(
    id: 'AGD-2026-041',
    doadora: 'Mariana Alves',
    endereco: 'Vila Mariana, Sao Paulo',
    etapa: 'Coleta',
    dataHora: DateTime(2026, 8, 14, 10, 0),
    status: StatusAgendamento.aguardando,
    descricao: _orientacaoColeta,
  ),
  Agendamento(
    id: 'AGD-2026-042',
    doadora: 'Beatriz Ramos',
    endereco: 'Centro, Guarulhos',
    etapa: 'Envio do Kit de Ordenha',
    dataHora: DateTime(2026, 8, 14, 14, 30),
    status: StatusAgendamento.aguardando,
    descricao: _orientacaoKit,
  ),
  Agendamento(
    id: 'AGD-2026-038',
    doadora: 'Juliana Prado',
    endereco: 'Km 18, Osasco',
    etapa: 'Coleta',
    dataHora: DateTime(2026, 8, 13, 9, 0),
    status: StatusAgendamento.realizada,
    descricao: _orientacaoColeta,
    relatorios: [
      RelatorioAgendamento(
        etapa: 'Coleta',
        data: DateTime(2026, 8, 13, 9, 40),
        texto:
            'Coleta realizada sem intercorrencias. Foram recolhidos 4 frascos, '
            'todos congelados e identificados com data e hora. Doadora '
            'orientada sobre a proxima ordenha.',
        resultado: StatusAgendamento.realizada,
      ),
    ],
  ),
  Agendamento(
    id: 'AGD-2026-035',
    doadora: 'Fernanda Lima',
    endereco: 'Pinheiros, Sao Paulo',
    etapa: 'Coleta',
    dataHora: DateTime(2026, 8, 12, 16, 0),
    status: StatusAgendamento.naoRealizada,
    descricao: _orientacaoColeta,
    relatorios: [
      RelatorioAgendamento(
        etapa: 'Coleta',
        data: DateTime(2026, 8, 12, 16, 20),
        texto:
            'Nao foi possivel realizar a coleta: a doadora nao estava no '
            'endereco no horario combinado. Contato feito por telefone para '
            'reagendar a visita.',
        resultado: StatusAgendamento.naoRealizada,
      ),
    ],
  ),
];
