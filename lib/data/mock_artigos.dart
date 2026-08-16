import 'package:flutter/material.dart';

import '../models/artigo.dart';

/// Conteudo educativo do Nutriz, com os mesmos artigos, autores e capas do
/// web-nutriz (src/pages/public/articles/data.ts). Textos condensados para o
/// formato mobile, mantendo a orientacao rBLH/Fiocruz do produto real.

const Color _corAmamentacao = Color(0xFF14B8A6);
const Color _fundoAmamentacao = Color(0xFFCCFBF1);
const Color _corNutricao = Color(0xFF65A30D);
const Color _fundoNutricao = Color(0xFFECFCCB);
const Color _corAcolhimento = Color(0xFFE0457A);
const Color _fundoAcolhimento = Color(0xFFFDF1F5);
const Color _corCuidados = Color(0xFF3B82F6);
const Color _fundoCuidados = Color(0xFFDBEAFE);

const String _bioMariana =
    'Pediatra e consultora em aleitamento materno, colaboradora da Rede '
    'Brasileira de Bancos de Leite Humano ha 12 anos.';
const String _bioEquipe =
    'Equipe tecnica do banco de leite humano da Lactare, responsavel pela '
    'triagem, coleta e orientacao das nutrizes doadoras.';

const List<Artigo> artigosMock = [
  Artigo(
    titulo: 'Como armazenar e transportar seu leite com seguranca',
    categoria: 'Amamentacao',
    autor: 'Dra. Mariana Costa',
    resumo:
        'Frasco certo, prazos de congelamento e transporte ate o banco de '
        'leite - o passo a passo completo.',
    minutosLeitura: 4,
    imagem: 'assets/artigos/armazenamento-leite.jpg',
    corCategoria: _corAmamentacao,
    fundoCategoria: _fundoAmamentacao,
    data: '12 de julho, 2026',
    autorBio: _bioMariana,
    aprendizados: [
      'Qual frasco usar e como esterilizar',
      'Prazos de congelamento do leite cru',
      'Como completar o frasco em coletas diferentes',
      'Transporte seguro ate o banco de leite',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'O frasco ideal',
        texto:
            'Use sempre frascos de vidro com tampa plastica rosqueavel. Eles '
            'devem ser esterilizados antes do uso: ferva o vidro e a tampa por '
            '15 minutos e deixe secar naturalmente sobre um pano limpo. '
            'Identifique cada frasco com a data e a hora da primeira coleta.',
      ),
      SecaoArtigo(
        subtitulo: 'Congelamento e prazos',
        texto:
            'Apos a coleta, leve o frasco imediatamente ao freezer. O leite cru '
            'congelado pode ser armazenado por ate 15 dias. Voce pode completar '
            'o mesmo frasco em coletas diferentes do mesmo dia, desde que o '
            'leite novo seja resfriado antes. Nunca armazene o leite na porta '
            'da geladeira ou do freezer - a variacao de temperatura compromete '
            'a qualidade.',
      ),
      SecaoArtigo(
        subtitulo: 'O transporte ate o banco de leite',
        texto:
            'O transporte deve ser feito em caixa termica com gelo. Muitos '
            'bancos de leite oferecem busca domiciliar - consulte o posto de '
            'coleta mais proximo. O importante e que o leite nao descongele no '
            'caminho.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Alimentacao da nutriz: o que comer durante a doacao',
    categoria: 'Nutricao',
    autor: 'Dra. Mariana Costa',
    resumo:
        'Nao existe dieta especial para doar. O que importa e uma alimentacao '
        'variada e boa hidratacao.',
    minutosLeitura: 5,
    imagem: 'assets/artigos/alimentacao-nutriz.jpg',
    corCategoria: _corNutricao,
    fundoCategoria: _fundoNutricao,
    data: '28 de junho, 2026',
    autorBio: _bioMariana,
    aprendizados: [
      'Por que nao existe dieta especial para doar',
      'Como montar refeicoes variadas no dia a dia',
      'Quanto de agua beber durante a lactacao',
      'Quando uma restricao alimentar faz sentido',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'Comida de verdade, sem dieta restritiva',
        texto:
            'A lactacao aumenta a necessidade de energia, mas isso nao exige '
            'cardapio especial. Priorize refeicoes variadas com frutas, '
            'legumes, cereais integrais, feijoes e fontes de proteina ao longo '
            'do dia.',
      ),
      SecaoArtigo(
        subtitulo: 'Hidratacao',
        texto:
            'Beba agua sempre que sentir sede e mantenha um copo por perto '
            'durante as mamadas e a ordenha. Nao e preciso forcar volumes '
            'exagerados.',
      ),
      SecaoArtigo(
        subtitulo: 'Duvidas sobre restricoes',
        texto:
            'Restricoes alimentares so fazem sentido quando ha indicacao '
            'individual. Converse com a equipe Lactare ou com quem acompanha '
            'o seu pre-natal antes de cortar grupos de alimentos.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Nao pode doar? Veja como voce ainda pode ajudar',
    categoria: 'Acolhimento',
    autor: 'Equipe Lactare',
    resumo:
        'Existem varias formas de apoiar a rede de bancos de leite mesmo sem '
        'doar leite.',
    minutosLeitura: 3,
    imagem: 'assets/artigos/apoio-sem-doar.jpg',
    corCategoria: _corAcolhimento,
    fundoCategoria: _fundoAcolhimento,
    data: '15 de junho, 2026',
    autorBio: _bioEquipe,
    aprendizados: [
      'Como doar frascos de vidro esterilizados',
      'O peso da divulgacao entre outras nutrizes',
      'Formas de apoiar quem esta doando',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'Doar frascos e divulgar',
        texto:
            'Frascos de vidro esterilizados sao sempre necessarios nos bancos '
            'de leite. Divulgar a doacao entre amigas e nas redes tambem '
            'alcanca novas doadoras.',
      ),
      SecaoArtigo(
        subtitulo: 'Apoiar quem doa',
        texto:
            'Acolher uma nutriz que esta doando - ajudando com a rotina, com o '
            'bebe ou apenas ouvindo - faz diferenca real na continuidade da '
            'doacao.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Higiene na ordenha: passo a passo da rBLH',
    categoria: 'Cuidados',
    autor: 'Equipe Lactare',
    resumo:
        'O protocolo de higiene que garante a seguranca do leite doado, do '
        'ambiente ao frasco.',
    minutosLeitura: 6,
    imagem: 'assets/artigos/higiene-ordenha.jpg',
    corCategoria: _corCuidados,
    fundoCategoria: _fundoCuidados,
    data: '02 de junho, 2026',
    autorBio: _bioEquipe,
    aprendizados: [
      'Como preparar o ambiente e as maos',
      'Uso de touca e mascara na ordenha',
      'Por que desprezar os primeiros jatos',
      'Cuidados com o frasco depois da coleta',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'Antes de comecar',
        texto:
            'Escolha um local limpo e tranquilo. Prenda os cabelos, use touca '
            'ou lenco e mascara, retire aneis e pulseiras e lave bem as maos e '
            'os antebracos com agua e sabao.',
      ),
      SecaoArtigo(
        subtitulo: 'Durante a ordenha',
        texto:
            'Despreze os primeiros jatos de leite. Evite falar, espirrar ou '
            'tossir sobre o frasco. Massageie a mama em movimentos circulares '
            'antes de iniciar para facilitar a saida do leite.',
      ),
      SecaoArtigo(
        subtitulo: 'Depois',
        texto:
            'Feche bem o frasco, identifique com data e hora e leve '
            'imediatamente ao freezer. Lave o material utilizado com agua e '
            'sabao e deixe secar naturalmente.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Excesso de leite: transforme o que sobra em doacao',
    categoria: 'Amamentacao',
    autor: 'Dra. Mariana Costa',
    resumo:
        'Se voce produz mais do que o seu bebe consome, esse leite pode salvar '
        'um prematuro.',
    minutosLeitura: 4,
    imagem: 'assets/artigos/excesso-de-leite.jpg',
    corCategoria: _corAmamentacao,
    fundoCategoria: _fundoAmamentacao,
    data: '20 de maio, 2026',
    autorBio: _bioMariana,
    aprendizados: [
      'Como a producao se ajusta a demanda',
      'Por que doar nao tira o leite do seu bebe',
      'Quando procurar avaliacao profissional',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'Producao por demanda',
        texto:
            'A producao de leite se ajusta a demanda. Retirar o excedente com '
            'regularidade nao tira o leite do seu bebe - o corpo repoe conforme '
            'o estimulo.',
      ),
      SecaoArtigo(
        subtitulo: 'Alivio e conforto',
        texto:
            'Ordenhar o excesso tambem ajuda a aliviar o ingurgitamento '
            'mamario. Se houver dor persistente, vermelhidao ou febre, procure '
            'avaliacao profissional.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Quem pode doar? Criterios de saude e triagem',
    categoria: 'Cuidados',
    autor: 'Equipe Lactare',
    resumo:
        'Os criterios usados na triagem de doadoras e quais exames sao '
        'solicitados.',
    minutosLeitura: 5,
    imagem: 'assets/artigos/triagem-doacao.jpg',
    corCategoria: _corCuidados,
    fundoCategoria: _fundoCuidados,
    data: '08 de maio, 2026',
    autorBio: _bioEquipe,
    aprendizados: [
      'Quais criterios de saude sao avaliados',
      'Que exames costumam ser solicitados',
      'Como funciona a triagem inicial',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'Criterios gerais',
        texto:
            'Podem doar nutrizes saudaveis, que amamentam e tem leite '
            'excedente, sem uso de medicamentos incompativeis com a doacao e '
            'com exames de pre-natal sem alteracoes.',
      ),
      SecaoArtigo(
        subtitulo: 'Exames',
        texto:
            'Na maioria dos casos os exames do pre-natal ja atendem a triagem. '
            'Quando necessario, a equipe Lactare orienta sobre exames '
            'complementares - sem custo para a doadora.',
      ),
      SecaoArtigo(
        subtitulo: 'Em caso de duvida',
        texto:
            'A avaliacao e sempre individual. Fale com a equipe Lactare para '
            'confirmar se o seu caso se enquadra.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Diario de uma doadora: a historia da Juliana e do Theo',
    categoria: 'Acolhimento',
    autor: 'Equipe Lactare',
    resumo:
        'O relato de uma doadora sobre comecar, manter a rotina e o que muda '
        'no caminho.',
    minutosLeitura: 6,
    imagem: 'assets/artigos/diario-doadora.jpg',
    corCategoria: _corAcolhimento,
    fundoCategoria: _fundoAcolhimento,
    data: '25 de abril, 2026',
    autorBio: _bioEquipe,
    aprendizados: [
      'Como foi o primeiro contato com o banco de leite',
      'A rotina de ordenha no dia a dia',
      'O que muda com a coleta domiciliar',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'O comeco',
        texto:
            'Juliana descobriu a doacao no proprio banco de leite onde o Theo '
            'nasceu. O primeiro contato foi por WhatsApp e a triagem aconteceu '
            'na mesma semana.',
      ),
      SecaoArtigo(
        subtitulo: 'A rotina',
        texto:
            'Ordenhar virou parte do dia - sempre no mesmo horario, com o kit '
            'ja separado. A coleta domiciliar tirou o peso do deslocamento.',
      ),
    ],
  ),
  Artigo(
    titulo: 'Ferro, calcio e vitamina D: os nutrientes-chave da lactacao',
    categoria: 'Nutricao',
    autor: 'Dra. Mariana Costa',
    resumo:
        'Como manter os nutrientes essenciais em dia durante o periodo de '
        'amamentacao.',
    minutosLeitura: 5,
    imagem: 'assets/artigos/nutrientes-lactacao.jpg',
    corCategoria: _corNutricao,
    fundoCategoria: _fundoNutricao,
    data: '10 de abril, 2026',
    autorBio: _bioMariana,
    aprendizados: [
      'Boas fontes de ferro no dia a dia',
      'Como favorecer a absorcao do ferro',
      'Calcio e vitamina D durante a lactacao',
      'Quando a suplementacao e indicada',
    ],
    secoes: [
      SecaoArtigo(
        subtitulo: 'Ferro',
        texto:
            'Carnes, feijoes e vegetais verde-escuros sao boas fontes. '
            'Combinar com fontes de vitamina C, como frutas citricas, favorece '
            'a absorcao.',
      ),
      SecaoArtigo(
        subtitulo: 'Calcio e vitamina D',
        texto:
            'Leite e derivados, vegetais verde-escuros e exposicao solar '
            'moderada ajudam a manter esses nutrientes. Suplementacao so com '
            'indicacao de quem acompanha o seu caso.',
      ),
    ],
  ),
];
