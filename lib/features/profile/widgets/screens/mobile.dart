
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:search_devs/features/home/user_model.dart';
import 'package:search_devs/features/profile/bloc/profile_bloc.dart';
import 'package:search_devs/features/profile/bloc/profile_event.dart';
import 'package:search_devs/features/profile/bloc/profile_state.dart';
import 'package:search_devs/features/profile/repository_model.dart';
import 'package:search_devs/features/profile/widgets/profile_user_info_mobile.dart';
import 'package:search_devs/utils/date_parser.dart';

class ProfileMobile extends StatefulWidget {
  final ProfileBloc profileBloc;
  final UserModel user;
  const ProfileMobile(
      {super.key, required this.profileBloc, required this.user});

  @override
  State<ProfileMobile> createState() => _ProfileMobileState();
}

class _ProfileMobileState extends State<ProfileMobile> {
  final ScrollController _scrollController = ScrollController();

  int page = 1;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        _onScroll();
      }
    });
  }

  _onScroll() {
    if (!(context.read<ProfileBloc>().state as ProfileLoaded).hasReachedMax) {
      page++;
      Future.delayed(Duration.zero, () {
        context
            .read<ProfileBloc>()
            .add(ProfileLoadMoreEvent(widget.user.username, page));
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de ${widget.user.username}'),
        centerTitle: true,
        backgroundColor: Color(0xFFf2ebff),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else if (state is ProfileLoaded) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileUserInfoMobile(user: widget.user),
                    if (widget.user.blog != null &&
                        widget.user.blog!.isNotEmpty)
                      TextButton(
                        onPressed: () {},
                        child: const Text('Acessar Blog'),
                      ),
                    if (widget.user.twitterUsername != null &&
                        widget.user.twitterUsername!.isNotEmpty)
                      TextButton(
                        onPressed: () {},
                        child: const Text('Acessar Twitter'),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButton<String>(
                        value: state.sortCriteria,
                        onChanged: (value) {
                          widget.profileBloc.add(ProfileSortChange(value!));
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
                    ),
                    _buildRepositoryList(state.repositories, context),
                  ],
                ),
              );
            } 
          return const SizedBox.shrink();
        },
      ),
    );
  }

    Widget _buildRepositoryList(
      List<RepositoryModel> repositories, BuildContext context) {
    final hasReachedMax =
        (context.read<ProfileBloc>().state as ProfileLoaded).hasReachedMax;
    return Column(
      children: [
        ...repositories.map((repo) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repo.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color(0xFF171923),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(repo.description ?? 'Sem descrição',
                        style: const TextStyle(fontSize: 16)),
                    Row(
                      spacing: 8,
                      children: [
                        SvgPicture.asset('assets/svgs/stars.svg'),
                        Text(repo.stars.toString()),
                        const Icon(Icons.circle, size: 6),
                        Text(
                          'Atualizado há ${DateParser.parseUpdatedRepo(repo.updatedAt)} dias',
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFE2E8F0),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        if (hasReachedMax)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Todos os repositórios foram carregados.'),
            ),
          )
        else
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}