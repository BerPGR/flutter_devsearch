import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_devs/features/profile/bloc/profile_event.dart';
import 'package:search_devs/features/profile/bloc/profile_state.dart';
import 'package:search_devs/features/profile/repository_model.dart';
import 'package:search_devs/services/github_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GithubService githubService;

  ProfileBloc(this.githubService) : super(ProfileInitial()) {
    on<ProfileSortChange>((event, emit) {
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        List<RepositoryModel> sortedRepositories =
            List.from(currentState.repositories);

        switch (event.sortCriteria) {
          case 'Created':
            sortedRepositories
                .sort((a, b) => b.createdAt.compareTo(a.createdAt));
            break;
          case 'Stars':
            sortedRepositories.sort((a, b) => b.stars.compareTo(a.stars));
            break;
          case 'Updated':
            sortedRepositories
                .sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
            break;
          default:
            sortedRepositories.sort((a, b) => a.name.compareTo(b.name));
        }

        emit(ProfileLoaded(event.sortCriteria, sortedRepositories));
      }
    });
    on<ProfileLoadEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final repositories =
            await githubService.fetchRepositories(event.username);
        emit(ProfileLoaded('Updated', repositories));
      } catch (e) {
        print(e);
      }
    });
    on<ProfileLoadMoreEvent>((event, emit) async {
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        final currentRepositories = currentState.repositories;
        print(event.page);

        try {
          final newRepositories = await githubService
              .fetchRepositories(event.username, page: event.page);

          if (newRepositories.isEmpty) {
            emit(ProfileLoaded(
              currentState.sortCriteria,
              currentRepositories,
              hasReachedMax: true,
            ));
          } else {
            final updatedRepositories =
                List<RepositoryModel>.from(currentRepositories)
                  ..addAll(newRepositories);

            emit(ProfileLoaded(
              currentState.sortCriteria,
              updatedRepositories,
            ));
          }
        } catch (e) {
          emit(ProfileError('Erro ao carregar mais repositórios'));
        }
      }
    });
  }
}
