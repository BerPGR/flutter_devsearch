abstract class ProfileEvent {}

class ProfileSortChange extends ProfileEvent {
  final String sortCriteria;

  ProfileSortChange(this.sortCriteria);
}

class ProfileLoadEvent extends ProfileEvent {
  final String username;

  ProfileLoadEvent(this.username);
}

class ProfileLoadMoreEvent extends ProfileEvent {
  final int page;
  final String username;

  ProfileLoadMoreEvent(this.username, this.page);
}
