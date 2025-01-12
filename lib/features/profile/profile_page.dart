import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_devs/features/profile/profile_bloc.dart';
import 'package:search_devs/features/models/repository_model.dart';
import 'package:search_devs/features/models/user_model.dart';
import 'package:search_devs/features/profile/widgets/profile_user_info_mobile.dart';
import 'package:search_devs/services/github_service.dart';
import 'package:search_devs/utils/date_parser.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(GithubService())..loadProfile(user.username),
      child: Scaffold(
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
                    return Column(
                      children: [
                        ProfileUserInfoMobile(user: user),
                        Expanded(
                            child: _buildRepositoryList(state.repositories))
                      ],
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMobile)
                          Expanded(
                            flex: 2,
                            child: _buildProfileSection(user),
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
        Text(user.bio ?? 'No bio available'),
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

  Widget _buildRepositoryList(List<RepositoryModel> repositories) {
    return ListView.builder(
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repo = repositories[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(repo.name),
                Text(repo.description ?? "No description"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    SvgPicture.asset("assets/svgs/stars.svg"),
                    Text(repo.stars.toString()),
                    Icon(Icons.circle, size: 6,),
                    Text("Atualizado há ${DateParser.parseUpdatedRepo(repo.updatedAt)} dias")
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
