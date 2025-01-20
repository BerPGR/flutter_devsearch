import 'package:search_devs/features/profile/repository_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String sortCriteria;
  final List<RepositoryModel> repositories;
  final bool hasReachedMax;

  ProfileLoaded(this.sortCriteria, this.repositories,
      {this.hasReachedMax = false});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
