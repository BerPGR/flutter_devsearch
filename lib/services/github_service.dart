import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/models/user_model.dart';
import '../features/models/repository_model.dart';

class GithubService {
  final String baseUrl = 'https://api.github.com';

  Future<UserModel> fetchUser(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('User not found');
    }
  }

  Future<List<RepositoryModel>> fetchRepositories(String username, {String sort = 'updated'}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$username/repos?sort=$sort'),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((repo) => RepositoryModel.fromJson(repo)).toList();
    } else {
      throw Exception('Repositories not found');
    }
  }
}