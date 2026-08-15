const String evaSaudacao =
    'Oi! Eu sou a EVA. Estou aqui a qualquer hora para falar sobre doacao de '
    'leite, ordenha e amamentacao. Como posso te ajudar?';

const String evaAvisoMedico =
    'A EVA nao substitui avaliacao medica. Em emergencia, ligue para o SAMU '
    '192; para casos clinicos, procure a equipe Lactare.';

const List<String> evaSugestoes = [
  'Posso doar leite?',
  'Como fazer a ordenha?',
  'Por quanto tempo posso guardar o leite?',
  'Onde tem ponto de coleta?',
];

class _Regra {
  final List<String> chaves;
  final String resposta;
  const _Regra(this.chaves, this.resposta);
}

const List<_Regra> _regras = [
  _Regra(
    ['doar', 'doacao', 'apta', 'criterio', 'quero doar'],
    'Que bom que voce quer doar! Podem doar nutrizes saudaveis, com leite '
    'excedente. A aptidao e confirmada na triagem, a partir dos exames do '
    'pre-natal. Quer que eu te mostre os pontos de coleta?',
  ),
  _Regra(
    ['ordenha', 'ordenhar', 'tirar leite', 'como faco'],
    'Higienize bem as maos e os frascos, escolha um lugar tranquilo e ordenhe '
    'para um frasco esterilizado. Deixe cerca de 1 cm livre no frasco, pois '
    'o leite expande ao congelar.',
  ),
  _Regra(
    [
      'guardar',
      'armazenar',
      'congelar',
      'freezer',
      'validade',
      'quanto tempo',
      'prazo'
    ],
    'Congele o leite logo apos a ordenha (no freezer, nunca na porta da '
    'geladeira) e anote a data e a hora da primeira coleta na tampa. O leite '
    'cru congelado tem validade de ate 15 dias.',
  ),
  _Regra(
    ['ponto', 'coleta', 'onde', 'banco de leite', 'perto'],
    'Voce encontra os pontos de coleta na aba "Pontos". Varios oferecem coleta '
    'domiciliar, entao a gente pode buscar o leite na sua casa. E so escolher '
    'o mais proximo.',
  ),
  _Regra(
    ['exame', 'sorologia', 'triagem'],
    'Em geral os exames do pre-natal ja bastam. A equipe do banco de leite '
    'avalia o seu caso na triagem e te orienta se precisar de algo a mais.',
  ),
  _Regra(
    ['medicamento', 'remedio', 'vitamina', 'cha'],
    'Depende do medicamento. Informe tudo o que voce usa - inclusive vitaminas '
    'e chas - para a equipe Lactare avaliar na triagem se voce pode doar.',
  ),
  _Regra(
    ['leite maduro', 'colostro', 'fase', 'transicao'],
    'O leite muda de fase: colostro nos primeiros dias, transicao e depois o '
    'leite maduro. A partir dos primeiros meses ele fica na fase ideal para '
    'doacao. Cada fase e valiosa para o bebe que recebe.',
  ),
];

String respostaEva(String pergunta) {
  final texto = pergunta.toLowerCase();
  for (final regra in _regras) {
    for (final chave in regra.chaves) {
      if (texto.contains(chave)) return regra.resposta;
    }
  }
  return 'Posso te ajudar com doacao de leite, ordenha, armazenamento e pontos '
      'de coleta. Se for uma duvida clinica ou uma emergencia, o melhor caminho '
      'e falar com a equipe Lactare. Sobre o que voce quer saber?';
}
