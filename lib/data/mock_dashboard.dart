// Indicadores do painel administrativo, espelhando os cards do dashboard do
// web-nutriz (pages/private/dashboard): litros por mes, doacoes ativas por
// etapa, satisfacao, recorrencia, tempo de resposta e doacoes com erro.

class LeitePorMes {
  final String mes;
  final int litros;

  const LeitePorMes({required this.mes, required this.litros});
}

class EtapaContagem {
  final String etapa;
  final int total;

  const EtapaContagem({required this.etapa, required this.total});
}

class AvaliacaoContagem {
  final int estrelas;
  final int total;

  const AvaliacaoContagem({required this.estrelas, required this.total});
}

/// Opcoes do filtro de periodo (PERIOD_PRESET_OPTIONS do site).
const List<String> periodosDashboard = [
  'Este mes',
  'Ultimos 3 meses',
  'Ultimos 6 meses',
  'Este ano',
];

const List<LeitePorMes> leitePorMesMock = [
  LeitePorMes(mes: 'MAR', litros: 82),
  LeitePorMes(mes: 'ABR', litros: 97),
  LeitePorMes(mes: 'MAI', litros: 110),
  LeitePorMes(mes: 'JUN', litros: 104),
  LeitePorMes(mes: 'JUL', litros: 121),
  LeitePorMes(mes: 'AGO', litros: 128),
];

const List<EtapaContagem> doacoesPorEtapaMock = [
  EtapaContagem(etapa: 'Cadastro e Triagem', total: 9),
  EtapaContagem(etapa: 'Exames', total: 6),
  EtapaContagem(etapa: 'Envio do Kit de Ordenha', total: 5),
  EtapaContagem(etapa: 'Coleta', total: 8),
  EtapaContagem(etapa: 'Analise Laboratorial', total: 5),
  EtapaContagem(etapa: 'Processamento e Distribuicao', total: 4),
];

const List<AvaliacaoContagem> avaliacoesMock = [
  AvaliacaoContagem(estrelas: 5, total: 148),
  AvaliacaoContagem(estrelas: 4, total: 52),
  AvaliacaoContagem(estrelas: 3, total: 14),
  AvaliacaoContagem(estrelas: 2, total: 5),
  AvaliacaoContagem(estrelas: 1, total: 3),
];

/// Taxa de doadoras que doaram mais de uma vez.
const double taxaRecorrenciaMock = 62;

/// Horas medias entre a triagem e a primeira coleta agendada.
const double tempoMedioRespostaHorasMock = 33.6;

const int doacoesComErroMock = 3;
