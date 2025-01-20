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
---


## 🔧 **Tecnologias Utilizadas**
- **flutter_modular**: Gerenciamento de dependências e navegação.
- **flutter_bloc**: Gerenciador de estados.
- **http**: Consumo da API do GitHub.
- **webview_flutre**: Para abrir links externos.
- **shared_preferences**: Salva as últimas 5 pesquisas de usuários.
- **flutter_svg**: Carrega imagens em formato SVG.


---

## 📝 **Instalar o APK**
<a href="https://github.com/BerPGR/teste_petize_flutter/tree/master/generated/app-release.apk" download>
    <img src="https://img.shields.io/badge/Baixar%20APK-Download-blue?style=for-the-badge" alt="Baixar APK">
</a>

