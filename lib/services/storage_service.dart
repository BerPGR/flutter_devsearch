import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveSearchHistory(List<String> usernames) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', usernames);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('search_history') ?? [];
  }
}