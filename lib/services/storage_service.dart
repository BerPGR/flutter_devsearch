import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  Future<void> saveSearchHistory(List<String> usernames) async {
    final prefs = await SharedPreferences.getInstance();

    final limitedUsernames = usernames.take(5).toList();
    await prefs.setStringList('search_history', limitedUsernames);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('search_history') ?? [];
  }

  Future<void> addSearchHistory(String username) async {
    final currentHistory = await getSearchHistory();

    if (!currentHistory.contains(username.toLowerCase())) {
      currentHistory.insert(0, username);

      await saveSearchHistory(currentHistory.take(5).toList());
    }
  }
}
