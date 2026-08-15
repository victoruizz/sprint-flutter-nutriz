import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Conteudo da landing page publica, espelhando
/// web-nutriz/src/pages/public/landing-page/constants.ts e mock.ts.

class PassoLanding {
  final String numero;
  final String titulo;
  final String descricao;
  final Color cor;
  final IconData icone;

  const PassoLanding({
    required this.numero,
    required this.titulo,
    required this.descricao,
    required this.cor,
    required this.icone,
  });
}

const List<PassoLanding> passosLanding = [
  PassoLanding(
    numero: '1',
    titulo: 'Cadastre-se e faca triagem',
    descricao:
        'Clique em Quero doar e nossa equipe entrara em contato via WhatsApp '
        'para a triagem inicial.',
    cor: AppColors.navy,
    icone: Icons.assignment_outlined,
  ),
  PassoLanding(
    numero: '2',
    titulo: 'Realize os exames',
    descricao:
        'Exames simples de saude para garantir a seguranca do leite para os '
        'bebes receptores.',
    cor: AppColors.teal,
    icone: Icons.biotech_outlined,
  ),
  PassoLanding(
    numero: '3',
    titulo: 'Doe e acompanhe',
    descricao:
        'Coletamos o leite e voce acompanha cada etapa pela plataforma em '
        'tempo real.',
    cor: AppColors.pink,
    icone: Icons.volunteer_activism_outlined,
  ),
];

class MetricaLanding {
  final IconData icone;
  final Color corIcone;
  final Color fundoIcone;
  final String valor;
  final String rotulo;
  final String subRotulo;

  const MetricaLanding({
    required this.icone,
    required this.corIcone,
    required this.fundoIcone,
    required this.valor,
    required this.rotulo,
    required this.subRotulo,
  });
}

const List<MetricaLanding> metricasLanding = [
  MetricaLanding(
    icone: Icons.groups_outlined,
    corIcone: AppColors.navy,
    fundoIcone: Color(0xFFE6F1FB),
    valor: '4.200+',
    rotulo: 'Doadoras ativas',
    subRotulo: 'Em todo o Brasil',
  ),
  MetricaLanding(
    icone: Icons.water_drop_outlined,
    corIcone: AppColors.teal,
    fundoIcone: Color(0xFFE1F5EE),
    valor: '12 mil L',
    rotulo: 'Leite coletado',
    subRotulo: 'Doados aos bancos de leite',
  ),
  MetricaLanding(
    icone: Icons.favorite,
    corIcone: AppColors.pink,
    fundoIcone: Color(0xFFFBEAF0),
    valor: '98%',
    rotulo: 'Satisfacao',
    subRotulo: 'Das nossas doadoras',
  ),
];

class DepoimentoLanding {
  final String nome;
  final String desde;
  final String texto;

  const DepoimentoLanding({
    required this.nome,
    required this.desde,
    required this.texto,
  });
}

const List<DepoimentoLanding> depoimentosLanding = [
  DepoimentoLanding(
    nome: 'Ana Paula S.',
    desde: 'Doadora ha 8 meses',
    texto:
        'Achei que seria complicado, mas a equipe do Nutriz me guiou em cada '
        'etapa. Saber que meu leite alimentou um bebe na UTI me encheu de '
        'proposito.',
  ),
  DepoimentoLanding(
    nome: 'Mariana L.',
    desde: 'Doadora ha 4 meses',
    texto:
        'A EVA me respondeu as 3h da manha quando eu tinha duvidas sobre '
        'armazenamento. Isso fez toda a diferenca para eu continuar doando.',
  ),
];

/// Secoes navegaveis do menu da landing (NAV_LINKS do front real).
class SecaoLanding {
  final String rotulo;
  final IconData icone;

  const SecaoLanding({required this.rotulo, required this.icone});
}

const List<SecaoLanding> secoesLanding = [
  SecaoLanding(rotulo: 'Como funciona', icone: Icons.help_outline),
  SecaoLanding(rotulo: 'Pontos de coleta', icone: Icons.place_outlined),
  SecaoLanding(rotulo: 'A EVA', icone: Icons.chat_bubble_outline),
  SecaoLanding(rotulo: 'Artigos', icone: Icons.menu_book_outlined),
  SecaoLanding(rotulo: 'Depoimentos', icone: Icons.format_quote),
];

/// Gradiente pastel do bloco da EVA (EVA_LANDING_BG).
const LinearGradient evaLandingGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFBDCC4), Color(0xFFF6BDD2), Color(0xFFCCB4E8)],
  stops: [0.0, 0.48, 1.0],
);

/// Chips de sugestao da EVA (EVA_SUGGESTIONS do nutriz-ia-service).
const List<String> sugestoesEva = [
  'Posso doar leite?',
  'Como fazer a ordenha?',
  'Como armazenar o leite?',
  'Como agendar a coleta?',
];

class ColunaRodape {
  final String titulo;
  final List<String> links;

  const ColunaRodape({required this.titulo, required this.links});
}

const List<ColunaRodape> colunasRodape = [
  ColunaRodape(
    titulo: 'Plataforma',
    links: ['Como funciona', 'Pontos de coleta', 'A EVA'],
  ),
  ColunaRodape(
    titulo: 'Conteudo',
    links: ['Artigos', 'Depoimentos', 'Entrar'],
  ),
];

const List<Color> avatarsCta = [
  AppColors.pink,
  AppColors.cyanDeep,
  AppColors.blue,
  AppColors.cyan,
];
