import '../models/doacao.dart';
import '../models/etapa_doacao.dart';

const String _dTriagem =
    'Cadastro realizado e triagem inicial concluida pela equipe Lactare.';
const String _dExames =
    'Exames do pre-natal avaliados pelo banco de leite. Voce esta apta a doar.';
const String _dKit =
    'Kit de ordenha esterilizado enviado para o seu endereco.';
const String _dColeta =
    'Coleta domiciliar do leite ordenhado e congelado. Um agente passa na sua casa.';
const String _dAnalise =
    'Analise de qualidade e pasteurizacao do leite no banco de leite.';
const String _dDistribuicao =
    'Leite pasteurizado distribuido a bebes prematuros e internados.';

/// Doacoes acompanhadas pela nutriz (mock). A primeira esta em andamento; a
/// segunda concluida; a terceira no inicio do fluxo.
final List<Doacao> doacoesMock = [
  Doacao(
    id: 'DOA-2026-014',
    titulo: 'Doacao de agosto',
    dataInicio: DateTime(2026, 8, 2),
    etapas: [
      EtapaDoacao(
        titulo: 'Cadastro e Triagem',
        descricao: _dTriagem,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 8, 2),
      ),
      EtapaDoacao(
        titulo: 'Exames',
        descricao: _dExames,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 8, 5),
      ),
      EtapaDoacao(
        titulo: 'Envio do Kit de Ordenha',
        descricao: _dKit,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 8, 8),
      ),
      EtapaDoacao(
        titulo: 'Coleta',
        descricao: _dColeta,
        status: StatusEtapa.emAndamento,
        data: DateTime(2026, 8, 14),
      ),
      EtapaDoacao(
        titulo: 'Analise Laboratorial',
        descricao: _dAnalise,
        status: StatusEtapa.pendente,
      ),
      EtapaDoacao(
        titulo: 'Processamento e Distribuicao',
        descricao: _dDistribuicao,
        status: StatusEtapa.pendente,
      ),
    ],
  ),
  Doacao(
    id: 'DOA-2026-009',
    titulo: 'Doacao de julho',
    dataInicio: DateTime(2026, 7, 1),
    etapas: [
      EtapaDoacao(
        titulo: 'Cadastro e Triagem',
        descricao: _dTriagem,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 7, 1),
      ),
      EtapaDoacao(
        titulo: 'Exames',
        descricao: _dExames,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 7, 4),
      ),
      EtapaDoacao(
        titulo: 'Envio do Kit de Ordenha',
        descricao: _dKit,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 7, 7),
      ),
      EtapaDoacao(
        titulo: 'Coleta',
        descricao: _dColeta,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 7, 12),
      ),
      EtapaDoacao(
        titulo: 'Analise Laboratorial',
        descricao: _dAnalise,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 7, 15),
      ),
      EtapaDoacao(
        titulo: 'Processamento e Distribuicao',
        descricao: _dDistribuicao,
        status: StatusEtapa.concluida,
        data: DateTime(2026, 7, 18),
      ),
    ],
  ),
  Doacao(
    id: 'DOA-2026-018',
    titulo: 'Nova doacao',
    dataInicio: DateTime(2026, 8, 13),
    etapas: [
      EtapaDoacao(
        titulo: 'Cadastro e Triagem',
        descricao: _dTriagem,
        status: StatusEtapa.emAndamento,
        data: DateTime(2026, 8, 13),
      ),
      EtapaDoacao(
        titulo: 'Exames',
        descricao: _dExames,
        status: StatusEtapa.pendente,
      ),
      EtapaDoacao(
        titulo: 'Envio do Kit de Ordenha',
        descricao: _dKit,
        status: StatusEtapa.pendente,
      ),
      EtapaDoacao(
        titulo: 'Coleta',
        descricao: _dColeta,
        status: StatusEtapa.pendente,
      ),
      EtapaDoacao(
        titulo: 'Analise Laboratorial',
        descricao: _dAnalise,
        status: StatusEtapa.pendente,
      ),
      EtapaDoacao(
        titulo: 'Processamento e Distribuicao',
        descricao: _dDistribuicao,
        status: StatusEtapa.pendente,
      ),
    ],
  ),
];
