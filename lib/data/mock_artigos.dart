import '../models/artigo.dart';

/// Artigos do conteudo educativo (mock), com copy real do produto Nutriz
/// (dicas e perguntas frequentes do content-hub).
const List<Artigo> artigosMock = [
  Artigo(
    titulo: 'Doar leite diminui o leite do meu bebe?',
    categoria: 'Amamentacao',
    autor: 'Equipe Lactare',
    resumo:
        'A producao de leite funciona por demanda. Entenda por que doar nao prejudica a amamentacao do seu bebe.',
    minutosLeitura: 3,
    secoes: [
      SecaoArtigo(
        subtitulo: 'Producao por demanda',
        texto:
            'Nao. A producao funciona por demanda: o que e retirado a mais tende a estimular ainda mais a producao. Seu corpo repoe o que foi ordenhado.',
      ),
      SecaoArtigo(
        subtitulo: 'Fique atenta',
        texto:
            'Se notar qualquer mudanca na amamentacao, converse com o banco de leite. A equipe acompanha voce em todo o processo.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Como armazenar o leite ordenhado',
    categoria: 'Ordenha',
    autor: 'Equipe Lactare',
    resumo:
        'Congelamento, identificacao do frasco e o prazo de validade do leite congelado.',
    minutosLeitura: 4,
    secoes: [
      SecaoArtigo(
        subtitulo: 'Congele imediatamente',
        texto:
            'O frasco vai ao freezer logo apos a coleta - nunca na porta da geladeira, onde a temperatura oscila.',
      ),
      SecaoArtigo(
        subtitulo: 'Identifique cada frasco',
        texto:
            'Escreva a data e a hora da primeira coleta na tampa. Isso evita perder o prazo de 15 dias do leite congelado cru.',
      ),
      SecaoArtigo(
        subtitulo: 'Deixe espaco no frasco',
        texto:
            'Nao encha ate a borda: deixe cerca de 1 cm livre, porque o leite expande ao congelar e pode quebrar o frasco.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Preciso fazer exames para doar?',
    categoria: 'Doacao',
    autor: 'Equipe Lactare',
    resumo:
        'O que a triagem avalia e por que os exames do pre-natal costumam bastar.',
    minutosLeitura: 2,
    secoes: [
      SecaoArtigo(
        subtitulo: 'Exames do pre-natal',
        texto:
            'Alguns exames ja feitos no pre-natal costumam ser suficientes. A equipe do banco de leite avalia caso a caso durante a triagem.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Como o leite chega ate os bebes',
    categoria: 'Processo',
    autor: 'Equipe Lactare',
    resumo:
        'Da coleta a distribuicao: pasteurizacao, testes de qualidade e entrega a quem precisa.',
    minutosLeitura: 3,
    secoes: [
      SecaoArtigo(
        subtitulo: 'Pasteurizacao e qualidade',
        texto:
            'Depois de coletado, o leite passa por pasteurizacao e testes de qualidade no banco de leite.',
      ),
      SecaoArtigo(
        subtitulo: 'Distribuicao',
        texto:
            'So entao ele e distribuido a bebes prematuros ou internados que precisam dele para se desenvolver.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Posso doar tomando medicamentos?',
    categoria: 'Saude',
    autor: 'Equipe Lactare',
    resumo:
        'Por que voce deve informar tudo o que usa - e quem decide se libera.',
    minutosLeitura: 2,
    secoes: [
      SecaoArtigo(
        subtitulo: 'Depende do medicamento',
        texto:
            'A equipe do banco de leite avalia cada caso na triagem. Por isso e importante informar tudo o que voce esta usando, inclusive vitaminas e chas.',
      ),
    ],
  ),
];
