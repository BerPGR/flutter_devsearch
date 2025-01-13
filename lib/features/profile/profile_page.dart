import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_devs/features/profile/profile_bloc.dart';
import 'package:search_devs/features/profile/repository_model.dart';
import 'package:search_devs/features/home/user_model.dart';
import 'package:search_devs/features/profile/widgets/profile_user_info_mobile.dart';
import 'package:search_devs/services/github_service.dart';
import 'package:search_devs/utils/date_parser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  ProfilePage({required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late WebViewController _webViewController;
  String _sortCriteria = 'Updated';
  int currentPage = 1;
  final int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileBloc(GithubService())..loadProfile(widget.user.username),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perfil de ${widget.user.username}'),
          centerTitle: true,
          backgroundColor: Color(0xFFf2ebff),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;

            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileError) {
                  return Center(child: Text(state.message));
                } else if (state is ProfileLoaded) {
                  if (isMobile) {
                    List<RepositoryModel> sortedRepositories =
                        _sortRepositories(state.repositories);

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileUserInfoMobile(user: widget.user),
                          if (widget.user.blog != null ||
                              widget.user.blog!.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                _webViewController = WebViewController()
                                  ..setJavaScriptMode(
                                      JavaScriptMode.unrestricted)
                                  ..loadRequest(Uri.parse(widget.user.blog!));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(),
                                      body: WebViewWidget(
                                        controller: _webViewController,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Acessar Blog'),
                            ),
                          if (widget.user.twitterUsername != null ||
                              widget.user.twitterUsername!.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                _webViewController = WebViewController()
                                  ..setJavaScriptMode(
                                      JavaScriptMode.unrestricted)
                                  ..loadRequest(Uri.parse("https://twitter.com/${widget.user.twitterUsername}"));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(),
                                      body: WebViewWidget(
                                        controller: _webViewController,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Acessar Twitter'),
                            ),
                          _buildSortDropdown(),
                          _buildRepositoryList(sortedRepositories)
                        ],
                      ),
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMobile)
                          Expanded(
                            flex: 2,
                            child: _buildProfileSection(widget.user),
                          ),
                        if (!isMobile) const SizedBox(width: 20),
                        Expanded(
                          flex: isMobile ? 1 : 3,
                          child: _buildRepositoryList(state.repositories),
                        ),
                      ],
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileSection(UserModel user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        const SizedBox(height: 10),
        Text(
          user.username,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(user.bio ?? 'Sem biografia'),
        const SizedBox(height: 20),
        if (user.blog != null)
          ElevatedButton(
            onPressed: () {},
            child: const Text('Visit Blog'),
          ),
        if (user.twitterUsername != null)
          ElevatedButton(
            onPressed: () {},
            child: const Text('Visit Twitter'),
          ),
      ],
    );
  }

  List<RepositoryModel> _sortRepositories(List<RepositoryModel> repositories) {
    switch (_sortCriteria) {
      case 'Created':
        repositories.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Stars':
        repositories.sort((a, b) => b.stars.compareTo(a.stars));
        break;
      case 'Updated':
        repositories.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      default:
        repositories.sort((a, b) => a.name.compareTo(b.name));
    }
    return repositories;
  }

  Widget _buildSortDropdown() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: _sortCriteria,
        onChanged: (value) {
          setState(() {
            _sortCriteria = value!;
            currentPage = 1;
          });
        },
        items: const [
          DropdownMenuItem(
            value: 'Updated',
            child: Text('Sort by Updated'),
          ),
          DropdownMenuItem(
            value: 'Created',
            child: Text('Sort by Created'),
          ),
          DropdownMenuItem(
            value: 'Name',
            child: Text('Sort by Name'),
          ),
          DropdownMenuItem(
            value: 'Stars',
            child: Text('Sort by Stars'),
          ),
        ].toList(),
      ),
    );
  }

  Widget _buildRepositoryList(List<RepositoryModel> repositories) {
    final totalItems = repositories.length;
    final totalPages = (totalItems / itemsPerPage).ceil();

    final visibleRepositories = repositories
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return Column(
      children: [
        for (var repo in visibleRepositories)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                _webViewController = WebViewController()
                  ..loadRequest(Uri.parse(repo.htmlUrl));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: Text(repo.name)),
                      body: WebViewWidget(
                        controller: _webViewController,
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repo.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF171923),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(repo.description ?? 'Sem descrição',
                        style: TextStyle(fontSize: 16)),
                    Row(
                      spacing: 8,
                      children: [
                        SvgPicture.asset('assets/svgs/stars.svg'),
                        Text(repo.stars.toString()),
                        Icon(Icons.circle, size: 6),
                        Text(
                            'Atualizado há ${DateParser.parseUpdatedRepo(repo.updatedAt)} dias'),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xFFE2E8F0),
                    )
                  ],
                ),
              ),
            ),
          ),
        _buildPaginationControls(totalPages),
      ],
    );
  }

  Widget _buildPaginationControls(int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 1
              ? () {
                  setState(() {
                    currentPage--;
                  });
                }
              : null,
          icon: const Icon(Icons.arrow_back),
        ),
        Text('Página $currentPage de $totalPages'),
        IconButton(
          onPressed: currentPage < totalPages
              ? () {
                  setState(() {
                    currentPage++;
                  });
                }
              : null,
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
