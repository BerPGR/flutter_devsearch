import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_devs/features/home/user_model.dart';
import 'package:search_devs/services/github_service.dart';
import 'package:search_devs/services/storage_service.dart';

class HomeBloc extends Cubit<HomeState> {
  final GithubService githubService;
  final StorageService storageService;

  HomeBloc(this.githubService, this.storageService) : super(HomeInitial());

  void searchUser(String username) async {
    emit(HomeLoading());
    try {
      final user = await githubService.fetchUser(username);

      final history = await storageService.getSearchHistory();
      if (!history.contains(username)) {
        history.add(username);
        await storageService.saveSearchHistory(history);
      }

      emit(HomeLoaded(user));
    } catch (e) {
      emit(HomeError('User not found.'));
    }
  }

  void clearSearch() {
    emit(HomeInitial());
  }
}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserModel user;

  HomeLoaded(this.user);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}