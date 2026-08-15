# Nutriz — App Flutter

Aplicativo Android em **Flutter**, navegável e **100% mockado** (sem API, sem
backend, sem banco de dados), que representa o produto **Nutriz** — plataforma de
doação de leite humano em parceria com a Lactare/Eurofarma.

- **Equipe:** <!-- PREENCHER: nome da equipe -->
- **Integrantes:** <!-- PREENCHER: nomes e RMs dos integrantes -->
- **Repositório:** https://github.com/victoruizz/sprint-flutter-nutriz
- **Vídeo de navegação:** <!-- PREENCHER: link do vídeo (YouTube/Drive) -->

---

## Objetivo

Demonstrar, num app mobile, os fluxos do produto Nutriz para os três perfis de
usuário — **doadora (nutriz)**, **administrador** e **enfermeiro(a)** — com login
mockado, além da **landing page** pública e do chat mockado com a assistente
**EVA**. O foco é interface, navegação com passagem de parâmetros e dados
realistas do domínio (etapas reais da doação, bairros de São Paulo, conteúdo
educativo real).

---

## Telas

**Público**
1. **Splash** — apresentação com a identidade do produto e botão "Começar".
2. **Landing page** — proposta do produto, "como funciona" (cadastro → kit →
   coleta → distribuição), impacto e chamadas para login/cadastro.
3. **Login** — validação de e-mail/senha e **seletor de perfil** (Doadora,
   Admin, Enfermeiro) para explorar cada área. Qualquer credencial válida entra.
4. **Cadastro** — dados pessoais, endereço, bebê (opcional) e aceite de termos,
   com feedback de sucesso ao concluir.

**Doadora (nutriz)** — navegação inferior + botão flutuante da EVA
5. **Início** — saudação personalizada, doação em andamento (barra de progresso)
   e atalhos.
6. **Minhas doações** — lista das doações com status e progresso.
7. **Detalhe da doação** — recebe a doação por parâmetro; linha do tempo com as
   etapas reais do fluxo Lactare.
8. **Pontos de coleta** — lista com endereço, distância e status.
9. **Detalhe do ponto** — recebe o ponto por parâmetro; dados e "solicitar coleta".
10. **Conteúdo educativo** — lista de artigos por categoria.
11. **Detalhe do artigo** — recebe o artigo por parâmetro; corpo em seções.
12. **EVA (chat mockado)** — sugestões, "digitando" simulado, respostas por
    palavra-chave e aviso de que não substitui avaliação médica.
13. **Perfil** — dados da nutriz, bebê e endereço; sair.

**Administrador** — navegação inferior
14. **Painel** — indicadores (litros captados, satisfação, recorrência, tempo
    médio de resposta) e doações ativas por etapa.
15. **Gestão de doações** — doações de todas as doadoras; abre a linha do tempo.
16. **Usuários** — lista de doadoras/enfermeiros/administradores.
17. **Detalhe do usuário** — recebe o usuário por parâmetro; ativar/desativar.

**Enfermeiro(a)** — navegação inferior
18. **Agendamentos** — visitas/ações com doadora, endereço, etapa e status.
19. **Detalhe do agendamento** — recebe o agendamento por parâmetro; preencher
    relatório.

> Perfil e Splash são reaproveitados entre os perfis conforme o papel logado.

---

## Perfis e logins mockados

Não há autenticação real: **qualquer e-mail válido e senha com 6+ caracteres**
entram. O perfil é escolhido no seletor da tela de login e define a área aberta:

| Perfil | Como entrar | Área |
|--------|-------------|------|
| **Doadora** | e-mail válido + senha (6+) | Início, Doações, Pontos, Conteúdo, Perfil, EVA |
| **Administrador** | selecionar "Admin" no login | Painel, Gestão de doações, Usuários, Perfil |
| **Enfermeiro(a)** | selecionar "Enferm." no login | Agendamentos, Perfil |

Sugestão de credenciais para o vídeo (qualquer uma funciona):
`mariana.alves@email.com` · `123456`.

---

## Prints das telas

<!-- PREENCHER: substituir os placeholders por prints do APP RODANDO no
     emulador/dispositivo. Prints de Figma/protótipo NÃO valem. Sugestão: salvar
     os PNGs em `docs/prints/` e referenciar com Markdown, por exemplo:
     ![Início](docs/prints/inicio.png) -->

| Tela | Print |
|------|-------|
| Splash / Landing | <!-- PREENCHER --> |
| Login (seletor de perfil) | <!-- PREENCHER --> |
| Cadastro + tela de sucesso | <!-- PREENCHER --> |
| Início da doadora | <!-- PREENCHER --> |
| Detalhe da doação (timeline) | <!-- PREENCHER --> |
| Pontos de coleta | <!-- PREENCHER --> |
| Conteúdo / detalhe do artigo | <!-- PREENCHER --> |
| Chat da EVA | <!-- PREENCHER --> |
| Painel do administrador | <!-- PREENCHER --> |
| Agendamentos (enfermeiro) | <!-- PREENCHER --> |

---

## Como executar

Pré-requisito: **Flutter instalado** (canal stable) e um **emulador Android** (ou
dispositivo com depuração USB).

```bash
# 1) Gerar as pastas de plataforma (android/) - o repo traz so o codigo Dart.
#    O nome do projeto e passado explicitamente porque a pasta tem hifens.
flutter create --project-name nutriz_app --platforms=android .

# 2) Baixar as dependencias
flutter pub get

# 3) Conferir que nao ha erros
flutter analyze

# 4) Rodar no emulador/dispositivo
flutter run
```

> O passo 1 apenas cria as pastas de plataforma; ele **não** sobrescreve o código
> em `lib/`, o `pubspec.yaml` nem o `README.md` já existentes.

---

## Estrutura do projeto

```
lib/
├── main.dart                 # ponto de entrada
├── app.dart                  # MaterialApp, tema e rotas
├── core/
│   ├── routes.dart           # nomes de rota centralizados
│   ├── date_format.dart      # formatacao de datas (sem dependencia externa)
│   └── theme/                # cores, espacamentos e tema do produto
├── models/                   # Nutriz, Bebe, Endereco, Doacao, EtapaDoacao,
│                             # PontoColeta, Artigo, MensagemEva, Agendamento...
├── data/                     # dados mockados (mock_doacoes, mock_pontos,
│                             # mock_artigos, mock_eva, mock_usuarios, ...)
├── screens/                  # uma pasta por area (splash, landing, login,
│                             # register, home, donations, points, content,
│                             # eva, profile, adm, nurse)
└── widgets/                  # componentes reutilizaveis (logo, card, badges,
                              # timeline, bolha de chat, chips)
```

- **Flutter puro**, Material Design, sem pacotes de terceiros.
- Gerenciamento de estado simples (`setState`).
- Dados mockados em `lib/data/`, nunca embutidos nas telas.

---

## Observação

App para fins acadêmicos (Sprint FIAP). Todo conteúdo de saúde é informativo e
conservador; a EVA é mockada e não substitui avaliação médica.
