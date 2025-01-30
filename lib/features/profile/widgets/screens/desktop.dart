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

class ProfileDesktop extends StatefulWidget {
  final ProfileBloc profileBloc;
  final UserModel user;
  const ProfileDesktop(
      {super.key, required this.profileBloc, required this.user});

  @override
  State<ProfileDesktop> createState() => _ProfileMobileState();
}

class _ProfileMobileState extends State<ProfileDesktop> {
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildProfileSection(widget.user),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: _buildRepositoryList(
                        _scrollController, state.repositories, context),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildRepositoryList(ScrollController controller,
      List<RepositoryModel> repositories, BuildContext context) {
    final hasReachedMax =
        (context.read<ProfileBloc>().state as ProfileLoaded).hasReachedMax;
    return SingleChildScrollView(
      controller: controller,
      child: Column(
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
      ),
    );
  }

  Widget _buildProfileSection(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 18,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    user.name.split(" ").first,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF171923),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "@${user.username}",
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
        Text(
          user.username,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          user.bio ?? 'Sem biografia',
          style: TextStyle(fontSize: 16),
        ),
        Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                SvgPicture.asset('assets/svgs/followers.svg'),
                Text("${user.followers} seguidores",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                SvgPicture.asset('assets/svgs/following.svg'),
                Text("${user.following} seguindo",
                    style: TextStyle(fontSize: 14))
              ],
            )
          ],
        ),
        Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                          Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/company.svg"),
                  Text(user.company ?? "No company",
                      style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/location.svg"),
                  Text(user.location ?? "No location",
                      style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/email.svg"),
                  Text(user.email ?? "No email", style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/link.svg"),
                  if (user.blog == null || user.blog!.isEmpty)
                    Text("No blog", style: TextStyle(fontSize: 14))
                  else
                    Text(user.blog!, style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/twitter.svg"),
                  if (user.twitterUsername == null ||
                      user.twitterUsername!.isEmpty)
                    Text("No twitter", style: TextStyle(fontSize: 14))
                  else
                    Text(user.twitterUsername!, style: TextStyle(fontSize: 14))
                ],
              ),
          ],
        )
      ],
    );
  }
}
