import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_devs/features/profile/repository_model.dart';
import 'package:search_devs/services/github_service.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final GithubService githubService;

  ProfileBloc(this.githubService) : super(ProfileInitial());

  void loadProfile(String username) async {
    emit(ProfileLoading());
    try {
      final repositories = await githubService.fetchRepositories(username);
      emit(ProfileLoaded(repositories));
    } catch (e) {
      emit(ProfileError('Failed to load profile.'));
    }
  }
}

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<RepositoryModel> repositories;

  ProfileLoaded(this.repositories);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}