# Desafio para Vaga de Desenvolvimento Flutter Júnior

Este projeto foi desenvolvido como parte do desafio técnico para a vaga de Desenvolvimento Flutter Júnior. A aplicação permite buscar perfis de desenvolvedores na API pública do GitHub e exibir seus dados em uma página de perfil.

---

## 🎯 **Objetivo do Projeto**
Construir uma aplicação Flutter que permita:
- Pesquisar usuários pelo username do GitHub.
- Exibir os dados do perfil e repositórios do usuário pesquisado.
- Fornecer uma experiência responsiva para desktop e mobile.

---

## 🛠️ **Funcionalidades Implementadas**
### Home Page
- Campo de pesquisa para buscar usuários pelo username do GitHub.
- Exibição de mensagens informativas caso o usuário não seja encontrado.
- Sugestões automáticas no campo de pesquisa com base nos últimos 5 usernames pesquisados.

### Página de Perfil
- Exibição de informações do perfil, incluindo nome, bio, avatar e links para site ou Twitter, caso disponíveis.
- Listagem de repositórios com scroll infinito, carregando 10 repositórios por página.
- Opção para alterar o parâmetro de ordenação dos repositórios.
- Repositórios redirecionam para o repositório original no GitHub.
- Links externos (como site ou Twitter) abrem em uma WebView.

## Estrutura de pastas do projeto

```plaintext
lib/
├── features/
│   ├── home/
│   │   ├── home_bloc.dart
│   │   ├── home_page.dart
│   │   ├── user_model.dart
│   ├── profile/
│       ├── widgets/
│       │   ├── profile_user_info_mobile.dart
│       ├── profile_bloc.dart
│       ├── profile_page.dart
│       ├── repository_model.dart
├── middleware/
│   ├── route_middleware.dart
├── services/
│   ├── github_service.dart
│   ├── storage_service.dart
├── utils/
│   ├── date_parser.dart
├── app_module.dart
├── app_widget.dart
├── main.dart
```

# Descrição das Pastas e Arquivos
O padrão escolhido para organização dos principais arquivos do sistema tem como base o MVC dividido por escopo, com base na documentação do pacote [Flutter Modular](https://modular.flutterando.com.br/docs/intro/)

### `features/`
Contém os recursos principais do aplicativo, organizados por funcionalidade.

### `home/`
- **`home_bloc.dart`**: Gerencia a lógica de negócios para a funcionalidade da página inicial.
- **`home_page.dart`**: Define a interface da página inicial.
- **`user_model.dart`**: Representa o modelo de dados do usuário.

### `profile/`
#### `widgets/`
- **`profile_user_info_mobile.dart`**: Widget específico para exibir informações do perfil no layout mobile.
- **`profile_bloc.dart`**: Gerencia a lógica de negócios para o perfil.
- **`profile_page.dart`**: Define a interface para a página de perfil.
- **`repository_model.dart`**: Contém o modelo de dados para o repositório (provavelmente relacionado ao GitHub ou a outra funcionalidade de armazenamento de dados).

### `middleware/`
Contém middlewares que controlam ou verificam o comportamento de rotas.

- **`route_middleware.dart`**: Define regras ou verificações para navegação entre rotas.

### `services/`
Contém os serviços responsáveis por realizar operações externas ou específicas.

- **`github_service.dart`**: Serviço para integração com a API do GitHub.
- **`storage_service.dart`**: Gerencia operações de armazenamento local ou remoto.

### `utils/`
Contém utilitários ou funções auxiliares reutilizáveis.

- **`date_parser.dart`**: Funções para manipulação e formatação de datas.

## Arquivos na Raiz
- **`app_module.dart`**: Define os módulos principais e a configuração da aplicação.
- **`app_widget.dart`**: Contém o widget principal da aplicação.
- **`main.dart`**: Ponto de entrada do aplicativo.


## 🖌️ **Design**
- **Figma**: Utilizado como base para as telas. O componente de troca de parâmetros foi criado manualmente, seguindo o estilo das páginas do protótipo.
- **Responsividade**: Implementada com `MediaQuery` e widgets como `Row`, `Column`, `Expanded` e `Flexible`.
---


## 🔧 **Tecnologias Utilizadas**
- **Flutter Modular (v5.0.3)**: Gerenciamento de dependências e navegação.
- **Bloc**: Gerenciador de estados.
- **HTTP**: Consumo da API do GitHub.
- **WebView**: Para abrir links externos.
- **Shared Preferences**: Salva as últimas 5 pesquisas de usuários.
- **SVG**: Carrega imagens em formato SVG.

---

## 🚀 **Requisitos Técnicos Atendidos**
- Aplicação responsiva para desktop e mobile. ❌
- Duas rotas nomeadas: ✅
  - **Home**: Página de busca.✅
  - **Profile**: Página do perfil do usuário pesquisado.✅
- Implementação de testes unitários:❌
  - Listagem de usuários.❌
  - Listagem de repositórios.❌
- Versão de Release disponibilizada no formato APK.✅
- Repositório GitHub privado, com o usuário `Greismorr` como colaborador.✅

---

## 🌟 **Diferenciais Implementados**
- **Qualidade do Código** ✅
- **Estratégia de Commits** ✅

---

## 🔗 **Links Úteis**
- [Documentação Flutter Modular](https://modular.flutterando.com.br/docs/intro/)
- [Documentação GitHub API](https://docs.github.com/pt/rest/quickstart?apiVersion=2022-11-28)
- [Documento Teste Dev Flutter](https://docs.google.com/document/d/15IdTi7WWio9NXcI8zI98aVjzd2KULOHDT8yroHCnx54/edit?tab=t.0)
- [Protótipo do Figma](https://www.figma.com/design/dcy0QM6siQVA8qaLzDcLXD/Teste-Petize-(2025)?node-id=0-1&p=f&t=1OtKOUbHJd9dNEGH-0) 

---

## 📝 **Instalar o APK**
<a href="https://github.com/BerPGR/teste_petize_flutter/tree/master/build/app/outputs/flutter-apk/app-release.apk" download>
    <img src="https://img.shields.io/badge/Baixar%20APK-Download-blue?style=for-the-badge" alt="Baixar APK">
</a>

