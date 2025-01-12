class UserModel {
  final String name;
  final String username;
  final String avatarUrl;
  final String bio;
  final int followers;
  final int following;
  final String? company;
  final String? email;
  final String? location;
  final String? blog;
  final String? twitterUsername;

  UserModel({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.followers,
    required this.following,
    this.company,
    this.email,
    this.location,
    this.blog,
    this.twitterUsername,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['login'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'] ?? '',
      followers: json['followers'],
      following: json['following'],
      email: json['email'],
      location: json['location'],
      blog: json['blog'],
      company: json['company'],
      twitterUsername: json['twitter_username'],
    );
  }
}