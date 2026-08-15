/// Um indicador do painel do administrador.
class MetricaDashboard {
  final String titulo;
  final String valor;
  final String subtitulo;

  const MetricaDashboard({
    required this.titulo,
    required this.valor,
    required this.subtitulo,
  });
}

/// Contagem de doacoes em uma etapa (para o grafico simples do dashboard).
class EtapaContagem {
  final String etapa;
  final int total;

  const EtapaContagem({required this.etapa, required this.total});
}

/// Indicadores do painel (mock), com os mesmos titulos do dashboard real.
const List<MetricaDashboard> metricasMock = [
  MetricaDashboard(
    titulo: 'Litros Captados no Mes',
    valor: '128 L',
    subtitulo: 'Volume total de leite coletado, todas as doadoras',
  ),
  MetricaDashboard(
    titulo: 'Doacoes Ativas',
    valor: '37',
    subtitulo: 'Doacoes em andamento no periodo',
  ),
  MetricaDashboard(
    titulo: 'Nivel de Satisfacao',
    valor: '4.8 / 5',
    subtitulo: 'Media das avaliacoes das doadoras',
  ),
  MetricaDashboard(
    titulo: 'Taxa de Recorrencia',
    valor: '62%',
    subtitulo: 'Doadoras que ajudaram mais de uma vez',
  ),
  MetricaDashboard(
    titulo: 'Tempo Medio de Resposta',
    valor: '1.4 dias',
    subtitulo: 'Triagem ate a 1a coleta agendada',
  ),
  MetricaDashboard(
    titulo: 'Doacoes com Erro',
    valor: '3',
    subtitulo: 'Ocorrencias no periodo selecionado',
  ),
];

/// Distribuicao das doacoes ativas por etapa (mock).
const List<EtapaContagem> doacoesPorEtapaMock = [
  EtapaContagem(etapa: 'Cadastro e Triagem', total: 9),
  EtapaContagem(etapa: 'Exames', total: 6),
  EtapaContagem(etapa: 'Envio do Kit de Ordenha', total: 5),
  EtapaContagem(etapa: 'Coleta', total: 8),
  EtapaContagem(etapa: 'Analise Laboratorial', total: 5),
  EtapaContagem(etapa: 'Processamento e Distribuicao', total: 4),
];
